package game.plugin.common
{
	import engine.core.FxPlugin;
	
	import game.global.CMD;
	import game.plugin.common.controller.ConnectCMD;
	import game.plugin.common.controller.LoadLobbyCMD;
	import game.plugin.common.model.ConnectProxy;
	import game.plugin.common.view.CommonView;
	import game.plugin.lobby.controller.LoadBattleCMD;
	
	
	public class PluginCommon extends FxPlugin
	{
		public function PluginCommon()
		{
			super();
		}
		
		override protected function o_registerPureMvcAndStart():void
		{
			this.p_registerCommand(CMD.LOAD_LOBBY,LoadLobbyCMD);
			this.p_registerCommand(CMD.LOAD_BATTLE,LoadBattleCMD);
			
			this.p_registerCommand(CMD.NET_CONNECT,ConnectCMD);
			
			this.p_registerMediator(new CommonView);
			this.p_registerProxy(new ConnectProxy);
			
		}
	}
}