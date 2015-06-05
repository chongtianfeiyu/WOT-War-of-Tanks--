package engine.manager
{
	import flash.display.Stage;
	
	import engine.manager.cache.CacheManager;
	import engine.manager.console.ConsoleManager;
	import engine.manager.layer.LayerManager;
	import engine.manager.loader.LoadManager;
	import engine.manager.net.HttpManager;
	import engine.manager.net.SocketManager;
	import engine.manager.sound.SoundManager;
	
	import org.puremvc.as3.interfaces.IFacade;

	public class Mgr
	{
		public function Mgr()
		{
		}
		
		//socket 管理器
		private var _socket:SocketManager;


		public function get socket():SocketManager
		{
			return _socket;
		}

		//load 管理器
		private var _load:LoadManager;

		public function get load():LoadManager
		{
			return _load;
		}

		//日志 管理器
		private var _console:ConsoleManager;

		public function get console():ConsoleManager
		{
			return _console;
		}

		//缓存 管理器
		private var _cache:CacheManager;

		public function get cache():CacheManager
		{
			return _cache;
		}

		//http 管理器
		private var _http:HttpManager;

		public function get http():HttpManager
		{
			return _http;
		}
		
		//layer 管理器
		private var _layer:LayerManager;

		public function get layer():LayerManager
		{
			return _layer;
		}

		//
		private var _isLocal:Boolean;

		public function get isLocal():Boolean
		{
			return _isLocal;
		}
		
		private var _sound:SoundManager;
		public function get sound():SoundManager
		{
			return _sound;
		}

		/**
		 * set up 管理器
		 */
		public function setup(s:Stage,fa:IFacade,fps:int=60):void
		{
			_socket = new SocketManager();
			_load = new LoadManager();
			_console = new ConsoleManager();
			_cache = new CacheManager();
			_http = new HttpManager();
			_layer = new LayerManager();
			_sound = new SoundManager();
			
			s.frameRate = fps;
			
			_socket.setup();
			_load.setup(fa);
			_console.setup(s);
			_cache.setup();
			_http.setup();
			_layer.setup(s);
			_sound.setup();
			
			if(s.loaderInfo.url.indexOf("http") == -1)
			{
				_isLocal = true;
			}
			
			_isLocal = true;//调试用
			
			console.echo("基础管理器 安装完毕！");
			
			o_setup(s,fa);
		}
		
		protected function o_setup(s:Stage,fa:IFacade):void
		{
			throw new Error("plz set up managers !");
		}
		
	}
}