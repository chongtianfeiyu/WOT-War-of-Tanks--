package game.plugin.lobby.view
{
	import flash.events.MouseEvent;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.cfg.model.CfgProxy;
	import game.plugin.cfg.model.vo.CfgTankVO;
	import game.plugin.lobby.model.vo.BuyTankVO;
	import game.ui.lobby.FactoryUI;
	import game.ui.lobby.ItemRenderUI;
	import game.utils.FxEffect;
	
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class FactoryViewMediator extends Mediator
	{
		public static const NAME:String = "FactoryViewMediator";
		public function FactoryViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		public function get view():FactoryUI
		{
			return this.getViewComponent() as FactoryUI;
		}
		
		override public function onRegister():void
		{
			view.factory.list.array = [];
			view.factory.list.renderHandler = new Handler(renderList);
			view.btn_buy.addEventListener(MouseEvent.CLICK,_buyTank);
		}
		
		protected function _buyTank(event:MouseEvent):void
		{
			if(_selectInfo)
			{
				var vo:BuyTankVO = new BuyTankVO();
				vo.id = _selectInfo.id;
				facade.sendNotification(CMD.BUY_NEW_TANK,vo);
			}
		}
		
		override public function onRemove():void
		{
			view.btn_buy.removeEventListener(MouseEvent.CLICK,_buyTank);
		}
		
		public function show():void
		{
			this.view.visible = true;
			var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
			if(cp)
			{
//				showTankInfo();
				var arr:Array = cp.getTanks();
				view.factory.list.array = arr;
				
				var info:CfgTankVO = cp.getCfgTankVOByIndex(0);
				if(info)
				{
					showTankInfo(info);
				}
				
				view.factory.list.scrollBar.autoHide = false;
			}
		}
		
		private function renderList(cell:ItemRenderUI, index:int):void
		{
			var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
			if(cp && cell)
			{
				var info:CfgTankVO = cp.getCfgTankVOByIndex(index);
				if(info)
				{
					var lock:String = "";
					if(GM.fun.db.getMyLv() >= info.lock)
					{
						lock = "<font color='#00ff00'>(已解锁)</font>";
					}else
					{
						lock = "<font color='#ff0000'>("+info.lock+"级解锁)</font>";
					}
					
					if(info.lock == 0)
					{
						lock = "<font color='#ffff00'>(金币战车)</font>";
					}
					
					cell.txt_left.text = GM.fun.db.getCountry(info.id)
					cell.txt_name.text = info.name+" "+info.type+" "+info.lv;
					cell.txt_state.text = lock;
					cell.txt_info.text = "生命:"+info.hp+" 装甲:"+info.armor+" 速度:"+info.move_speed+" 杀伤:"+info.attack+" 穿透:"+info.chuan+" 射速:"+info.shoot_rate;
					cell.txt_desc.text = info.desc;
					cell.icon.url = GM.fun.url.getTankIcon(info.id,info.icon);
					
					cell.dataSource = info;
					
					if(!cell.hasEventListener(MouseEvent.MOUSE_OVER))
					{
						cell.addEventListener(MouseEvent.MOUSE_OVER,_showTip);
						cell.addEventListener(MouseEvent.MOUSE_OUT,_hideTip);
						cell.addEventListener(MouseEvent.CLICK,_showInfo);
						cell.buttonMode = true;
					}
					
					if(cell.dataSource == _selectInfo)
					{
						cell.gou_gun.visible = true;
					}else
					{
						cell.gou_gun.visible = false;
					}
					
					cell.stars.visible = false;
				}
			}
		}
		
		private function showTankInfo(vo:CfgTankVO=null):void
		{
			if(vo)
			{
				_selectInfo = vo;
				
				FxEffect.showSelectEffect(view.select_tip);
				
				view.info.visible = true;
				view.txt_name.text = vo.name;
				view.icon.url = GM.fun.url.getTankIcon(vo.id,vo.icon);
				
				view.txt_armor.text = "装甲:"+vo.armor;
				view.txt_attack.text = "杀伤:"+vo.attack;
				view.txt_chuan.text = "穿透:"+vo.chuan;
				view.txt_hp.text = "生命:"+vo.hp;
				view.txt_shoot_rate.text = "射速:"+vo.shoot_rate;
				view.txt_speed.text = "速度:"+vo.move_speed;
				
				view.gun.text = vo.gun+"";
				view.gun_lv.text = vo.gun_lv+"";
				view.ta.text = vo.ta+"";
				view.ta_lv.text = vo.ta_lv+"";
				view.fdj.text = vo.fdj+"";
				view.fdj_lv.text = vo.fdj_lv+"";
				view.dai.text = vo.dai+"";
				view.dai_lv.text = vo.dai_lv+"";
				if(vo.lock == 0)
				{
					view.money.text = "<font color='#ffff00'>消耗金币:"+vo.money+"</font>";
				}else
				{
					view.money.text = "<font color='#ffffff'>消耗银币:"+vo.money+"</font>";
				}
				
				if(vo.rate>70)
				{
					view.rate.text = "<font color='#00ff00'>成功率:"+vo.rate+"%</font>";
				}else if(vo.rate >40)
				{
					view.rate.text = "<font color='#ffff00'>成功率:"+vo.rate+"%</font>";
				}else
				{
					view.rate.text = "<font color='#ff0000'>成功率:"+vo.rate+"%</font>";
				}
				
				if(GM.fun.db.getMyLv() >= vo.lock || vo.lock == 0)
				{
					view.btn_buy.disabled = false;
				}else
				{
					view.btn_buy.disabled = true;
				}
				
			}else
			{
				view.info.visible = false;
			}
			
		}
		
		private var _selectInfo:CfgTankVO;
		protected function _showInfo(event:MouseEvent):void
		{
			var cell:ItemRenderUI = event.currentTarget as ItemRenderUI;
			if(cell)
			{
				var vo:CfgTankVO = cell.dataSource as CfgTankVO;
				showTankInfo(vo);
				view.factory.list.refresh();
			}
		}
		
		protected function _hideTip(event:MouseEvent):void
		{
			var cell:ItemRenderUI = event.currentTarget as ItemRenderUI;
			if(cell)
			{
				cell.over_tip.visible = false;
			}
		}
		
		protected function _showTip(event:MouseEvent):void
		{
			var cell:ItemRenderUI = event.currentTarget as ItemRenderUI;
			if(cell)
			{
				cell.over_tip.visible = true;
			}
		}
	}
}