package game.plugin.login.controller
{
	/**
	 *
	 * author: FlyCat
	 * version：1.0.0
	 * 创建时间：2014-12-1 下午9:33:51
	 * Email: flycat9@126.com
	 */
	
	
	import game.manager.GM;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadBattlePluginCMD extends SimpleCommand
	{
		public function LoadBattlePluginCMD()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			GM.fun.load.addPlugin(GM.fun.url.getPluginUrl("battle/PluginBattle"),"battle");
			GM.fun.load.startLoad();
			
		}
	}
}