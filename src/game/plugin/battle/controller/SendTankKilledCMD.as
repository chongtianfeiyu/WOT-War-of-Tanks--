package game.plugin.battle.controller
{
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.vo.SendKilledVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendTankKilledCMD extends SimpleCommand
	{
		public function SendTankKilledCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var brp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(brp)
			{
				var vo:SendKilledVO = notification.getBody() as SendKilledVO;
				brp.beKilledByUser(vo.uid);
			}
		}
	}
}