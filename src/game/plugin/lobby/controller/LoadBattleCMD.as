package game.plugin.lobby.controller
{
	import game.global.CMD;
	import game.manager.GM;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadBattleCMD extends SimpleCommand
	{
		public function LoadBattleCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.sendNotification(CMD.NET_LEAVE_LOBBY);
			GM.fun.load.killPlugin(GM.fun.url.getPluginUrl("lobby/PluginLobby"));
			GM.fun.load.addPlugin(GM.fun.url.getPluginUrl("battle/PluginBattle"),"load batle");
			GM.fun.load.startLoad();
		}
	}
}