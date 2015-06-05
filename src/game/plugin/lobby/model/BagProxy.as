package game.plugin.lobby.model
{
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.lobby.model.vo.BagTankVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BagProxy extends Proxy
	{
		public static const NAME:String = "BagProxy";
		public function BagProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.db.usedTankVO = getUsedBagTankVO();
		}
		
		override public function onRemove():void
		{
			
		}
		
		public function destoryTank(index:int):void
		{
			var vo:BagTankVO = getBagTankVoByIndex(index);
			var idx:int = getUsedTankIndex();
			if(index < idx)
			{
				setMainTank(idx-1,false);
			}
			
			var arr:Array = GM.fun.db.getDataByKey("myTanks");
			arr.splice(index,1);
			arr.push("0");
			
			facade.sendNotification(CMD.ON_DESTORY_TANK,vo);
		}
		
		public function setMainTank(index:int,b:Boolean=true):void
		{
			GM.fun.db.setDataByKey("usedTank",index);
			
			var uvo:BagTankVO = getBagTankVoByIndex(index);
			GM.fun.db.usedTankVO = uvo;
			
			if(b)
			{
				facade.sendNotification(CMD.ON_SET_MAIN_TANK);
			}
			
		}
		
		public function getBagTankVoByIndex(index:int):BagTankVO
		{
			var arr:Array = getBagTanks();
			return arr[index];
		}
		
		public function addNewTank(id:String):void
		{
			// id,星级,耐久,技能1,技能2,技能3,技能4
			//"1000,1,100,0,0,0,0"
			var arr:Array = getBagTanks();
			var i:int = 0;
			var len:int = arr.length;
			var data:String = "";
			var info:BagTankVO;
			
			var tanks:Array = GM.fun.db.getDataByKey("myTanks");
			
			while(i < len)
			{
				info = arr[i];
				if(info.state == 0)
				{
					data = id+","+(1+int(Math.random()*5))+",100,0,0,0,0";
					
					tanks[i] = data;
					break;
				}
				
				i++;
			}
		}
		
		public function getBagTanks():Array
		{
			var tanks:Array = GM.fun.db.getDataByKey("myTanks");
			var arr:Array = [];
			var vo:BagTankVO;
			var i:int = 0;
			var len:int = tanks.length;
			var info:String="";
			var sarr:Array;
			while(i < len)
			{
				vo = new BagTankVO();
				info = tanks[i];
				if(info)//如果存在
				{
					if(info == "0")
					{
						vo.state = 0;
					}else
					{
						vo.state = 1;
						
						// id,星级,耐久,技能1,技能2,技能3,技能4
						//"1000,1,100,0,0,0,0"
						sarr = info.split(",");
						vo.id = sarr[0]+"";
						vo.star = int(sarr[1]);
						vo.nai = int(sarr[2]);
						vo.skill0 = sarr[3]+"";
						vo.skill1 = sarr[4]+"";
						vo.skill2 = sarr[5]+"";
						vo.skill3 = sarr[6]+"";
						vo.index = i;
						if(i == getUsedTankIndex())
						{
							vo.main = true;
						}
					}
				}
				
				arr.push(vo);
				
				i++;
			}
			return arr;
		}
		
		public function getUsedTankIndex():int
		{
			var index:int = GM.fun.db.getDataByKey("usedTank");
			return index;
		}
		
		public function getUsedBagTankVO():BagTankVO
		{
			var arr:Array = getBagTanks();
			var index:int = getUsedTankIndex();
			return arr[index];
		}
	}
}