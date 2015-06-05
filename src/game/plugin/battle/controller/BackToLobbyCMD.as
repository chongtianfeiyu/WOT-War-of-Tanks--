package game.plugin.battle.controller
{
	import game.global.CMD;
	import game.manager.GM;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BackToLobbyCMD extends SimpleCommand
	{
		public function BackToLobbyCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			GM.fun.load.killPlugin(GM.fun.url.getPluginUrl("battle/PluginBattle"));
			facade.sendNotification(CMD.LOAD_LOBBY);
		}
	}
}