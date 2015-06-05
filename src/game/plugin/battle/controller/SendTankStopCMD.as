package game.plugin.battle.controller
{
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.vo.SendPosVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class SendTankStopCMD extends SimpleCommand
	{
		public function SendTankStopCMD()
		{
		}
		
		override public function execute(notification:INotification):void
		{
			var bp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(bp)
			{
				var vo:SendPosVO = notification.getBody() as SendPosVO;
				bp.sendStop(vo);
			}
		}
	}
}