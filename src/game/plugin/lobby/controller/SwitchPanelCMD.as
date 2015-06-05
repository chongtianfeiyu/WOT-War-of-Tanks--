package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.vo.SwitchPanelVO;
	import game.plugin.lobby.view.BagViewMediator;
	import game.plugin.lobby.view.FactoryViewMediator;
	import game.plugin.lobby.view.LobbyViewMediator;
	import game.plugin.lobby.view.StorageViewMediator;
	import game.plugin.lobby.view.TaskViewMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SwitchPanelCMD extends SimpleCommand
	{
		public function SwitchPanelCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var vo:SwitchPanelVO = notification.getBody() as SwitchPanelVO;
			if(vo)
			{
				var lv:LobbyViewMediator = facade.retrieveMediator(LobbyViewMediator.NAME) as LobbyViewMediator;
				if(lv)
				{
					lv.switchTabView(vo.type);
				}
				
				switch(vo.type)
				{
					case SwitchPanelVO.TYPE_STORE:
						var bv:BagViewMediator = facade.retrieveMediator(BagViewMediator.NAME) as BagViewMediator;
						if(bv)
						{
							bv.show();
						}
						break;
					
					case SwitchPanelVO.TYPE_BATTLE:
						
						break;
					
					case SwitchPanelVO.TYPE_FACTORY:
						var fv:FactoryViewMediator = facade.retrieveMediator(FactoryViewMediator.NAME) as FactoryViewMediator;
						if(fv)
						{
							fv.show();
						}
						break;
					
					case SwitchPanelVO.TYPE_STORAGE:
						var sv:StorageViewMediator = facade.retrieveMediator(StorageViewMediator.NAME) as StorageViewMediator;
						if(sv)
						{
							sv.show();
						}
						break;
					
					case SwitchPanelVO.TYPE_TASK:
						
						var tv:TaskViewMediator = facade.retrieveMediator(TaskViewMediator.NAME) as TaskViewMediator;
						if(tv)
						{
							tv.show();
						}
				}
			}
		}
	}
}