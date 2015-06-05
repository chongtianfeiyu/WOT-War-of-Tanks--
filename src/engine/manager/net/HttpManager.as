package engine.manager.net
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import engine.utils.json.JSONtest;


	/**
	 *
	 * <blockquote><b>author：</b> SR
	 * </br><b>version：</b> 1.0.0
	 * </br><b>创建时间：</b>2012-6-15 下午2:17:04
	 * </br><b>Email：</b> 278938054@qq.com
	 */
	public class HttpManager extends EventDispatcher
	{
		private var _mapURL:String = "";

		public function set mapURL(value:String):void
		{
			_mapURL = value;
		}

		public function HttpManager()
		{
		}
		
		public function setup(obj:*=null):void
		{
			
		}

		public function sendAbsoluteRequest(Obj:Object):void //登录成功后的请求
		{
			var loader:URLLoader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,onData);
//			loader.addEventListener(ProgressEvent.PROGRESS,onProgress);//http，不知道最大的数据量，所以这个不需要。
			loader.addEventListener(IOErrorEvent.IO_ERROR,onError);	
			
			
			var jsonStr:String = JSONtest.encode(Obj);
			
			var urlr:URLRequest=new URLRequest(_mapURL);
//			var urlr:URLRequest=new URLRequest("http://192.168.0.97:8089/map_server/queryMap");
//			var urlr:URLRequest=new URLRequest("http://54.217.218.8:8080/map_server/queryMap");
			urlr.method=URLRequestMethod.POST;				
			urlr.data = jsonStr;				
			loader.load(urlr);
		}
		
		public function onData(e:Event):void   //登录成功后处理
		{
			var loader:URLLoader = URLLoader( e.target );
			var data:String=loader.data;
			loader.close();
			
			if(data!=""){
				var str:String=JSONtest.encode(data); 
				var obj:Object=JSONtest.decode(data);
			}
			
			loader.removeEventListener(Event.COMPLETE,onData);
		}
		
		public function onError(e:IOErrorEvent):void   //收到返回消息
		{
			var loader:URLLoader = URLLoader( e.target);
			loader.close();
			loader.removeEventListener(Event.COMPLETE,onError);
		}
		
		public function reciveMsg(msg:String):void		//消息处理函数
		{
//			Logmgr.showlog_EM("从服务器接受到的数据："+msg);
			
			var xmlMsg:XML=new XML(msg);
			var msgID:String=xmlMsg.TYPE.toString(); //获取返回对象的消息id
			if (msgID=="100")			//普通战斗
			{
				var obj:Object={};
				obj.xmlMsg=xmlMsg.RESULT;
//				Emaneger.inst.etouch(EIDs.SHOW_BATTLE,obj);
			}
			else if (msgID=="200")			//军团战
			{
				var obj1:Object={};
				obj1.xmlMsg=xmlMsg;
//				Emaneger.inst.etouch(EIDs.SHOW_GROUP_BATTLE,obj1);
			}
		
 		}
		
		//发送log
		public function sendlogRequest(urlv:URLVariables):void //登录成功后的请求
		{
			var loader:URLLoader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,onlogData);
			loader.addEventListener(ProgressEvent.PROGRESS,onlogProgress);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onlogError);	
//			var urlr:URLRequest=new URLRequest("http://"+BaseGlobal.gameip+":8080/error");
//			urlr.method=URLRequestMethod.POST;				
//			urlr.data=urlv;	
//			Logmgr.showlog_EM("向服务器"+"http://"+BaseGlobal.gameip+":8080/error"+"发送的log数据："+urlv);			
//			loader.load(urlr);
			
		}
		
		private var _sendlist:Array=[];
		public function get sendlist():Array
		{
			return _sendlist;
		}
		
		public  var ifnew:Boolean=false;
		/**
		 *添加登录步骤发送队列 
		 * @param obj
		 * 
		 */
		public  function addkeyvalue(stepname:String):void
		{
			if (ifnew==false)
			{
				return;
			}
			if (_sendlist==null)
			{
				_sendlist=[];
			}
			var urlv:URLVariables=new URLVariables;
			urlv.step=stepname;
			urlv.time=(new Date()).time;
//			urlv.server=BaseGlobal.gameip;
			_sendlist.push(urlv);
			startsend();
		}
		
		public  function startsend():void
		{
			if (ifsending==true)
			{
				return;
			}
			if (_sendlist.length>0)
			{
//				ifsending=true;
				sendstepRequest(_sendlist.shift());
			}
			
		}
		
		private  var ifsending:Boolean=false;
//		private static var 
		//发送登录步骤
		public  function sendstepRequest(urlv:URLVariables):void //登录成功后的请求
		{
			var loader:URLLoader=new URLLoader();
//			loader.addEventListener(Event.COMPLETE,onlogData);
//			loader.addEventListener(ProgressEvent.PROGRESS,onlogProgress);
//			loader.addEventListener(IOErrorEvent.IO_ERROR,onlogError);	
			var urlr:URLRequest=new URLRequest("http://54.217.226.157:8089/kog_monitor/m");
			urlr.method=URLRequestMethod.GET;				
			urlr.data=urlv;	
//			Logmgr.showlog_EM("向服务器发送key："+urlv);			
			loader.load(urlr);
//			loader.close();
		}
		public  function onstepError(e:IOErrorEvent):void   //log发送失败
		{
			
			var loader:URLLoader = URLLoader( e.target );
//			Logmgr.showlog_EM("发送step的http请求失败"+e.text);
			loader.close();
			startsend();
		}
		
		protected  function onlogProgress(event:ProgressEvent):void
		{
			var obj:Object={};
			obj.totalpro=event.bytesTotal;
			obj.pro=event.bytesLoaded;
		}
		
		public  function onlogData(e:Event):void   //log发送成功
		{
			var loader:URLLoader = URLLoader( e.target );
			var data:String=loader.data;
			loader.close();
			
		}
		
		public  function onlogError(e:IOErrorEvent):void   //log发送失败
		{
			
			var loader:URLLoader = URLLoader( e.target );
//			Alert.show("server busy");
//			Logmgr.showlog_EM("发送http请求失败"+e.text);
			loader.close();
		}
	}
}