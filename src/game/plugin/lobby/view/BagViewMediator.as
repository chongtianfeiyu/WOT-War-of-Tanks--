package game.plugin.lobby.view
{
	import flash.events.MouseEvent;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.cfg.model.CfgProxy;
	import game.plugin.cfg.model.vo.CfgTankVO;
	import game.plugin.lobby.model.BagProxy;
	import game.plugin.lobby.model.vo.BagTankVO;
	import game.plugin.lobby.model.vo.DestoryTankVO;
	import game.plugin.lobby.model.vo.SetMainTankVO;
	import game.ui.lobby.BagUI;
	import game.ui.lobby.ItemRenderUI;
	import game.utils.FxEffect;
	
	import morn.core.components.Image;
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BagViewMediator extends Mediator
	{
		public static const NAME:String = "BagViewMediator";
		public function BagViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		public function get view():BagUI
		{
			return this.getViewComponent() as BagUI;
		}
		
		override public function listNotificationInterests():Array
		{
			return [CMD.ON_DESTORY_TANK,CMD.ON_SET_MAIN_TANK];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case CMD.ON_DESTORY_TANK:
					
					onDestoryTank();
					
					break;
				
				case CMD.ON_SET_MAIN_TANK:
					
					onSetMainTank();
					
					break;
			}
		}
		
		private function onDestoryTank():void
		{
			showList(false);
			_selectInfo = null;
			showTankInfo();
		}
		
		private function onSetMainTank():void
		{
			showList(false);
			var bp:BagProxy = facade.retrieveProxy(BagProxy.NAME) as BagProxy;
			if(bp)
			{
				var bvo:BagTankVO = bp.getUsedBagTankVO();
				showTankInfo(bvo);
			}
		}
		
		override public function onRegister():void
		{
			view.bag.list.array = [];
			view.bag.list.renderHandler = new Handler(renderList);
			view.btn_main.addEventListener(MouseEvent.CLICK,_setMain);
			view.btn_destory.addEventListener(MouseEvent.CLICK,_destory);
		}
		
		protected function _destory(event:MouseEvent):void
		{
			if(_selectInfo)
			{
				var vo:DestoryTankVO = new DestoryTankVO();
				vo.index = _selectInfo.index;
				facade.sendNotification(CMD.DESTORY_TANK,vo);
			}
		}
		
		protected function _setMain(event:MouseEvent):void
		{
			if(_selectInfo)
			{
				var vo:SetMainTankVO = new SetMainTankVO();
				vo.index = _selectInfo.index;
				facade.sendNotification(CMD.SET_MAIN_TANK,vo);
			}
			
		}
		
		override public function onRemove():void
		{
			view.btn_main.removeEventListener(MouseEvent.CLICK,_setMain);
			view.btn_destory.removeEventListener(MouseEvent.CLICK,_destory);
		}
		
		public function show():void
		{
			this.view.visible = true;
			_selectInfo = null;
			showList(true);
			
			view.bag.list.scrollBar.autoHide = false;
		}
		
		private function showList(first:Boolean):void
		{
			var bp:BagProxy = facade.retrieveProxy(BagProxy.NAME) as BagProxy;
			if(bp)
			{
				var arr:Array = bp.getBagTanks();
				view.bag.list.array = arr;
				if(first)
				{
					if(arr.length)
					{
						var vo:BagTankVO = arr[0];
						showTankInfo(vo);
					}
				}
			}
		}
		
		private function showStar(cell:ItemRenderUI,star:int):void
		{
			var arr:Array = [cell.star0,cell.star1,cell.star2,cell.star3,cell.star4];
			arr = arr.reverse();
			var i:int = 0;
			var len:int = arr.length;
			var s:Image;
			while(i < len)
			{
				s = arr[i];
				i++;
				if(i <= star)
				{
					s.alpha = 1;
				}else
				{
					s.alpha = 0.1;
				}
			}
		}
		
		private function showStar2(star:int):void
		{
			var arr:Array = [view.star0,view.star1,view.star2,view.star3,view.star4];
			arr = arr.reverse();
			var i:int = 0;
			var len:int = arr.length;
			var s:Image;
			while(i < len)
			{
				s = arr[i];
				i++;
				if(i <= star)
				{
					s.alpha = 1;
				}else
				{
					s.alpha = 0.1;
				}
			}
		}
		
		private function renderList(cell:ItemRenderUI, index:int):void
		{
			var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
			if(cp && cell)
			{
				cell.dataSource = null;
				
				var vo:BagTankVO = view.bag.list.array[index];
				if(vo == null)
				{
					return;
				}
				
				var left:String ="";
				
				if(vo.state == 1)
				{
					var info:CfgTankVO = cp.getCfgTankVOById(vo.id);
					if(info)
					{
						var lock:String = "";
						if(vo.main)
						{
							lock = "<font color='#00ff00'>主力战车</font>";
						}else
						{
							lock="";
						}
						
						left = GM.fun.db.getCountry(vo.id);
						
						cell.txt_state.text = lock;
						showStar(cell,vo.star);
						
						cell.stars.visible = true;
						cell.txt_name.visible = true;
						cell.txt_info.visible = false;
						cell.txt_desc.visible = true;
						cell.icon.visible = true;
						cell.txt_state.visible = true;
						
						cell.txt_name.text = "<font color='#666666'>"+info.name+" "+info.type+" "+info.lv+"</font>";

						var desc:String = "\n<font color='#ffffff'>"+
							"生命:"+info.hp+"    "+
							"穿透:"+info.chuan+"    "+
							"杀伤:"+info.attack+"    "+
							"射速:"+info.shoot_rate+"    "+
							"装甲:"+info.armor+"    "+
							"速度:"+info.move_speed+"</font>"
							;
							
						cell.txt_desc.text = desc;
						cell.icon.url = GM.fun.url.getTankIcon(info.id,info.icon);
						
						cell.dataSource = vo;
						
						if(_selectInfo)
						{
							if(vo.index == _selectInfo.index)
							{
								cell.gou_gun.visible = true;
							}else
							{
								cell.gou_gun.visible = false;
							}
						}else
						{
							cell.gou_gun.visible = false;
						}
					}
					
					cell.mouseChildren = false;
					cell.mouseEnabled = true;
					cell.buttonMode = true;
				}else if(vo.state == 0)//空车位
				{
//					cell.txt_state.text = "车位空闲";
					cell.txt_state.visible = false;
					cell.txt_info.visible = false;
					cell.txt_desc.visible = false;
					cell.icon.visible = false;
					cell.gou_gun.visible = false;
					cell.stars.visible = false;
					cell.txt_name.visible = false;
					
					cell.mouseChildren = false;
					cell.mouseEnabled = false;
					
					left = "";
				}
				
				cell.txt_left.text = left;
				
				if(!cell.hasEventListener(MouseEvent.MOUSE_OVER))
				{
					cell.addEventListener(MouseEvent.MOUSE_OVER,_showTip);
					cell.addEventListener(MouseEvent.MOUSE_OUT,_hideTip);
					cell.addEventListener(MouseEvent.CLICK,_showInfo);
				}
				
			}
		}
		
		private var _selectInfo:BagTankVO;
		private function showTankInfo(bvo:BagTankVO=null):void
		{
			if(bvo)
			{
				view.info.visible = true;
				_selectInfo = bvo;
				
				showStar2(bvo.star);
				
				FxEffect.showSelectEffect(view.select_tip);
				
				var cp:CfgProxy = facade.retrieveProxy(CfgProxy.NAME) as CfgProxy;
				if(cp)
				{
					var vo:CfgTankVO = cp.getCfgTankVOById(bvo.id);
					if(vo)
					{
						view.txt_name.text = vo.name;
						view.icon.url = GM.fun.url.getTankIcon(vo.id,vo.icon);
						view.txt_armor.text = "装甲:"+vo.armor;
						view.txt_attack.text = "杀伤:"+vo.attack;
						view.txt_chuan.text = "穿透:"+vo.chuan;
						view.txt_hp.text = "生命:"+vo.hp;
						view.txt_move_speed.text = "速度:"+vo.move_speed;
						view.txt_shoot_rate.text = "射速:"+vo.shoot_rate;
						view.btn_destory.label = "(耐久"+bvo.nai+") 回收战车";
					}
					
					if(bvo.main)
					{
						view.btn_destory.disabled = true;
						view.btn_main.disabled = true;
					}else
					{
						view.btn_destory.disabled = false;
						view.btn_main.disabled = false;
					}
					
					view.skill0.url="";
					view.skill1.url="";
					view.skill2.url="";
					view.skill3.url="";
					
					if(bvo.skill0 != "0")
					{
						
					}
					
					if(bvo.skill1 != "0")
					{
						
					}
					
					if(bvo.skill2 != "0")
					{
						
					}
					
					if(bvo.skill3 != "0")
					{
						
					}
				}
				
			}else
			{
				view.info.visible = false;
			}
			
		}
		
		protected function _showInfo(event:MouseEvent):void
		{
			var cell:ItemRenderUI = event.currentTarget as ItemRenderUI;
			if(cell)
			{
				var vo:BagTankVO = cell.dataSource as BagTankVO;
				if(vo)
				{
					showTankInfo(vo);
					view.bag.list.refresh();
					view.info.visible = true;
				}else
				{
					view.info.visible = false;
				}
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