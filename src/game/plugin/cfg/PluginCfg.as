package game.plugin.cfg
{
	import engine.core.FxPlugin;
	
	import game.global.CMD;
	import game.plugin.cfg.controller.SetupCfgCMD;
	import game.plugin.cfg.model.CfgProxy;
	
	public class PluginCfg extends FxPlugin
	{
		public function PluginCfg()
		{
			super();
		}
		
		override protected function o_registerPureMvcAndStart():void
		{
			this.p_registerProxy(new CfgProxy);
			
			this.p_registerCommand(CMD.SET_UP_CONFIG,SetupCfgCMD);
			
			
			this.facade.sendNotification(CMD.SET_UP_CONFIG);
		}
		
	}
}