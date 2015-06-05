package game.plugin.lobby.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.match.MatchExpression;
	import com.smartfoxserver.v2.entities.match.RoomProperties;
	import com.smartfoxserver.v2.entities.match.StringMatch;
	import com.smartfoxserver.v2.entities.variables.ReservedRoomVariables;
	import com.smartfoxserver.v2.entities.variables.SFSRoomVariable;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.LeaveRoomRequest;
	import com.smartfoxserver.v2.requests.SetRoomVariablesRequest;
	import com.smartfoxserver.v2.requests.SubscribeRoomGroupRequest;
	import com.smartfoxserver.v2.requests.game.QuickJoinGameRequest;
	import com.smartfoxserver.v2.requests.game.SFSGameSettings;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.lobby.model.vo.CreateGameRoomVO;
	import game.plugin.lobby.model.vo.JoinGameVO;
	import game.plugin.lobby.model.vo.SetGameRoomStateVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class GameRoomsProxy extends Proxy
	{
		public static const NAME:String = "GameRoomProxy";
		public function GameRoomsProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_ADD, onRoomCreated);
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_REMOVE, onRoomRemoved);
			GM.fun.sfs.addEventListener(SFSEvent.USER_COUNT_CHANGE,onUserCountChange);
			
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_JOIN, onRoomJoined);
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onRoomJoinError);
			
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, onRoomVarsUpdate);
			
//			someMethod();
		}
		
		private function someMethod():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE, onGroupSubscribed);
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE_ERROR, onGroupSubscribeError);
			
			// Subscribe the "games" group
			GM.fun.sfs.send(new SubscribeRoomGroupRequest("games"));
		}
		
		private function onGroupSubscribed(evt:SFSEvent):void
		{
			trace("Group subscribed. The following rooms are now accessible: " + evt.params.newRooms);
		}
		
		private function onGroupSubscribeError(evt:SFSEvent):void
		{
			trace("Group subscription failed: " + evt.params.errorMessage);
		}
		
		protected function onRoomVarsUpdate(event:SFSEvent):void
		{
			var changedVars:Array = event.params.changedVars as Array;
			var room:Room = event.params.room as Room;
			
			// Check if the "gameStarted" variable was changed
			if (changedVars.indexOf("s") != -1)
			{
				facade.sendNotification(SFSEvent.ROOM_VARIABLES_UPDATE);
//				if (room.getVariable("gameStarted").getBoolValue() == true)
//					trace("Game started");
//				else
//					trace("Game stopped");
			}	
			
			if(changedVars.indexOf(ReservedRoomVariables.RV_GAME_STARTED) != -1)
			{
				GM.fun.console.echo("游戏房间"+room.name+"开始了？ ",room.getVariable(ReservedRoomVariables.RV_GAME_STARTED).getBoolValue());
			}
		}
		
		public function setGameRoomState(vo:SetGameRoomStateVO):void
		{
			// Create some Room Variables
			var roomVars:Array = [];
			roomVars.push(new SFSRoomVariable("s",vo.state));
			
			GM.fun.sfs.send(new SetRoomVariablesRequest(roomVars));
		}
		
		protected function onRoomJoined(event:SFSEvent):void
		{
			GM.fun.console.echo("Room joined successfully: " + event.params.room);	
			var r:Room = event.params.room;
			if(r.name != GM.fun.db.lobbyName)
			{
				facade.sendNotification(CMD.SWITCH_WAITTING);
			}
			
		}
		
		protected function onRoomJoinError(event:SFSEvent):void
		{
			GM.fun.console.echo("Room joining failed: " + event.params.errorMessage);		
		}
		
		protected function onUserCountChange(event:SFSEvent):void
		{
			facade.sendNotification(SFSEvent.USER_COUNT_CHANGE);
		}
		
		override public function onRemove():void
		{
			
		}
		
		protected function onRoomCreated(event:SFSEvent):void
		{
			facade.sendNotification(SFSEvent.ROOM_ADD);
		}
		
		protected function onRoomRemoved(event:SFSEvent):void
		{
			facade.sendNotification(SFSEvent.ROOM_REMOVE);
		}
		
		private function onRoomCreationError(evt:SFSEvent):void
		{
			GM.fun.console.echo("Room creation failed: " + evt.params.errorMessage);
		}
		
		public function get myUser():User
		{
			return GM.fun.sfs.mySelf;
		}
		
		public function quickGame():void
		{
			// Create a matching expression to find a Darts game with a "maxBet" variable less than 100
			var exp:MatchExpression = new MatchExpression(RoomProperties.NAME, StringMatch.STARTS_WITH, "game")
			
			// Search and join a public game within the "games" Group, leaving the last joined Room
			GM.fun.sfs.send(new QuickJoinGameRequest(exp, ["default"],null));
		}
		
		private var gameRoom:String;
		public function leaveGame():void
		{
			var r:Room = GM.fun.sfs.getRoomByName(gameRoom);
			if(r)
			{
				GM.fun.sfs.send(new LeaveRoomRequest(r));
			}
		}
		
		/**
		 * 加入游戏房间
		 */
		public function joinGame(vo:JoinGameVO):void
		{
			gameRoom = vo.name;
			GM.fun.sfs.send(new JoinRoomRequest(vo.name,GM.fun.db.lobbyName));
		}
		
		/**
		 * 创建游戏房间
		 */
		public function createGameRoom(vo:CreateGameRoomVO):void
		{
			// Prepare the settings for a public game
			var settings:SFSGameSettings = new SFSGameSettings(vo.name);
			settings.maxUsers = vo.max;
			settings.maxSpectators = 0;
			settings.isPublic = true;
			settings.minPlayersToStartGame = vo.max;
			settings.notifyGameStarted = true;
			settings.groupId = "default";
			settings.isGame = true;
//			settings.searchableRooms = ["default"];
//			settings.variables = [new SFSRoomVariable(ReservedRoomVariables.RV_GAME_STARTED , false)];
			
			gameRoom = vo.name;
			
			// Set the matching expression for filtering users joining the Room
			//			settings.playerMatchExpression = new MatchExpression("bestScore", NumberMatch.GREATER_THAN, 100);
			
			// Set a Room Variable containing the description of the game
//			settings.variables = [
//				new SFSRoomVariable("map", vo.map)
//			];
			
			GM.fun.sfs.send(new CreateRoomRequest(settings,true));
		}
		
		/**
		 * 获取游戏房间列表
		 */
		public function getGameRooms():Array
		{
			var arr:Array = [];
			var list:Array = GM.fun.sfs.roomList;
			var i:int = list.length;
			var r:Room;
			while(i--)
			{
				r = list[i];
				if(r.name != GM.fun.db.lobbyName)//排除大厅房间
				{
					arr.push(r);
				}
			}
			return arr;
		}
	}
}