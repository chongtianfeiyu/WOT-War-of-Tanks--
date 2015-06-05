package game.plugin.login.controller
{
	import game.plugin.login.model.LoginProxy;
	import game.plugin.login.model.vo.LoginVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class OnLoginCMD extends SimpleCommand
	{
		public function OnLoginCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var lp:LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			if(lp)
			{
				var vo:LoginVO = notification.getBody() as LoginVO;
				lp.login(vo);
			}
		}
	}
}