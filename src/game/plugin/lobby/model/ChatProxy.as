package game.plugin.lobby.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	
	import game.manager.GM;
	import game.plugin.lobby.model.vo.ChatVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ChatProxy extends Proxy
	{
		public static const NAME:String = "ChatProxy";
		public function ChatProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE,onPublicMsg);	
		}
		//sfs.send(new PublicMessageRequest("Hello everyone!"));
		protected function onPublicMsg(event:SFSEvent):void
		{
			var sender:User = event.params.sender; // sender可能是null  根据加入大厅的先后不同
			var msg:String = event.params.message;
			var vo:ChatVO = new ChatVO();
			vo.sender = sender;
			vo.msg = msg+" "+sender;
			facade.sendNotification(SFSEvent.PUBLIC_MESSAGE,vo);
		}
		
		public function sendChatMsg(msg:String):void
		{
			GM.fun.sfs.send(new PublicMessageRequest(msg,null,GM.fun.sfs.getRoomByName(GM.fun.db.lobbyName)));
		}
		
		override public function onRemove():void
		{
			GM.fun.sfs.removeEventListener(SFSEvent.PUBLIC_MESSAGE,onPublicMsg);	
		}
	}
}