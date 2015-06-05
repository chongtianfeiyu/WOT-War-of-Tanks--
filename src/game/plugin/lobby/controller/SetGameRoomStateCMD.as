package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.GameRoomsProxy;
	import game.plugin.lobby.model.vo.SetGameRoomStateVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetGameRoomStateCMD extends SimpleCommand
	{
		public function SetGameRoomStateCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				var vo:SetGameRoomStateVO = notification.getBody() as SetGameRoomStateVO;
				grp.setGameRoomState(vo);
			}
		}
	}
}