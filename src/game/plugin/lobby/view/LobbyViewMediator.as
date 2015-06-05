package game.plugin.lobby.view
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.common.model.vo.LoadTipVO;
	import game.plugin.lobby.model.GameRoomsProxy;
	import game.plugin.lobby.model.UserInfoProxy;
	import game.plugin.lobby.model.vo.ChatVO;
	import game.plugin.lobby.model.vo.CreateGameRoomVO;
	import game.plugin.lobby.model.vo.JoinGameVO;
	import game.plugin.lobby.model.vo.SendChatVO;
	import game.plugin.lobby.model.vo.SwitchPanelVO;
	import game.plugin.lobby.model.vo.UserInfoVO;
	import game.ui.lobby.BattleListRenderUI;
	import game.ui.lobby.LobbyUI;
	
	import morn.core.components.Button;
	import morn.core.components.Component;
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	public class LobbyViewMediator extends Mediator
	{
		public static const NAME:String="LobbyViewMediator";
		public function LobbyViewMediator(viewComponent:Object=null)
		{
			super(NAME,viewComponent);
		}
		
		public function get view():LobbyUI
		{
			return this.getViewComponent() as LobbyUI;
		}
		
		override public function onRegister():void
		{
			view.rooms.list.renderHandler = new Handler(renderList);
			view.rooms.list.array = [];
			view.rooms.list.addEventListener(MouseEvent.CLICK,listClick);
			view.btn_send.addEventListener(MouseEvent.CLICK,sendChat);
			view.txt_chat.addEventListener(KeyboardEvent.KEY_DOWN,callSendChat);
			view.tabs.selectHandler = new Handler(tabSelect);
		}
		
		private function tabSelect(index:int):void
		{
//			switchTabView(index);
			var vo:SwitchPanelVO = new SwitchPanelVO();
			vo.type = index;
			this.facade.sendNotification(CMD.SWITCH_PANEL,vo);
		}
		
		public function switchTabView(index:int):void
		{
			view.store.visible = false;
			view.rooms.visible = false;
			view.factory.visible = false;
			view.storage.visible = false;
			view.task.visible = false;
			
			switch(index)
			{
				case 0://战场
					view.rooms.visible = true;
					break;
				
				case 1://车库
					view.store.visible = true;
					break;
				
				case 2://研发
					view.factory.visible = true;
					break;
				
				case 3://仓库
					view.storage.visible = true;
					break;
				
				case 4:
					view.task.visible = true;
					break;
			}
		}
		
		
		protected function callSendChat(event:KeyboardEvent):void
		{
			if(event.charCode == Keyboard.ENTER && view.txt_chat.text.length>0)	
			{
				sendChat();
			}
		}
		
		protected function sendChat(event:MouseEvent=null):void
		{
			var vo:SendChatVO = new SendChatVO();
			vo.msg = GM.fun.db.getDataByKey("nick")+"#"+view.txt_chat.text;
			facade.sendNotification(CMD.NET_SEND_CHAT,vo);
			view.txt_chat.text = "";
		}
		
		override public function onRemove():void
		{
			view.rooms.list.removeEventListener(MouseEvent.CLICK,listClick);
			view.rooms.list.renderHandler = null;
		}
		
		protected function listClick(event:MouseEvent):void
		{
			var render:BattleListRenderUI = event.target.parent.parent.parent as BattleListRenderUI;
			var btn:Button = event.target as Button;
			if(render && btn)
			{
				switch(btn)
				{
					case render.btn_join:
						
						if(render.btn_join.label == "加入")//如果没加入
						{
							var r:Room = render.dataSource as Room;
							if(r)
							{
								joinGame(r.name);
							}
						}else
						{
							leaveGame();
						}
						
						break;
					
					case render.btn_new:
						
						var vo:CreateGameRoomVO = new CreateGameRoomVO();
						vo.map = render.cb_max.selectedLabel;
						vo.max = int(render.cb_max.selectedLabel);
						vo.name = GM.fun.sfs.mySelf.name;
						createNewGameRoom(vo);
						break;
					
//					case render.btn_quick:
//						
//						quickGame();
//						break;
				}
				
			}
		}
		
		private function leaveGame():void
		{
			facade.sendNotification(CMD.NET_LEAVE_GAME);
//			facade.sendNotification(CMD.SHOW_LOBBY);
		}
		
		private function joinGame(name:String):void
		{
			var vo:JoinGameVO = new JoinGameVO();
			vo.name = name;
			facade.sendNotification(CMD.NET_JOIN_GAME,vo);
		}
		
		private function quickGame():void
		{
			facade.sendNotification(CMD.NET_QUICK_GAME);			
		}
		
		private function renderList(item:Component,index:int):void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				var arr:Array = grp.getGameRooms();
				var r:Room = arr[index]; //GM.fun.console.echo("render? ",index);
				var render:BattleListRenderUI = item as BattleListRenderUI;
				if(render)
				{
					if(r)
					{
						render.txt_creator.text = r.name;
						render.txt_id.text = r.id+"";
						render.txt_players.text = r.userCount+"/"+r.maxUsers;
						if(r.userCount < r.maxUsers)
						{
							render.txt_state.text = "准备中";
						}
						
						if(r.getVariable("s"))
						{
							var state:int = r.getVariable("s").getIntValue();
							if(state == 1)
							{
								render.txt_state.text = "战斗中";
								render.btn_join.visible = false;
							}else
							{
								render.btn_join.visible = true;
							}
						}else
						{
							render.btn_join.visible = true;
						}
						
						render.dataSource = r;
						render.view.selectedIndex = 0;
						
						if(r.containsUser(grp.myUser))
						{
							render.btn_join.label = "退出";
							render.btn_join.visible = true;
						}else
						{
							if(joined)
							{
								render.btn_join.visible = false;
							}else
							{
								render.btn_join.visible = true;
								render.btn_join.label = "加入";
							}
						}
					}else //如果没有加入房间就显示快速加入或者创建新房间
					{
//						render.btn_new;
						render.view.selectedIndex = 1;
					}
					
				}
			}
		}
		
		private function createNewGameRoom(vo:CreateGameRoomVO):void
		{
			facade.sendNotification(CMD.NET_CREATE_GAME_ROOM,vo);
			GM.fun.console.echo("create new game room !");
			
		}
		
		override public function listNotificationInterests():Array
		{
			return [CMD.SHOW_LOBBY,SFSEvent.ROOM_GROUP_SUBSCRIBE,SFSEvent.ROOM_REMOVE,SFSEvent.ROOM_ADD,SFSEvent.USER_COUNT_CHANGE,
				CMD.SWITCH_LOBBY,CMD.SWITCH_WAITTING,SFSEvent.PUBLIC_MESSAGE,CMD.ON_DESTORY_TANK,CMD.ON_ITEM_CHANGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case CMD.SHOW_LOBBY:
					show();
					onRoomsListUpdate();
					showLobbyState();
					break;
				
				case SFSEvent.ROOM_GROUP_SUBSCRIBE:
//					getGameRooms();
					updateUserInfo();
					break;
				
				//case SFSEvent.ROOM_ADD:
				case SFSEvent.USER_COUNT_CHANGE:
				case SFSEvent.ROOM_REMOVE:
				case SFSEvent.ROOM_VARIABLES_UPDATE:
					onRoomsListUpdate();
					break;
				
				case CMD.SWITCH_LOBBY:
					showLobbyState();
					break;
				
				case CMD.SWITCH_WAITTING:
					showWaittingState();
					break;
				
				case SFSEvent.PUBLIC_MESSAGE:
					var cvo:ChatVO = notification.getBody() as ChatVO;
					addChatMsg(cvo);
					break;
				
				case CMD.ON_DESTORY_TANK:
				case CMD.ON_ITEM_CHANGE:	
					updateUserInfo();
					break;
					
			}
			
		}
		
		private function addChatMsg(cvo:ChatVO):void
		{
			if(cvo)
			{
				var msg:String = cvo.msg;
				var arr:Array = msg.split("#");
				var nick:String = arr[0];
				var msg2:String = arr[1];
				msg = "<font color='#999999'>["+nick+"]:"+msg2;
				if(view.ta_chat.text.length)
				{
					msg = "\n"+msg;
				}
				
				view.ta_chat.appendText(msg);
				view.ta_chat.scrollTo(view.ta_chat.maxScrollV);
			}
		}
		
		private function showWaittingState():void
		{
//			view.rooms.btn_new.label = "退出房间";
//			view.rooms.btn_quick.visible = false;
//			view.rooms.txt_info.visible = true;
		}
		
		private function showLobbyState():void
		{
//			view.rooms.btn_new.label = "创建房间";
//			view.rooms.btn_quick.visible = true;
//			view.rooms.txt_info.visible = false;
		}
		
		
		private var joined:Boolean;//已经加入了房间
		private function onRoomsListUpdate():void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				var arr:Array = grp.getGameRooms();
				var i:int = 0;
				var len:int = arr.length;
				var r:Room;
				joined = false;
				while(i < len)
				{
					r = arr[i];
					if(r && r.containsUser(grp.myUser))
					{
						if(r.userCount >= r.maxUsers)
						{
//							if(r.name == grp.myUser.name)
//							{
//								var gsvo:SetGameRoomStateVO = new SetGameRoomStateVO();
//								gsvo.state = 1;
//								facade.sendNotification(CMD.NET_SET_GAME_STATE,gsvo);
//							}
							
							facade.sendNotification(CMD.LOAD_BATTLE);
						}
						
						arr.splice(i,1)
						arr.unshift(r);
//						GM.fun.console.echo("[room] ",r.name,r.userCount);
						joined = true;
						break;
					}
					i++;
				}
//				GM.fun.console.echo(arr);
				if(!joined)
				{
					r = null;
					arr.unshift(r);
				}
				view.rooms.list.array = arr;
			}
			
		}
		
		private function getGameRooms():void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				var rooms:Array = grp.getGameRooms();
				GM.fun.console.echo("rooms-> ",rooms);
			}
		}
		
//		[Embed(source = "game/assets/image/lobby.jpg")]
//		private var lobbyClass:Class;	
		
		private function show():void
		{
			GM.fun.layer.sceneLayer.addChild(view);
			joinLobby();
			tabSelect(0);
			GM.fun.sound.playMusic(GM.fun.url.getMusic("music_lobby"),true);
			
			view.rooms.list.scrollBar.autoHide = false;
//			view.ta_chat.scrollBar.autoHide = false;
			
			
			
//			updateUserInfo();
		}
		
		private function updateUserInfo():void
		{
			var tvo:LoadTipVO = new LoadTipVO();
			tvo.msg = "更新玩家数据...";
			facade.sendNotification(CMD.SHOW_LOAD_TIP,tvo);
			
			var uip:UserInfoProxy = facade.retrieveProxy(UserInfoProxy.NAME) as UserInfoProxy;
			if(uip)
			{
				var info:UserInfoVO = uip.getUserInfo();
				if(info)
				{
					view.txt_nick.text = info.nick;
					view.txt_cash.text = "银币:"+info.cash;
					view.txt_gold.text = "金币:"+info.gold+"";
					view.txt_lv.text = uip.getTitle(info.exp);
					view.progress_exp.label = uip.getExpProgress()+"  Lv:"+info.lv;
					view.progress_exp.value = uip.getExpRate();
					view.txt_vip.text = "VIP:"+uip.getVIP();
					view.txt_uid.text = "id:"+info.uid;
				}
			}
			
			this.facade.sendNotification(CMD.REMOVE_LOAD_TIP);
			
		}
		
		private function joinLobby():void
		{
			facade.sendNotification(CMD.NET_JOIN_LOBBY);
			
			var tvo:LoadTipVO = new LoadTipVO();
			tvo.msg = "加入游戏大厅...";
			facade.sendNotification(CMD.SHOW_LOAD_TIP,tvo);
		}
		
	}
}