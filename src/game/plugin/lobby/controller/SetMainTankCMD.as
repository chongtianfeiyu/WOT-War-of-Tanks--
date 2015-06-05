package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.BagProxy;
	import game.plugin.lobby.model.vo.SetMainTankVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetMainTankCMD extends SimpleCommand
	{
		public function SetMainTankCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var bp:BagProxy = facade.retrieveProxy(BagProxy.NAME) as BagProxy;
			if(bp)
			{
				var vo:SetMainTankVO = notification.getBody() as SetMainTankVO;
				if(vo)
				{
					bp.setMainTank(vo.index);
				}
			}
		}
	}
}