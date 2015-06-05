package game.plugin.common.controller
{
	import game.manager.GM;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadLobbyCMD extends SimpleCommand
	{
		public function LoadLobbyCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			GM.fun.load.addPlugin(GM.fun.url.getPluginUrl("lobby/PluginLobby"),"lobby");
			GM.fun.load.startLoad();
		}
	}
}