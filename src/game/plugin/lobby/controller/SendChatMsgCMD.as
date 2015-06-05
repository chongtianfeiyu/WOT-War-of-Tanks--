package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.ChatProxy;
	import game.plugin.lobby.model.vo.SendChatVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendChatMsgCMD extends SimpleCommand
	{
		public function SendChatMsgCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var cp:ChatProxy = facade.retrieveProxy(ChatProxy.NAME) as ChatProxy;
			if(cp)
			{
				var vo:SendChatVO = notification.getBody() as SendChatVO;
				cp.sendChatMsg(vo.msg);
			}
		}
	}
}