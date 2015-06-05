package game.plugin.lobby.controller
{
	import game.plugin.lobby.model.GameRoomsProxy;
	import game.plugin.lobby.model.vo.JoinGameVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class JoinGameCMD extends SimpleCommand
	{
		public function JoinGameCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var grp:GameRoomsProxy = facade.retrieveProxy(GameRoomsProxy.NAME) as GameRoomsProxy;
			if(grp)
			{
				var vo:JoinGameVO = notification.getBody() as JoinGameVO;
				grp.joinGame(vo);
			}
		}
	}
}