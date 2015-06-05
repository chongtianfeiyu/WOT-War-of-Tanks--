package game.plugin.login.view
{

	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.common.model.vo.ConnectVO;
	import game.plugin.common.model.vo.LoadTipVO;
	import game.plugin.login.model.vo.LoginVO;
	import game.plugin.login.model.vo.ServerVO;
	import game.ui.login.LoginUI;
	import game.ui.login.RegisterUI;
	import game.ui.login.ServerRenderUI;
	import game.ui.login.ServersUI;
	
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoginViewMediator extends Mediator
	{
		public static const NAME:String="LoginViewMediator";
		public function LoginViewMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(NAME, new LoginUI());
		}
		
		public function get view():LoginUI
		{
			return this.getViewComponent() as LoginUI;
		}
		
		override public function onRegister():void
		{

//			view.addEventListener(MouseEvent.CLICK,onLoginClickHandler);
			view.btnLogin.addEventListener(MouseEvent.CLICK,_login);
		}
		
//		private function onLoginClickHandler(e:MouseEvent):void
//		{
//			view.btnLogin.addEventListener(MouseEvent.CLICK,_login);
//		}
		
		private function _login(event:MouseEvent):void
		{
			checkLogin();
//			var ip:String = view.server.selectedLabel;
//			var vo:ConnectVO = new ConnectVO();
//			vo.ip = ip;
//			vo.port = 9933;
//			facade.sendNotification(CMD.NET_CONNECT,vo);
		}
		
		override public function onRemove():void
		{
			view.btnLogin.removeEventListener(MouseEvent.CLICK,_login);
			GM.fun.layer.clearLayer(GM.fun.layer.sceneLayer);
		}
		
		override public function listNotificationInterests():Array
		{
			return [CMD.SHOW_LOGIN,SFSEvent.CONNECTION,SFSEvent.LOGIN];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case CMD.SHOW_LOGIN:
					show();
					break;
				
				case SFSEvent.CONNECTION:
					loginUser();
					break;
				
				case SFSEvent.LOGIN:
					loginLobby();
					break;
			}
		}
		
		private function loginLobby():void
		{
			GM.fun.load.killPlugin(GM.fun.url.getPluginUrl("login/PluginLogin"));
			facade.sendNotification(CMD.LOAD_LOBBY);		
		}
		
		private function loginUser():void
		{
			var vo:LoginVO = new LoginVO();
			vo.userName = GM.fun.db.getDataByKey("uid");
			vo.zoneName = "wot1";
			facade.sendNotification(CMD.NET_LOGIN,vo);			
		}
		
		[Embed(source = "game/assets/image/bg.jpg")]
		private var bgClass:Class;	
		
		private var regView:RegisterUI = new RegisterUI();
		public function show():void
		{
			var bg:Bitmap = new bgClass();
			
			bg.x = 0.5*(GM.fun.layer.stage.stageWidth - bg.width);
			bg.y = 0.5*(GM.fun.layer.stage.stageHeight - bg.height);
			
			view.x = 0.5*(GM.fun.layer.stage.stageWidth - view.width);
			view.y = 0.5*(GM.fun.layer.stage.stageHeight - view.height)+50;
			
			GM.fun.layer.sceneLayer.addChild(bg);
			GM.fun.layer.sceneLayer.addChild(view);
			
			
			GM.fun.sound.playMusic(GM.fun.url.getMusic("music_menu"),true);
		}
		
		private function checkLogin():void
		{
			if(GM.fun.isLocal)
			{
				var data:Object = GM.fun.db.getData();
				if(data)
				{
//					connectServer();
					showServers();
				}else
				{
					view.visible = false;
					GM.fun.layer.sceneLayer.addChild(regView);
					regView.txtNick.text = "";
					regView.x = 0.5*(GM.fun.layer.stage.stageWidth - regView.width);
					regView.y = 0.5*(GM.fun.layer.stage.stageHeight - regView.height)+50;
					regView.addEventListener(MouseEvent.CLICK,_reg);
				}
			}else
			{
				//				GM.fun.api4399.checkLogin();
			}
		}
		
		protected function _reg(event:MouseEvent):void
		{
			if(regView.txtNick.text != "")
			{
				GM.fun.db.setupData(regView.txtNick.text);		
//				connectServer();
				showServers();
			}
		}
		
		private var servers:ServersUI = new ServersUI();
		private function showServers():void
		{
			regView.visible = false;
			view.visible = false;
			
			GM.fun.layer.sceneLayer.addChild(servers);
			servers.x = 0.5*(GM.fun.layer.stage.stageWidth - servers.width);
			servers.y = 0.5*(GM.fun.layer.stage.stageHeight - servers.height);
			
			var arr:Array = [];
			var i:int = 20;
			while(i--)
			{
				var vo:ServerVO = new ServerVO();
				vo.ip = "121.41.77.181";
				vo.max = 1000;
				vo.name = "双线服务器";
				vo.nums = 1000*Math.random();
				vo.port = 9933;
				
				arr.push(vo);
			}
			
			servers.list.scrollBar.autoHide = false;
			servers.list.array = arr;
			servers.list.renderHandler = new Handler(renderServers);
			servers.list.addEventListener(MouseEvent.CLICK,connectServer);
			
		}
		
		private function renderServers(cell:ServerRenderUI,index:int):void
		{
			var vo:ServerVO = servers.list.array[index];
			if(vo)
			{
				cell.dataSource = vo;
				cell.mouseChildren = false;
				cell.mouseEnabled = true;
				cell.buttonMode = true;
				
				cell.progress.value = vo.nums/vo.max;
				var status:String = "流畅";
				if(cell.progress.value > 0.6)
				{
					status = "<font color='#ffff00'>拥挤</font>";
				}
				
				if(cell.progress.value > 0.8)
				{
					status = "<font color='#ff0000'>爆挤 禁止进入</font>";
					
					cell.buttonMode = false;
					cell.mouseEnabled = false;
				}
				cell.txt_name.text = vo.name+"-"+(index+1)+"  "+status;
				
				
				
				if(!cell.hasEventListener(MouseEvent.MOUSE_OVER))
				{
					cell.addEventListener(MouseEvent.MOUSE_OVER,_showTip);
					cell.addEventListener(MouseEvent.MOUSE_OUT,_hideTip);
					cell.buttonMode = true;
				}
			}
			
		}
		
		protected function _hideTip(event:MouseEvent):void
		{
			var cell:ServerRenderUI = event.currentTarget as ServerRenderUI;
			if(cell)
			{
				cell.over_tip.visible = false;
			}
		}
		
		protected function _showTip(event:MouseEvent):void
		{
			var cell:ServerRenderUI = event.currentTarget as ServerRenderUI;
			if(cell)
			{
				cell.over_tip.visible = true;
			}
		}
		
		private function connectServer(e:MouseEvent):void
		{
			if(e)
			{
				var cell:ServerRenderUI = e.target as ServerRenderUI;
				if(cell)
				{
					var svo:ServerVO = cell.dataSource as ServerVO;
					var vo:ConnectVO = new ConnectVO();
					vo.ip = svo.ip;
					vo.port = svo.port;
					facade.sendNotification(CMD.NET_CONNECT,vo);
					var tvo:LoadTipVO = new LoadTipVO();
					tvo.msg = "连接服务器...";
					facade.sendNotification(CMD.SHOW_LOAD_TIP,tvo);
				}
			}

		}
	}
}