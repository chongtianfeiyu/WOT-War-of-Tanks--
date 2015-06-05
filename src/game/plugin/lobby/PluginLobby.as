package game.plugin.lobby
{
	import engine.core.FxPlugin;
	
	import game.global.CMD;
	import game.plugin.lobby.controller.AddItemCMD;
	import game.plugin.lobby.controller.BuyNewTankCMD;
	import game.plugin.lobby.controller.CreateGameRoomCMD;
	import game.plugin.lobby.controller.DestoryTankCMD;
	import game.plugin.lobby.controller.JoinGameCMD;
	import game.plugin.lobby.controller.JoinLobbyCMD;
	import game.plugin.lobby.controller.LeaveGameCMD;
	import game.plugin.lobby.controller.LeaveLobbyCMD;
	import game.plugin.lobby.controller.QuickGameCMD;
	import game.plugin.lobby.controller.SendChatMsgCMD;
	import game.plugin.lobby.controller.SetGameRoomStateCMD;
	import game.plugin.lobby.controller.SetMainTankCMD;
	import game.plugin.lobby.controller.SwitchPanelCMD;
	import game.plugin.lobby.controller.UseItemCMD;
	import game.plugin.lobby.model.BagProxy;
	import game.plugin.lobby.model.ChatProxy;
	import game.plugin.lobby.model.GameRoomsProxy;
	import game.plugin.lobby.model.ItemsProxy;
	import game.plugin.lobby.model.LobbyProxy;
	import game.plugin.lobby.model.UserInfoProxy;
	import game.plugin.lobby.view.BagViewMediator;
	import game.plugin.lobby.view.FactoryViewMediator;
	import game.plugin.lobby.view.LobbyViewMediator;
	import game.plugin.lobby.view.StorageViewMediator;
	import game.plugin.lobby.view.TaskViewMediator;
	import game.ui.lobby.LobbyUI;
	
	public class PluginLobby extends FxPlugin
	{
		public function PluginLobby()
		{
			super();
		}
		
		override protected function o_registerPureMvcAndStart():void
		{
			var view:LobbyUI = new LobbyUI();
			
			this.p_registerMediator(new LobbyViewMediator(view));
			this.p_registerMediator(new FactoryViewMediator(view.factory));
			this.p_registerMediator(new BagViewMediator(view.store));
			this.p_registerMediator(new StorageViewMediator(view.storage));
			this.p_registerMediator(new TaskViewMediator(view.task));
			
			this.p_registerCommand(CMD.NET_JOIN_LOBBY,JoinLobbyCMD);
			this.p_registerCommand(CMD.NET_CREATE_GAME_ROOM,CreateGameRoomCMD);
			this.p_registerCommand(CMD.NET_QUICK_GAME,QuickGameCMD);
			this.p_registerCommand(CMD.NET_JOIN_GAME,JoinGameCMD);
			this.p_registerCommand(CMD.NET_LEAVE_GAME,LeaveGameCMD);
			this.p_registerCommand(CMD.NET_LEAVE_LOBBY,LeaveLobbyCMD);
			this.p_registerCommand(CMD.NET_SEND_CHAT,SendChatMsgCMD);
			this.p_registerCommand(CMD.NET_SET_GAME_STATE,SetGameRoomStateCMD);
			
			this.p_registerCommand(CMD.BUY_NEW_TANK,BuyNewTankCMD);
			this.p_registerCommand(CMD.SET_MAIN_TANK,SetMainTankCMD);
			this.p_registerCommand(CMD.DESTORY_TANK,DestoryTankCMD);
			this.p_registerCommand(CMD.ADD_ITEM,AddItemCMD);
			this.p_registerCommand(CMD.USE_ITEM,UseItemCMD);
			
			this.p_registerCommand(CMD.SWITCH_PANEL,SwitchPanelCMD);
			
			this.p_registerProxy(new LobbyProxy);
			this.p_registerProxy(new GameRoomsProxy);
			this.p_registerProxy(new UserInfoProxy);
			this.p_registerProxy(new ChatProxy);
			this.p_registerProxy(new BagProxy);
			this.p_registerProxy(new ItemsProxy);
			
			facade.sendNotification(CMD.SHOW_LOBBY);
		}
	}
}