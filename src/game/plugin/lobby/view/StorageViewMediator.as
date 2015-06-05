package game.plugin.lobby.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.lobby.model.ItemsProxy;
	import game.plugin.lobby.model.vo.AddOrUseItemVO;
	import game.plugin.lobby.model.vo.ItemVO;
	import game.ui.lobby.StorageRenderUI;
	import game.ui.lobby.StorageUI;
	import game.ui.lobby.StoreInfoUI;
	import game.utils.FxArray;
	
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class StorageViewMediator extends Mediator
	{
		public static const NAME:String = "StorageViewMediator";
		public function StorageViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		public function get view():StorageUI
		{
			return this.getViewComponent() as StorageUI;
		}
		
		override public function listNotificationInterests():Array
		{
			return [CMD.ON_ITEM_CHANGE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case CMD.ON_ITEM_CHANGE:
					showList();
					break;
			}
		}
		
		override public function onRegister():void
		{
			view.list.array = [];
			view.list.renderHandler = new Handler(renderList);
			view.btn_add.addEventListener(MouseEvent.CLICK,addItem);
		}
		
		protected function addItem(event:MouseEvent):void
		{
			var arr:Array = ["1000","1001","1002",
							 "2000","2001","2002",
							 "3000","3001","3002",
							 "4000","4001","4002",
							 "5000","5001","5002",
							 "6000","6001","6002",
							 "6010","6011","6012",
							 "6020"
			];
			
			var item:ItemVO = new ItemVO();
			item.id = ""+FxArray.fetchArrElement(arr);
			item.num = 1;
			
			GM.fun.console.echo("add item ",item.id);
			
			var vo:AddOrUseItemVO = new AddOrUseItemVO();
			vo.items = [item];
			
			facade.sendNotification(CMD.ADD_ITEM,vo);
		}
		
		override public function onRemove():void
		{
			
		}
		
		private function renderList(cell:StorageRenderUI, index:int):void
		{
			var arr:Array = view.list.array;
			var info:ItemVO = arr[index];
			if(info && cell)
			{
				cell.txt_num.text = info.num+"";
				cell.txt_name.text = info.cfg.name;
				cell.txt_desc.text = info.cfg.des;
				cell.icon.url = GM.fun.url.getItemIcon(info.cfg.icon);
				cell.dataSource = info;
				
				if(!cell.hasEventListener(MouseEvent.MOUSE_OVER))
				{
					cell.addEventListener(MouseEvent.CLICK,showStoreInfo);
					cell.addEventListener(MouseEvent.MOUSE_OVER,_showTip);
					cell.addEventListener(MouseEvent.MOUSE_OUT,_hideTip);
					cell.buttonMode = true;
				}
			}
		}
		
		protected function _hideTip(event:MouseEvent):void
		{
			var cell:StorageRenderUI = event.currentTarget as StorageRenderUI;
			if(cell)
			{
				cell.over_tip.visible = false;
			}
		}
		
		protected function _showTip(event:MouseEvent):void
		{
			var cell:StorageRenderUI = event.currentTarget as StorageRenderUI;
			if(cell)
			{
				cell.over_tip.visible = true;
			}
		}
		
		private var storeInfo:StoreInfoUI = new StoreInfoUI();
		protected function showStoreInfo(event:MouseEvent):void
		{
			var cell:StorageRenderUI = event.currentTarget as StorageRenderUI;
			if(cell)
			{
				var info:ItemVO = cell.dataSource as ItemVO;
				GM.fun.layer.popupCenter(storeInfo);
				storeInfo.txt_desc.text = info.cfg.des;
				storeInfo.txt_name.text = info.cfg.name;
				storeInfo.txt_num.text = info.num+"";
				storeInfo.txt_num2.text = info.num+"";
				storeInfo.icon.url = GM.fun.url.getItemIcon(info.cfg.icon);
				storeInfo.dataSource = info;
				
				checkNumOk();
				
				if(info.id.charAt() == "6")
				{
					storeInfo.btn_use.label = "使用";
				}else
				{
					storeInfo.btn_use.label = "卖出";
				}
				
				storeInfo.btn_use.addEventListener(MouseEvent.CLICK,useItem);
				storeInfo.btn_jian.addEventListener(MouseEvent.CLICK,jianNum);
				storeInfo.btn_jia.addEventListener(MouseEvent.CLICK,jiaNum);
				storeInfo.txt_num2.addEventListener(Event.CHANGE,checkNumOk);
				storeInfo.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveInfo);
			}
		}
		
		protected function useItem(event:MouseEvent):void
		{
			GM.fun.layer.removeDisplayObject(storeInfo);
			
			var num:int = Number(storeInfo.txt_num2.text);
			var info:ItemVO = storeInfo.dataSource as ItemVO;
			
//			GM.fun.console.echo("使用物品 ",info.id,info.cfg.name,num);
			
			var vo:ItemVO = new ItemVO();
			vo.id = info.id;
			vo.num = -num;
			var vo2:AddOrUseItemVO = new AddOrUseItemVO();
			vo2.items = [vo];
			facade.sendNotification(CMD.USE_ITEM,vo2);
		}
		
		protected function onRemoveInfo(event:Event):void
		{
			storeInfo.btn_use.removeEventListener(MouseEvent.CLICK,useItem);
			storeInfo.btn_jian.removeEventListener(MouseEvent.CLICK,jianNum);
			storeInfo.btn_jia.removeEventListener(MouseEvent.CLICK,jiaNum);
			storeInfo.txt_num2.removeEventListener(Event.CHANGE,checkNumOk);
			storeInfo.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveInfo);			
		}
		
		protected function jiaNum(event:MouseEvent):void
		{
			var num:int = Number(storeInfo.txt_num2.text);
			num++;
			storeInfo.txt_num2.text = num+"";
			checkNumOk();
		}
		
		protected function jianNum(event:MouseEvent):void
		{
			var num:int = Number(storeInfo.txt_num2.text);
			num--;
			storeInfo.txt_num2.text = num+"";
			checkNumOk();			
		}
		
		private function checkNumOk(event:Event=null):void
		{
			var info:ItemVO = storeInfo.dataSource as ItemVO;
			var num:int = Number(storeInfo.txt_num2.text);
			if(num >= info.num)
			{
				num = info.num;
				storeInfo.btn_jia.disabled = true;
			}else
			{
				storeInfo.btn_jia.disabled = false;
			}
			
			if(num <= 1)
			{
				num = 1;
				storeInfo.btn_jian.disabled = true;
			}else
			{
				storeInfo.btn_jian.disabled = false;
			}
			
			storeInfo.txt_num2.text = num+"";
		}
		
		public function show():void
		{
			view.visible = true;
			showList();
			view.list.scrollBar.autoHide = false;
		}
		
		private function showList():void
		{
			var ip:ItemsProxy = facade.retrieveProxy(ItemsProxy.NAME) as ItemsProxy;
			if(ip)
			{
				var arr:Array = ip.getItems();
				view.list.array = arr;
			}
			
		}
	}
}