package game.plugin.lobby.model.vo
{
	import com.smartfoxserver.v2.entities.User;

	public class ChatVO
	{
		public function ChatVO()
		{
		}
		
		public var sender:User;
		public var msg:String="";
	}
}