package game.manager
{
	import com.smartfoxserver.v2.SmartFox;
	
	import flash.display.Stage;
	
	import engine.manager.Mgr;
	
	import org.puremvc.as3.interfaces.IFacade;
	
	public class GM extends Mgr
	{
		public function GM()
		{
			super();
		}
		
		private static var _instance:GM;
		public static function get fun():GM
		{
			if(_instance == null)
			{
				_instance = new GM();
			}
			
			return _instance;
		}
		
		private var _url:UrlManager;
		public function get url():UrlManager
		{
			return _url;
		}
		
		private var _sfs:SmartFox;

		public function get sfs():SmartFox
		{
			return _sfs;
		}
		
		private var _db:DbManager;

		public function get db():DbManager
		{
			return _db;
		}
		
		private var _battleLayer:BattleLayerManager;

		public function get bLayer():BattleLayerManager
		{
			return _battleLayer;
		}
		
		private var _loger:LogerManager;

		public function get loger():LogerManager
		{
			return _loger;
		}
		
		override protected function o_setup(s:Stage,fa:IFacade):void
		{
			//针对游戏扩展的 管理器
			_url = new UrlManager();
			_sfs = new SmartFox();
			_db = new DbManager();
			_battleLayer = new BattleLayerManager();
			_loger = new LogerManager();
			
			_url.setup();
			_db.setup();
			_battleLayer.setup();
			_loger.setup();
		}
	}
}