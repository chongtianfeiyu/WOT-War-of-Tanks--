package game
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import engine.core.FxClient;
	import engine.manager.loader.LoadEvent;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.common.model.vo.LoadTipVO;
	
	[SWF(width="980",height="700",frameRate="30",backgroundColor="#000000")]
	public class Client extends FxClient
	{
		public function Client()
		{
			
		}
		
		override protected function o_setupManagers():void
		{
			GM.fun.setup(this.stage,facade,35);
//			GM.fun.console.showStats();
			GM.fun.console.setKeyCode(Keyboard.Q);
			GM.fun.sfs.debug = true;
//			GM.fun.layer.sceneLayer.alpha = 0.1;
			GM.fun.load.addEventListener(LoadEvent.LOAD_START,_onStart);
			GM.fun.load.addEventListener(LoadEvent.LOAD_PROGRESS,_onProgress);
			GM.fun.load.addEventListener(LoadEvent.LOAD_COMPLETE,_onLoaded);
			GM.fun.load.addEventListener(LoadEvent.LOAD_ALL_COMPLETE,_onAllLoaded);
		}
		
		protected function _onStart(event:Event):void
		{
			var vo:LoadTipVO = new LoadTipVO();
			vo.msg = "Loading...";
			facade.sendNotification(CMD.SHOW_LOAD_TIP,vo);	
		}
		
		private function _onAllLoaded(event:Event):void
		{
			GM.fun.console.echo("all loaded");
//			facade.sendNotification(CMD.REMOVE_LOAD_TIP);
		}
		
		private function _onLoaded(event:LoadEvent):void
		{
			GM.fun.console.echo(event.msg +" loaded");
		}
		
		private function _onProgress(event:LoadEvent):void
		{
			GM.fun.console.echo("loading... "+event.msg);
			var vo:LoadTipVO = new LoadTipVO();
			vo.msg = event.msg;
			facade.sendNotification(CMD.SHOW_LOAD_TIP,vo);	
		}
		
		override protected function o_Start():void
		{
			if(GM.fun.isLocal)
			{
				gameStart();
			}
		}
		
		private function gameStart():void
		{
			GM.fun.console.echo("游戏开始!");
			var urlLdr:URLLoader = new URLLoader();
			urlLdr.addEventListener(Event.COMPLETE,_onConfigLoaded);
			var ss:String="";
			if(!GM.fun.isLocal)//如果不是本地版本 就每次加载最新的配置文件
			{
				ss = "?"+Math.random()*999;
			}
			urlLdr.load(new URLRequest(GM.fun.url.getConfigUrl(ss)));
		}
		
		protected function _onConfigLoaded(event:Event):void
		{
			var urlLdr:URLLoader = event.currentTarget as URLLoader;
			urlLdr.removeEventListener(Event.COMPLETE,_onConfigLoaded);
			var xml:XML = XML(urlLdr.data); 
			if(xml)
			{
				GM.fun.console.echo(xml);
			}
			
			GM.fun.load.addMornui(GM.fun.url.getMornuiUrl("uiLib"),"UI库文件");
			GM.fun.load.addPlugin(GM.fun.url.getPluginUrl("cfg/PluginCfg"),"配置插件");
			GM.fun.load.addPlugin(GM.fun.url.getPluginUrl("common/PluginCommon"),"公共插件");
			GM.fun.load.addPlugin(GM.fun.url.getPluginUrl("login/PluginLogin"),"登陆插件");
			GM.fun.load.startLoad();
		}
	}
}