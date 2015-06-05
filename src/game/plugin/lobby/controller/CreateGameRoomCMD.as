package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.GameRoomsProxy;
	import game.plugin.lobby.model.vo.CreateGameRoomVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class CreateGameRoomCMD extends SimpleCommand
	{
		public function CreateGameRoomCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				var vo:CreateGameRoomVO = notification.getBody() as CreateGameRoomVO;
				if(vo)
				{
					grp.createGameRoom(vo);	
				}
			}
		}
	}
}