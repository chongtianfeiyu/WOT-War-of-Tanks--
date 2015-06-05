package game.plugin.login
{
	import engine.core.FxPlugin;
	
	import game.global.CMD;
	import game.plugin.login.controller.OnLoginCMD;
	import game.plugin.login.model.LoginProxy;
	import game.plugin.login.view.LoginViewMediator;

	
	public class PluginLogin extends FxPlugin
	{
		public function PluginLogin()
		{
			super();
		}
		
		override protected function o_registerPureMvcAndStart():void
		{
			this.p_registerMediator(new LoginViewMediator());
			this.p_registerCommand(CMD.NET_LOGIN,OnLoginCMD);
			this.p_registerProxy(new LoginProxy());
			
			this.facade.sendNotification(CMD.SHOW_LOGIN);
			
			this.facade.sendNotification(CMD.REMOVE_LOAD_TIP);
		}
	}
}