package game.plugin.common.view
{
	import com.greensock.TweenMax;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.common.model.vo.LoadTipVO;
	import game.plugin.common.model.vo.PopVO;
	import game.plugin.common.model.vo.TipVO;
	import game.plugin.common.model.vo.TipsVO;
	import game.ui.common.GetRenderUI;
	import game.ui.common.PopUpUI;
	import game.ui.common.TipBoxUI;
	import game.ui.common.TipGetUI;
	
	import morn.core.components.Button;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class CommonView extends Mediator
	{
		public static const NAME:String = "CommonView";
		public function CommonView(mediatorName:String=null, viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [SFSEvent.CONNECTION_LOST,SFSEvent.CONNECTION,CMD.TIP_GET_ITEMS,CMD.SHOW_LOAD_TIP,CMD.REMOVE_LOAD_TIP];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case SFSEvent.CONNECTION_LOST:
					var vo:PopVO = notification.getBody() as PopVO;
					showPop(vo);
					GM.fun.loger.log.echo("connect lost!");
					break;
				
				case SFSEvent.CONNECTION:
					GM.fun.loger.log.echo("connect!"); 
					break;
				
				case CMD.TIP_GET_ITEMS:
					var tipsvo:TipsVO = notification.getBody() as TipsVO;
//					showTips(arr);
					showTipGet(tipsvo);
					break;
				
				case CMD.SHOW_LOAD_TIP:
					var lvo:LoadTipVO = notification.getBody() as LoadTipVO;
					showLoadTip(lvo);
					break;
				
				case CMD.REMOVE_LOAD_TIP:
					removeTip();
					break;
			}
		}
		
		private var loadTip:LoadTip = new LoadTip();
		private function showLoadTip(vo:LoadTipVO):void
		{
			loadTip.txt_tip.mouseEnabled = false;
			GM.fun.layer.popup(loadTip);
			loadTip.txt_tip.text = vo.msg+"";
			loadTip.x = GM.fun.layer.stage.stageWidth*0.5;
			loadTip.y = GM.fun.layer.stage.stageHeight*0.5;
		}
		
		private function removeTip():void
		{
			GM.fun.layer.removeDisplayObject(loadTip);
		}
		
		private var popTipGet:TipGetUI = new TipGetUI();
		private function showTipGet(vo:TipsVO):void
		{
			var t:String = vo.title;
			popTipGet.txt_title.text = t;
			var arr:Array = vo.arr;
			if(arr.length)
			{
				popTipGet.list.scrollBar.autoHide = false;
				popTipGet.list.array = arr;
				popTipGet.list.renderHandler = new Handler(renderList);
				GM.fun.layer.popupCenter(popTipGet);
			}
		}
		
		private function renderList(cell:GetRenderUI,index:int):void
		{
			var arr:Array = popTipGet.list.array;
			if(arr)
			{
				var vo:TipVO = arr[index];
				if(vo)
				{
					var dx:Number=0;
					if(vo.type == "tank")
					{
						cell.icon_item.visible = false;
						cell.icon_tank.visible = true;
						cell.icon_tank.url = vo.icon;
						dx = 114;
					}else
					{
						cell.icon_item.visible = true;
						cell.icon_tank.visible = false;
						cell.icon_item.url = vo.icon;
						dx = 60+20;
					}
					
					cell.txt_name.x = cell.txt_desc.x = dx;
					cell.txt_name.text = vo.name;
					cell.txt_desc.text = vo.des;
					cell.txt_num.text = ""+vo.num;
				}
			}
		}
		
		private var tip:Sprite = new Sprite();
		private var con:Sprite = new Sprite();
		private var txt:Label = new Label("[获得物品]");
		private function showTips(arr:Array):void
		{
			con.removeChildren();
			
			tip.addChild(con);
			GM.fun.layer.popupCenter(tip,false);
			
			var i:int = arr.length;
			var vo:TipVO;
			var img:TipBoxUI;
			while(i--)
			{
				vo = arr[i];
				img = getImag();
				img.width = vo.width;
				img.height = vo.height;
				img.icon.url = vo.icon;
				img.txt_num.text = vo.num+"";
				img.x = i*(img.width+5);
				img.filters = [new GlowFilter(0xffffff)];
				con.addChild(img);
			}
			tip.y = GM.fun.layer.stage.stageHeight ;
			tip.x = 0;
			tip.alpha = 0;
			
			tip.graphics.clear();
			tip.graphics.beginFill(0xffffff,0.2);
			tip.graphics.drawRect(0,0,GM.fun.layer.stage.stageWidth,30+vo.height+10);
			tip.graphics.endFill();
			
			tip.addChild(txt);
			txt.color = 0xffffff;
			txt.x = (GM.fun.layer.stage.stageWidth - txt.width)*0.5;
			
			con.y = 30;
			con.x = (GM.fun.layer.stage.stageWidth - con.width)*0.5;
			
			tip.mouseChildren = false;
			tip.mouseEnabled = false;
			
			TweenMax.killTweensOf(tip);
			TweenMax.to(tip,0.3,{alpha:1,y:"-"+(tip.height+10)});
			TweenMax.to(tip,0.5,{delay:3+0.3,alpha:0});
		}
		
		private var images:Array = [];
		private function getImag():TipBoxUI
		{
			var img:TipBoxUI;
			var i:int = images.length;
			while(i--)
			{
				img = images[i];
				if(!img.parent)
				{
					break;
				}
				
				img = null;
			}
			
			if(img == null)
			{
				img = new TipBoxUI();
				images.push(img);
			}
			
			return img;
		}
		
		private var popView:PopUpUI = new PopUpUI();
		private function showPop(vo:PopVO):void
		{
			Mouse.show();
			popView.txt_msg.text = vo.msg;
			GM.fun.layer.popupCenter(popView);
		}
		
		override public function onRegister():void
		{
			GM.fun.layer.stage.addEventListener(MouseEvent.MOUSE_DOWN,checkDown);
			GM.fun.layer.stage.addEventListener(MouseEvent.MOUSE_OVER,checkOver);
		}
		
		protected function checkDown(event:MouseEvent):void
		{
			var btn:Button = event.target as Button;
			if(btn)
			{
				GM.fun.sound.playSfx(GM.fun.url.getMusic("sfxMouseClick"));
			}else
			{
			}
			
		}
		
		protected function checkOver(event:MouseEvent):void
		{
			var btn:Button = event.target as Button;
			if(btn)
			{
//				GM.fun.sound.playSfx(GM.fun.url.getMusic("sfxMouseOver"));//开炮音效
			}
		}
		
		override public function onRemove():void
		{
			
		}
	}
}