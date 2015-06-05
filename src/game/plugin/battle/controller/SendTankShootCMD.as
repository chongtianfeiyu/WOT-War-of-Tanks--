package game.plugin.battle.controller
{
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.vo.SendShootVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendTankShootCMD extends SimpleCommand
	{
		public function SendTankShootCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var btp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(btp)
			{
				var vo:SendShootVO = notification.getBody() as SendShootVO;
				btp.sendShoot(vo);
			}
		}
	}
}