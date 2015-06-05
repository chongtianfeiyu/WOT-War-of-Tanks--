package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.LobbyProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LeaveLobbyCMD extends SimpleCommand
	{
		public function LeaveLobbyCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var lp:LobbyProxy = facade.retrieveProxy(LobbyProxy.NAME) as LobbyProxy;
			if(lp)
			{
				lp.leaveLobby();
			}
		}
	}
}