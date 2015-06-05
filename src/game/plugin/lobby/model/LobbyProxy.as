package game.plugin.lobby.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.LeaveRoomRequest;
	import com.smartfoxserver.v2.requests.SubscribeRoomGroupRequest;
	
	import game.manager.GM;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LobbyProxy extends Proxy
	{
		public static const NAME:String="JoinRoomProxy";
		public function LobbyProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_JOIN, onRoomJoined);
			GM.fun.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onRoomJoinError);
		}
		
		protected function onRoomJoined(event:SFSEvent):void
		{
//			GM.fun.console.echo("Room joined successfully: " + event.params.room);	
			var r:Room = event.params.room;
			if(r.name == GM.fun.db.lobbyName)
			{
				lobbyRoom = r;
				facade.sendNotification(SFSEvent.ROOM_GROUP_SUBSCRIBE);
				return;
				//加入大厅后，订阅游戏房间组
				GM.fun.sfs.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE, onGroupSubscribed);
				GM.fun.sfs.addEventListener(SFSEvent.ROOM_GROUP_SUBSCRIBE_ERROR, onGroupSubscribeError);
				
				var req:SubscribeRoomGroupRequest = new SubscribeRoomGroupRequest(GM.fun.db.gameGroupId);
				GM.fun.sfs.send(req);
			}
			
		}
		
		private function onGroupSubscribed(evt:SFSEvent):void
		{
			GM.fun.console.echo("Group subscribed. The following rooms are now accessible: " + evt.params.newRooms);
			facade.sendNotification(SFSEvent.ROOM_GROUP_SUBSCRIBE);
		}
		
		private function onGroupSubscribeError(evt:SFSEvent):void
		{
			GM.fun.console.echo("Group subscription failed: " + evt.params.errorMessage);
		}
		
		protected function onRoomJoinError(event:SFSEvent):void
		{
//			GM.fun.console.echo("Room joining failed: " + event.params.errorMessage);		
		}
		
		public function joinLobby():void
		{
			GM.fun.sfs.send(new JoinRoomRequest(GM.fun.db.lobbyName));
		}
		
		private var lobbyRoom:Room;
		public function leaveLobby():void
		{
			GM.fun.sfs.send(new LeaveRoomRequest(lobbyRoom));
		}
		
		override public function onRemove():void
		{
			
		}
	}
}