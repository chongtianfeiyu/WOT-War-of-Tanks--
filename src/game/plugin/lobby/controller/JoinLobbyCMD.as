package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.LobbyProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class JoinLobbyCMD extends SimpleCommand
	{
		public function JoinLobbyCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var jp:LobbyProxy = facade.retrieveProxy(LobbyProxy.NAME) as LobbyProxy;
			if(jp)
			{
				jp.joinLobby();
			}
		}
	}
}