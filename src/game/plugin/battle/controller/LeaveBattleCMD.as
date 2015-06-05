package game.plugin.battle.controller
{
	import game.plugin.battle.model.BattleRoomProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LeaveBattleCMD extends SimpleCommand
	{
		public function LeaveBattleCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var brp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(brp)
			{
				brp.leaveBattle();
			}
		}
	}
}