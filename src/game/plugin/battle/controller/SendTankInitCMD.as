package game.plugin.battle.controller
{
	import flash.geom.Point;
	
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.MapProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendTankInitCMD extends SimpleCommand
	{
		public function SendTankInitCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var brp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(brp)
			{
				var mp:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
				if(mp)
				{
					var p:Point = mp.getInitPos();
					brp.setMyPos(p.x,p.y);
				}
				
			}
		}
	}
}