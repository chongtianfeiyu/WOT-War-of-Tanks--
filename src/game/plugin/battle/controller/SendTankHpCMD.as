package game.plugin.battle.controller
{
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.vo.SendHpVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendTankHpCMD extends SimpleCommand
	{
		public function SendTankHpCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var btp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(btp)
			{
				var vo:SendHpVO = notification.getBody() as SendHpVO;
				btp.setMyHP(vo.hp);
			}
		}
	}
}
