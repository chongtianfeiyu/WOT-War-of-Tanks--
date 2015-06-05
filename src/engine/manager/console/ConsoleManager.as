package engine.manager.console
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
	import engine.utils.FxStats;

	/**
	 * 控制台相关的功能 
	 */
	public class ConsoleManager
	{
		public function ConsoleManager()
		{
		}
		
		private var _stage:Stage;
		private var _keyCode:int;
		public function setup(s:Stage):void
		{
			_stage = s;
			_logTF.visible = false;
			_logTF.filters = [new GlowFilter(0x000000,1,4,4,4)];
			_logTF.type = TextFieldType.INPUT;
			_logTF.textColor = 0xffffff;
//			_logTF.background = true;
//			_logTF.backgroundColor = 0x000000;
			_stage.addEventListener(KeyboardEvent.KEY_UP,_checkKey);
		}
		
		public function setKeyCode(key:int):void
		{
			_keyCode = key;
		}
		
		protected function _checkKey(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if(event.keyCode == _keyCode)
			{
				checkLogShow();
			}
		}
		
		public function echo(...msg):void
		{
			trace("[echo]"+msg);
			_logTF.appendText(msg+"\n");
		}
		
		public function warn(...msg):void
		{
			trace("[warn]"+msg);
			_logTF.appendText(msg+"\n");
		}
		
		public function error(...msg):void
		{
			trace("[error]"+msg);
			_logTF.appendText(msg+"\n");
		}
		
		private var _stats:FxStats = new FxStats();
		public function showStats():void
		{
			_stage.addChild(_stats);
		}
		
		private var _logTF:TextField = new TextField();

		public function get logTF():TextField
		{
			return _logTF;
		}
		
		public function checkLogShow():void
		{
			_logTF.visible = !_logTF.visible;
			_logTF.width = _stage.stageWidth*0.5;
			_logTF.height = _stage.stageHeight;
			_stage.addChild(_logTF);
		}

	}
}