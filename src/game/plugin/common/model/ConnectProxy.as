package game.plugin.common.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import game.manager.GM;
	import game.plugin.common.model.vo.ConnectVO;
	import game.plugin.common.model.vo.PopVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ConnectProxy extends Proxy
	{
		public static const NAME:String = "ConnectProxy";
		public function ConnectProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.CONNECTION,onConneted);
			GM.fun.sfs.addEventListener(SFSEvent.CONNECTION_LOST,onLost);
		}
		
		protected function onLost(event:SFSEvent):void
		{
			GM.fun.console.echo("CONNECTION_LOST->",event.params);
			var vo:PopVO = new PopVO();
			vo.msg = "与服务器断开连接！";
			facade.sendNotification(SFSEvent.CONNECTION_LOST,vo);
		}
		
		protected function onConneted(event:SFSEvent):void
		{
			GM.fun.console.echo("CONNECTION->",event.params.success);
			if(event.params.success)
			{
				facade.sendNotification(SFSEvent.CONNECTION);
			}
		}
		
		public function connect(vo:ConnectVO):void
		{
			GM.fun.console.echo("connect->",vo.ip,vo.port);
			GM.fun.sfs.connect(vo.ip,vo.port);
		}
		
		override public function onRemove():void
		{
		}
	}
}