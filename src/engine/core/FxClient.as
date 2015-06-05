package engine.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	/**
	 * 继承FxClinet来启动puremvc框架
	 * 继承FxPlugin来制作插件，在插件里注册各种puremvc功能
	 * 继承Mgr来 使用和扩展 管理器
	 */
	public class FxClient extends Sprite
	{
		/**
		 * pureMVC的facade的引用
		 */
		protected var facade:IFacade;
		/**
		 * 网页传递的数据
		 */
		protected var webData:Object;
		
		public function FxClient()
		{
			super();
			
			if(stage==null)
			{
				this.addEventListener(Event.ADDED_TO_STAGE,init);
			}else
			{
				init();
			}
			
		}
		
		private function init(e:Event=null):void
		{
			webData = this.stage.loaderInfo.parameters;
			//初始化mornui
			App.init(this);
			
			//初始化pureMVC框架
			facade = Facade.getInstance();	

			//初始化全局管理类
			o_setupManagers();
			//启动游戏流程
			o_Start();
		}
		
		protected function o_setupManagers():void
		{
			throw new Error("set up managers!");
		}
		
		protected function o_Start():void
		{
			throw new Error("game start!");
		}
		
	}
}