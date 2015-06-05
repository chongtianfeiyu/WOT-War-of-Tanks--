package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.GameRoomsProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class QuickGameCMD extends SimpleCommand
	{
		public function QuickGameCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				grp.quickGame();
			}
		}
	}
}