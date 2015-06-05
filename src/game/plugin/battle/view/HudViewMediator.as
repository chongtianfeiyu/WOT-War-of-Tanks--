package game.plugin.battle.view
{
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.variables.UserVariable;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.battle.model.MapProxy;
	import game.plugin.battle.model.TimeProxy;
	import game.plugin.battle.model.vo.TankKillsVO;
	import game.plugin.cfg.model.CfgProxy;
	import game.plugin.cfg.model.vo.CfgTankVO;
	import game.ui.battle.GameOverUI;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 显示小地图
	 * 战况播报
	 * 战车状况提示
	 */
	public class HudViewMediator extends Mediator
	{
		public static const NAME:String="HudViewMediator";
		public function HudViewMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(NAME, new mcUI);
		}
		
		public function get view():mcUI
		{
			return this.getViewComponent() as mcUI;
		}
		
		override public function onRegister():void
		{
			
		}
		
		override public function onRemove():void
		{
			if(this.view.parent)
			{
				this.view.parent.removeChild(this.view);
			}
		}
		
		public function show():void
		{
			GM.fun.layer.uiLayer.addChild(view);
		}
		
		override public function listNotificationInterests():Array
		{
			return [CMD.UPDATE_MINI_MAP,TimerEvent.TIMER,CMD.GAME_OVER,CMD.TANK_KILLS];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case CMD.UPDATE_MINI_MAP:
					var arr:Array = notification.getBody() as Array;
					updateMiniMap(arr);
					break;
				
				case TimerEvent.TIMER:
					checkTimeView();
//					updateTankList();
					break;
				
				case CMD.GAME_OVER:
					showGameOver();
					break;
				
				case CMD.TANK_KILLS:
					updateTankList();
					break;
			}
		}
		
		private function checkTimeView():void
		{
			var tp:TimeProxy = facade.retrieveProxy(TimeProxy.NAME) as TimeProxy;
			if(tp)
			{
				view.txt_time.text = tp.showTime();
//				if(tp.checkTimeOver())
//				{
//					showGameOver();
//				}
			}
		}
		
		private var ui:GameOverUI;
		private function showGameOver():void
		{
			ui = new GameOverUI();
			GM.fun.layer.popupCenter(ui);
			Mouse.show();
			ui.btn_back.addEventListener(MouseEvent.CLICK,backLobby);
		}
		
		protected function backLobby(event:MouseEvent):void
		{
			ui.btn_back.removeEventListener(MouseEvent.CLICK,backLobby);
			GM.fun.layer.clearLayer(GM.fun.layer.popUpLayer);
			facade.sendNotification(CMD.BACK_TO_LOBBY);
		}
		
		private var map:Shape = new Shape();
		private function updateMiniMap(arr:Array):void
		{
			var i:int = arr.length;
			var tk:mcTank;
			view.miniMap.addChild(map);
			
			map.graphics.clear();
			var mp:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			var ratio:Number = view.miniMap.width/mp.map_width;
			while(i--)
			{
				tk = arr[i];
				if(tk)
				{
					if(GM.fun.sfs.mySelf && tk.name == GM.fun.sfs.mySelf.id+"")
					{
						map.graphics.beginFill(0xffffff);
					}else
					{
						map.graphics.beginFill(0xff0000);
					}
					
					map.graphics.drawCircle(tk.x*ratio,tk.y*ratio,1);
					map.graphics.endFill();
				}
			}
		}
		
		private function updateTankList():void
		{
			var rm:Room = GM.fun.sfs.lastJoinedRoom;
			if(rm)
			{
				var arr:Array = [];
				var users:Array = rm.userList;
				var i:int = users.length;
				var u:User;
				var vo:TankKillsVO;
				var ukl:UserVariable;
				while(i--)
				{
					u = users[i];
					if(u)
					{
						ukl = u.getVariable("kl");
						vo = new TankKillsVO(); 
						vo.user = u;
						if(ukl)
						{
							vo.kills = ukl.getIntValue();
						}else
						{
							vo.kills = 0;
						}
						
						arr.push(vo);
					}
				}
				
				renderRank(arr);
			}
		}
		
		private function renderRank(arr:Array):void
		{
			clearRank();
			
			arr.sortOn("kills",Array.NUMERIC);
			var i:int = arr.length;
			var len:int = arr.length;
			var vo:TankKillsVO;
			var info:mcInfo;
			while(i--)
			{
				vo = arr[i];
				info = view.getChildByName("rank"+i) as mcInfo;
				var unk:UserVariable = vo.user.getVariable("nk");
				var utk:UserVariable = vo.user.getVariable("tk");
				if(unk && utk)
				{
					info.txt_name.text = unk.getStringValue();
					var cfg:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
					var cvo:CfgTankVO = cfg.getCfgTankVOById(utk.getStringValue());
					info.txt_tank.text = cvo.name;
					info.icon.gotoAndStop(""+cvo.type);
				}
				
				info.kills.text = vo.kills+"";
				info.visible = true;
//				info.icon.gotoAndStop(int(info.icon.totalFrames*Math.random()));
//				i++;
			}
			
		}
		
		private function clearRank():void
		{
			var i:int = 10;
			var info:mcInfo;
			while(i--)
			{
				info = view.getChildByName("rank"+i) as mcInfo;
				info.visible = false;
			}
		}
		
		
	}
}