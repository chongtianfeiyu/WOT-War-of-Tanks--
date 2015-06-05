package game.plugin.lobby.controller
{
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.cfg.model.CfgProxy;
	import game.plugin.cfg.model.vo.CfgItemVO;
	import game.plugin.common.model.vo.TipVO;
	import game.plugin.common.model.vo.TipsVO;
	import game.plugin.lobby.model.ItemsProxy;
	import game.plugin.lobby.model.vo.AddOrUseItemVO;
	import game.plugin.lobby.model.vo.ItemVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AddItemCMD extends SimpleCommand
	{
		public function AddItemCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var vo:AddOrUseItemVO = notification.getBody() as AddOrUseItemVO;
			if(vo)
			{
				var ip:ItemsProxy = facade.retrieveProxy(ItemsProxy.NAME) as ItemsProxy;
				if(ip)
				{
					var arr:Array = vo.items;
					var i:int = arr.length;
					var item:ItemVO;
					while(i--)
					{
						item = arr[i];
						if(item)
						{
							ip.addOrUseItem(item.id,item.num);
							var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
							var cfg:CfgItemVO = cp.getCfgItemVOById(item.id);
							
							var tipsvo:TipsVO = new TipsVO();
							tipsvo.title = "获得";
							var tvo:TipVO = new TipVO();
							tvo.icon = GM.fun.url.getItemIcon(cfg.icon);
							tvo.num = item.num;
							tvo.width = 60;
							tvo.height = 60;
							tvo.name = cfg.name;
							tvo.des = cfg.des;
							tipsvo.arr = [tvo];
							
							facade.sendNotification(CMD.TIP_GET_ITEMS,tipsvo);
						}
					}
					
					facade.sendNotification(CMD.ON_ITEM_CHANGE);
					
				}
			}
		}
	}
}