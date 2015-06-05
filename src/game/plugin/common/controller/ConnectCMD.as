package game.plugin.common.controller
{
	import game.plugin.common.model.ConnectProxy;
	import game.plugin.common.model.vo.ConnectVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ConnectCMD extends SimpleCommand
	{
		public function ConnectCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var cp:ConnectProxy = facade.retrieveProxy(ConnectProxy.NAME) as ConnectProxy;
			if(cp)
			{
				var vo:ConnectVO = notification.getBody() as ConnectVO;
				cp.connect(vo);
			}
		}
		
	}
}