package game.plugin.lobby.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ChatViewMediator extends Mediator
	{
		public static const NAME:String = "ChatViewMediator";
		public function ChatViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			
		}
		
		override public function onRemove():void
		{
			
		}
	}
}