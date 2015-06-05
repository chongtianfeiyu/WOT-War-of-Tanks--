package game.plugin.cfg.controller
{
	import game.plugin.cfg.model.CfgProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetupCfgCMD extends SimpleCommand
	{
		public function SetupCfgCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
			if(cp)
			{
				cp.setup();
			}
		}
	}
}