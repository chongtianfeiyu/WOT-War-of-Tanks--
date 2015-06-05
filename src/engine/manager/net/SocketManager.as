package engine.manager.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import engine.utils.Tmd5;
	
	import engine.utils.json.JSONtest;
	import engine.utils.Tmd5;
	
	public class SocketManager extends EventDispatcher
	{
		private var _socket:Socket;
		
		public function SocketManager()
		{

		}
		
		public function setup(obj:*=null):void
		{
			if(_socket == null)
			{
				_socket=new Socket(); 
				_socket.timeout = 10000;//10秒钟链接超时
				_socket.objectEncoding=ObjectEncoding.AMF3;
				_socket.addEventListener(Event.CONNECT,_onConnectSuccess);
				_socket.addEventListener(ProgressEvent.SOCKET_DATA,_onSocketData);
				_socket.addEventListener(IOErrorEvent.IO_ERROR,_onConnectError);
				_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_onSecurityerr);
				_socket.addEventListener(Event.CLOSE,onConnectClose);
			}
		}
		
		private function _onConnectSuccess(event:Event):void
		{
			this.dispatchEvent(new SocketEvent(SocketEvent.ON_CONNECTED));	
		}
		
		public function connect(ip:String,port:int):void
		{
			_socket.connect(ip,port);
		}
		
		private var dataLength:int=0;
		private var buffer:ByteArray = new ByteArray();
		private function _onSocketData(event:ProgressEvent):void
		{
			while(true)
			{
				if(dataLength==0)
				{
					if(_socket.bytesAvailable<4)
					{
						break;
					}
					else
					{
						try
						{
//							var lengthdata:ByteArray=new ByteArray;
//							_socket.readBytes(lengthdata,0,4);
							_socket.readBytes(buffer,0,4);
							dataLength=buffer.readInt(); //读取数据长度
						}
						catch(e:Error)
						{
						}
					}
				}
				
				var a:int=dataLength;
				
				buffer.clear();
				var mid:int;
				if(a>0&&_socket.bytesAvailable>=a)
				{
					try
					{
						buffer=new ByteArray;
						_socket.readBytes(buffer,0,a);
						mid=buffer.readInt();
						
						var orderid:int=buffer.readInt();
						var str:String=buffer.readUTF();
						var obj:Object=JSONtest.decode(str);
						dataLength=0;
						buffer.clear();
						var e:SocketEvent = new SocketEvent(SocketEvent.ON_DATA,obj);
						e.cmd = orderid;
						e.mid = mid;
						this.dispatchEvent(e);
					}catch(e:Error)
					{
						//解析失败
					}
				}
				else
				{
					break; 	
				}
			}		
		}
		
		private function _onConnectError(event:IOErrorEvent):void
		{
			this.dispatchEvent(new SocketEvent(SocketEvent.ON_ERROR));
		}
		
		private function _onSecurityerr(event:SecurityErrorEvent):void
		{
			this.dispatchEvent(new SocketEvent(SocketEvent.ON_ERROR));	
		}
		
		protected function onConnectClose(event:Event):void
		{
			this.dispatchEvent(new SocketEvent(SocketEvent.ON_CLOSE));	
		}
		
		
		private var _gameMD5:String="";
		public function setGameMD5(md5:String):void
		{
			_gameMD5 = md5
		}
		
		
//		public function startHeartBeat():void
//		{
//			_timer.start();
//		}
//		
//		public function stopHeartBeat():void
//		{
//			_timer.stop();
//		}
		
		public function sendHeartBeat():void
		{
//			Mgr.instance.log.log("【heart beat】------> ");
			sendMsg(100,5018);			
		}
		
		/**发送一条消息给服务器 
		* @param mid 模块id
		* @param cmd 消息id
		* @param params 发送的数据对象
		*/
		public function sendMsg(mid:int,cmd:int,params:Object=null):void
		{
			if(!_socket.connected)
			{
				return;
			}
			
			if(params == null)
			{
				params = {};
			}
			
			var str:String=JSONtest.encode(params);
			var msg:ByteArray=new ByteArray;
			try
			{
				msg.writeInt(mid);
				msg.writeInt(cmd);
				msg.writeUTF(str);
				if (_gameMD5!="")
				{
					var uft:String=new Tmd5().getMD5(str.length+_gameMD5);
					msg.writeUTF(uft);
				}
			}
			catch(e:RangeError)
			{
			}
			
			try
			{
				if(msg.length)
				{
					_socket.writeInt(msg.length);		
					_socket.writeBytes(msg,0,msg.length);
					_socket.flush();
				}
			}catch(e:Error)
			{
			}


		}
	}
}