package engine.manager.net
{
	import flash.events.Event;
	
	public class SocketEvent extends Event
	{
		public static const ON_DATA:String = "on_socket_data";
		public static const ON_CLOSE:String = "on_socket_close";
		public static const ON_ERROR:String = "on_socket_error";
		public static const ON_CONNECTED:String = "on_connected";
		
		/**
		 * 服务器返回的消息，对应msg
		 */
		public var data:Object;
		
		/**
		 * 模块id
		 */
		public var mid:int;
		/**
		 * 协议id
		 */
		public var cmd:int;
		
		public function SocketEvent(type:String,d:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			data = d;
		}
	}
}