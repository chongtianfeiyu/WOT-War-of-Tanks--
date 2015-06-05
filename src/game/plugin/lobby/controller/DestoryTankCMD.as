package game.plugin.lobby.controller
{
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.common.model.vo.TipVO;
	import game.plugin.common.model.vo.TipsVO;
	import game.plugin.lobby.model.BagProxy;
	import game.plugin.lobby.model.vo.DestoryTankVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class DestoryTankCMD extends SimpleCommand
	{
		public function DestoryTankCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var bp:BagProxy = facade.retrieveProxy(BagProxy.NAME) as BagProxy;
			if(bp)
			{
				var silver:int = GM.fun.db.getDataByKey("silver");
				silver += 100;
				GM.fun.db.setDataByKey("silver",silver);
				
				var dvo:DestoryTankVO = notification.getBody() as DestoryTankVO;
				bp.destoryTank(dvo.index);
				
				var tipsvo:TipsVO = new TipsVO();
				tipsvo.title = "获得";
				
				var tvo:TipVO = new TipVO();
				tvo.icon = GM.fun.url.getItemIcon("silver");
				tvo.num = 100;
				tvo.width = 60;
				tvo.height = 60;
				tvo.name = "银币";
				tvo.des = "用来制造战车和购买道具";
				
				tipsvo.arr = [tvo];
				facade.sendNotification(CMD.TIP_GET_ITEMS,tipsvo);
			}
		}
	}
}