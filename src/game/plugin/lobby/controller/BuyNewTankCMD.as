package game.plugin.lobby.controller
{
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.cfg.model.CfgProxy;
	import game.plugin.cfg.model.vo.CfgItemVO;
	import game.plugin.cfg.model.vo.CfgTankVO;
	import game.plugin.common.model.vo.TipVO;
	import game.plugin.common.model.vo.TipsVO;
	import game.plugin.lobby.model.BagProxy;
	import game.plugin.lobby.model.ItemsProxy;
	import game.plugin.lobby.model.vo.BuyTankVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BuyNewTankCMD extends SimpleCommand
	{
		public function BuyNewTankCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var bp:BagProxy = facade.retrieveProxy(BagProxy.NAME) as BagProxy;
			if(bp)
			{
				var vo:BuyTankVO = notification.getBody() as BuyTankVO;
				if(vo)
				{
					bp.addNewTank(vo.id);
					
					var bullets:int = 10;
					var ip:ItemsProxy = facade.retrieveProxy(ItemsProxy.NAME) as ItemsProxy;
					if(ip)
					{
						ip.addOrUseItem("5000",bullets);
						ip.addOrUseItem("5001",bullets);
						ip.addOrUseItem("5002",bullets);
					}
					
					var tipsvo:TipsVO = new TipsVO();
					tipsvo.title = "获得";
					var tips:Array = [];
					
					var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
					var cfg:CfgTankVO = cp.getCfgTankVOById(vo.id);
					var tip:TipVO = new TipVO();
					tip.icon = GM.fun.url.getTankIcon(cfg.id,cfg.icon);
					tip.num = 1;
					tip.width = 160;
					tip.height = 100;
					tip.name = cfg.name;
					tip.des = cfg.desc;
					tip.type = "tank";
					
					tips.push(tip);
					
					var arr:Array = ["5000","5001","5002"];
					var i:int = arr.length;
					var cfgIm:CfgItemVO;
					var id:String="";
					while(i--)
					{
						id = arr[i];
						cfgIm = cp.getCfgItemVOById(id);
						tip = new TipVO();
						tip.icon = GM.fun.url.getItemIcon(cfgIm.icon);
						tip.des = cfgIm.des;
						tip.name = cfgIm.name;
						tip.num = bullets;
						tips.push(tip);
					}
					
					tipsvo.arr = tips;
					
					facade.sendNotification(CMD.TIP_GET_ITEMS,tipsvo);
				}
				
			}
		}
	}
}