package game.plugin.battle
{
	/**
	 *
	 * author: FlyCat
	 * version：1.0.0
	 * 创建时间：2014-12-1 下午9:11:28
	 * Email: flycat9@126.com
	 */
	
	import engine.core.FxPlugin;
	
	import game.global.CMD;
	import game.plugin.battle.controller.BackToLobbyCMD;
	import game.plugin.battle.controller.LeaveBattleCMD;
	import game.plugin.battle.controller.SendTankHpCMD;
	import game.plugin.battle.controller.SendTankInitCMD;
	import game.plugin.battle.controller.SendTankKilledCMD;
	import game.plugin.battle.controller.SendTankMoveCMD;
	import game.plugin.battle.controller.SendTankShootCMD;
	import game.plugin.battle.controller.SendTankStopCMD;
	import game.plugin.battle.controller.ShowBattleViewCMD;
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.MapProxy;
	import game.plugin.battle.model.TimeProxy;
	import game.plugin.battle.view.HudViewMediator;
	import game.plugin.battle.view.MapViewMediator;
	
	public class PluginBattle extends FxPlugin
	{
		public function PluginBattle()
		{
			super();
		}
		
		override protected function o_registerPureMvcAndStart():void
		{
			this.p_registerMediator(new MapViewMediator);
			this.p_registerMediator(new HudViewMediator);
			
			this.p_registerProxy(new MapProxy);
			this.p_registerProxy(new BattleRoomProxy);
			this.p_registerProxy(new TimeProxy);
			
			this.p_registerCommand(CMD.SHOW_BATTLE,ShowBattleViewCMD);
			this.p_registerCommand(CMD.NET_SEND_INIT,SendTankInitCMD);
			this.p_registerCommand(CMD.NET_SEND_MOVE,SendTankMoveCMD);
			this.p_registerCommand(CMD.NET_SEND_STOP,SendTankStopCMD);
			this.p_registerCommand(CMD.NET_SEND_SHOOT,SendTankShootCMD);
			this.p_registerCommand(CMD.NET_SEND_HP,SendTankHpCMD);
			this.p_registerCommand(CMD.NET_SEND_KILLED,SendTankKilledCMD);
			this.p_registerCommand(CMD.BACK_TO_LOBBY,BackToLobbyCMD);
			this.p_registerCommand(CMD.GAME_OVER,LeaveBattleCMD);
			
			this.facade.sendNotification(CMD.SHOW_BATTLE);
			
			this.facade.sendNotification(CMD.REMOVE_LOAD_TIP);
		}	
			
	}
}