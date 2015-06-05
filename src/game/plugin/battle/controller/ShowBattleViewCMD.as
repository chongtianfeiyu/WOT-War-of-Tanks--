package game.plugin.battle.controller
{
	import flash.geom.Point;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.battle.model.BattleRoomProxy;
	import game.plugin.battle.model.MapProxy;
	import game.plugin.battle.model.TimeProxy;
	import game.plugin.battle.view.HudViewMediator;
	import game.plugin.battle.view.MapViewMediator;
	import game.plugin.lobby.model.vo.BagTankVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowBattleViewCMD extends SimpleCommand
	{
		public function ShowBattleViewCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var tvm:MapViewMediator = facade.retrieveMediator(MapViewMediator.NAME) as MapViewMediator;
			if(tvm)
			{
				tvm.show();
			}
			
			var hud:HudViewMediator = facade.retrieveMediator(HudViewMediator.NAME) as HudViewMediator;
			if(hud)
			{
				hud.show();
			}
			
			var tp:TimeProxy = facade.retrieveProxy(TimeProxy.NAME) as TimeProxy;
			if(tp)
			{
				tp.start();
			}
			
			var bp:BattleRoomProxy = facade.retrieveProxy(BattleRoomProxy.NAME) as BattleRoomProxy;
			if(bp)
			{
				bp.checkTanksExist();
				var mp:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
				if(mp)
				{
					var p:Point = mp.getInitPos();
					var nick:String = GM.fun.db.getDataByKey("nick");
					var bvo:BagTankVO = GM.fun.db.usedTankVO;
					bp.setInBattle(bvo.id,nick,p.x,p.y);
				}	
				
			}
			
//			facade.sendNotification(CMD.NET_SEND_INIT);
			
		}
	}
}