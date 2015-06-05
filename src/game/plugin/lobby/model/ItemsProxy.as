package game.plugin.lobby.model
{
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.cfg.model.CfgProxy;
	import game.plugin.cfg.model.vo.CfgItemVO;
	import game.plugin.lobby.model.vo.ItemVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ItemsProxy extends Proxy
	{
		public static const NAME:String = "ItemsProxy";
		public function ItemsProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			
		}
		
		override public function onRemove():void
		{
			
		}
		
		/**
		 * num 为负数 就是 使用物品
		 */
		public function addOrUseItem(id:String,num:Number):void
		{
			var items:Array = GM.fun.db.getDataByKey("items");
			var i:int = 0;
			var len:int = items.length;
			var s:String="";
			
			var item:ItemVO = getItemVOById(id);
			var arr:Array;
			var count:Number=0;
			while(i < len)
			{
				s = items[i];
				arr = s.split(",");
				if(arr[0] == id)
				{
					count = Number(arr[1]);
					count += num;
					
					if(num < 0)
					{
						checkUseItem(id,-num);
					}
					
					if(count <= 0)
					{
						removeItem(i);
					}else
					{
						s = id+","+count;
						items[i] = s;
					}
					
					break;
				}
				
				s = "";
				i++;
			}
			
			if(s == "")
			{
				s = id+","+num;
				items.push(s);
			}
		}
		
		private function checkUseItem(id:String, num:Number):void
		{
			GM.fun.console.echo("使用物品 ",id,num);
			var idd:Number = Number(id);
			if(idd >= 6000 && idd <= 6009)//银币
			{
				var silver:int = GM.fun.db.getDataByKey("silver");
				silver += 100*num;
				GM.fun.db.setDataByKey("silver",silver);
			}else if(idd >= 6010 && idd <= 6019)//金币
			{
				var gold:int = GM.fun.db.getDataByKey("gold");
				gold += 100*num;
				GM.fun.db.setDataByKey("gold",gold);
			}else if(idd >= 6020 && idd <= 6029)//礼包
			{
				
			}else
			{
				
			}
			
			facade.sendNotification(CMD.ON_ITEM_CHANGE);
		}
		
		public function removeItem(index:int):void
		{
			var items:Array = GM.fun.db.getDataByKey("items");
			items.splice(index,1);
		}
		
		public function getItemVOById(id:String):ItemVO
		{
			var items:Array = getItems();
			var i:int = 0;
			var len:int = items.length;
			var item:ItemVO;
			while(i < len)
			{
				item = items[i];
				if(item.id == id)
				{
					break;
				}
				item = null;
				i++;
			}
			
			return item;
		}
		
		public function getItems():Array
		{
			var carr:Array = GM.fun.db.getDataByKey("items");
			if(!carr)
			{
				return [];
			}
			var i:int = 0;
			var len:int = carr.length;
			var item:ItemVO;
			var cfg:CfgItemVO;
			var s:String = "";
			var tarr:Array;
			var items:Array = [];
			var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
			while(i < len)
			{
				s = carr[i];
				if(s.length)
				{
					item = new ItemVO();
					tarr = s.split(",");
					item.id = tarr[0]+"";
					item.num = Number(tarr[1]);
					cfg = cp.getCfgItemVOById(item.id);
					item.cfg = cfg;
					
					items.push(item);
				}
				
				i++;
			}
			
			items.sortOn("id",Array.NUMERIC | Array.DESCENDING);
			
			return items;
			
		}
	}
}