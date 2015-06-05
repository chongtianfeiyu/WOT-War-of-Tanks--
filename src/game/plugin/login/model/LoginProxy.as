package game.plugin.login.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	
	import game.manager.GM;
	import game.plugin.login.model.vo.LoginVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LoginProxy extends Proxy
	{
		public static const NAME:String = "LoginProxy";
		public function LoginProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.LOGIN,onLogin);
			GM.fun.sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
		}
		
		protected function onLoginError(event:SFSEvent):void
		{
			GM.fun.console.echo("Login failure: " + event.params.errorMessage);
		}		
		
		protected function onLogin(event:SFSEvent):void
		{
			GM.fun.console.echo("Login successful!");
			facade.sendNotification(SFSEvent.LOGIN);
		}
		
		override public function onRemove():void
		{
			GM.fun.sfs.removeEventListener(SFSEvent.LOGIN,onLogin);
			GM.fun.sfs.removeEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
		}
		
		public function login(vo:LoginVO):void
		{
			var lr:LoginRequest = new LoginRequest(vo.userName,"",vo.zoneName);
			GM.fun.sfs.send(lr);
		}
	}
}