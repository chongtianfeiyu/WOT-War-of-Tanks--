package engine.manager.layer
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * 游戏的layer管理
	 */
	public class LayerManager
	{
		
		public function LayerManager()
		{
		}
		
		public function setup(s:Stage):void
		{
			_stage = s;
			
			_sceneLayer = createLayer("scene_layer");
			_uiLayer = createLayer("ui_layer");
			_popUpLayer = createLayer("pop_layer");
			
			_stage.addChild(_sceneLayer);
			_stage.addChild(_uiLayer);
			_stage.addChild(_popUpLayer);
			
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align= StageAlign.TOP_LEFT;
		}
		
		public function createLayer(name:String):Sprite
		{
			var layer:Sprite = new Sprite();
			layer.mouseEnabled = false;
			layer.name = name;
			
			return layer;
		}
		
		private var _popUpLayer:Sprite;
		/**
		 * 所有弹出层管理容器 和UI层区分开来
		 * @return 
		 * 
		 */		
		public function get popUpLayer():Sprite
		{
			return _popUpLayer;
		}
		
		private var _uiLayer:Sprite;
		public function get uiLayer():Sprite
		{
			return _uiLayer;
		}
		
		private var _sceneLayer:Sprite;
		public function get sceneLayer():Sprite
		{
			return _sceneLayer;
		}
		
		private var _stage:Stage;
		public function get stage():Stage
		{
			return _stage;
		}
		
		public function popup(view:DisplayObject):void
		{
			_popUpLayer.addChild(view);
		}
		
		private var myShadow:Sprite;
		private var shandowPops:Array = [];
		/**
		 *  屏幕中心显示 
		 * @param view:显示对象，isShodow:是否有背景阴影
		 * 
		 */		
		public function popupCenter(view:DisplayObject,isShadow:Boolean=true):void
		{
			if(isShadow)
			{
				if(myShadow == null)
				{
					myShadow=new Sprite();
					myShadow.graphics.beginFill(0x000000,1);
					myShadow.graphics.drawRect(0,0,_stage.stageWidth,_stage.stageHeight);
					myShadow.graphics.endFill();
				}
				shandowPops.push(view);
				view.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
				popUpLayer.addChildAt(myShadow,0);
				myShadow.alpha = 0;
				TweenMax.killTweensOf(myShadow);
				TweenMax.to(myShadow,0.3,{alpha:0.8});
			}
			
			popUpLayer.addChild(view);
			view.x=(_stage.stageWidth-view.width)>>1;
			view.y=(_stage.stageHeight-view.height)>>1;
			
			if(view.width>1000)
			{
				view.x=(_stage.stageWidth-1000)>>1;
			}
			
			if(view.height>600)
			{
				view.y=(_stage.stageHeight-600)>>1;
			}
		}
		
		protected function onRemove(event:Event):void
		{
			var view:DisplayObject = event.currentTarget as DisplayObject;
			if(view)
			{
				view.removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
				
				var index:int = shandowPops.indexOf(view);
				shandowPops.splice(index,1);
				if(shandowPops.length == 0)
				{
					if(myShadow.parent)
					{
						myShadow.parent.removeChild(myShadow);
					}
				}
			}
			
		}
		
		/**
		 * 删除舞台上的显示对象
		 */
		public function removeDisplayObject(d:DisplayObject):void
		{
			if(d&&d.parent)
			{
				d.parent.removeChild(d);
			}
			
		}
		
		/**
		 * 删除当前所有的弹窗 
		 * 
		 */		
		public function closeAll():void
		{
			while(popUpLayer.numChildren)
			{
				popUpLayer.removeChildAt(0);
			}
			myShadow=null;
		}

		public function resizeShadow():void{
		}
		
		public function clearLayer(layer:Sprite):void
		{
			while(layer.numChildren)
			{
				layer.removeChildAt(0);
			}
		}
	}
}