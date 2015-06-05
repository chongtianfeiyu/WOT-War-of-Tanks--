package game.plugin.battle.model
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.global.CMD;
	import game.utils.FxTime;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class TimeProxy extends Proxy
	{
		public static const NAME:String = "TimeProxy";
		public function TimeProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		private var timer:Timer;
		override public function onRegister():void
		{
			if(timer == null)
			{
				timer = new Timer(1000);
			}
			
			timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			t --;
			if(t < 0)
			{
				t = 0;
				isTimeOver = true;
				timer.stop();
				facade.sendNotification(CMD.GAME_OVER);
			}
			facade.sendNotification(TimerEvent.TIMER);
		}
		
		override public function onRemove():void
		{
			timer.removeEventListener(TimerEvent.TIMER,onTimer);
			timer = null;
		}
		
		private var t:Number = 0;
		public function start():void
		{
			isTimeOver = false;
			t = 1*60*2;
			timer.start();
		}
		
		public function showTime():String
		{
			return FxTime.secondsToMin(t);
		}
		
		private var isTimeOver:Boolean;
		public function checkTimeOver():Boolean
		{
			return isTimeOver;
		}
	}
}