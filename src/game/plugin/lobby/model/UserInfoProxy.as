package game.plugin.lobby.model
{
	import engine.manager.net.SocketEvent;
	
	import game.global.NET;
	import game.manager.GM;
	import game.plugin.lobby.model.vo.UserInfoVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class UserInfoProxy extends Proxy
	{
		public static const NAME:String="UserInfoProxy";
		public function UserInfoProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
//			GM.fun.socket.addEventListener(SocketEvent.ON_DATA,onData);
		}
		
		protected function onData(event:SocketEvent):void
		{
			var m:int = event.mid;
			if(m == NET.MODULE_INFO)
			{
				switch(event.cmd)
				{
					case NET.INFO_ON_GET_INFO:
						parseInfo(event.data);
						break;
				}
			}
			
		}
		
		private function parseInfo(data:Object):void
		{
			
		}
		
		public function getUserInfo():UserInfoVO
		{
			var vo:UserInfoVO = new UserInfoVO();
			vo.cash = GM.fun.db.getDataByKey("silver");
			vo.exp = GM.fun.db.getDataByKey("exp");
			vo.gold = GM.fun.db.getDataByKey("gold");
			vo.nick = GM.fun.db.getDataByKey("nick");
			vo.uid = GM.fun.db.getDataByKey("uid");
			vo.lv = GM.fun.db.getMyLv();
			return vo;
		}
		
		public function getTitle(exp:Number):String
		{
			var t:String = "士官";
			return t;
		}
		
		public function getExpProgress():String
		{
			var s:String = "100/1500";
			return s;
		}
		
		public function getExpRate():Number
		{
			return 100/1500;
		}
		
		public function getVIP():int
		{
			var vip:int = 1;
			return vip;
		}
		
		override public function onRemove():void
		{
//			GM.fun.socket.removeEventListener(SocketEvent.ON_DATA,onData);
		}
	}
}