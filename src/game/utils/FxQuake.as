package game.utils
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class FxQuake
	{
		public function FxQuake()
		{
		}
		
		//==============================================================
		//==============================================================
		private static var _shake_init_x:Number;
		private static var _shake_init_y:Number;
		private static var _target:DisplayObject;
		private static var _maxDis:Number;
		private static var _count:int = 0;
		private static var _rate:Number;
		/**
		 * 震动显示对象
		 * @param        target                震动目标对象
		 * @param        time                        震动持续时长（秒）
		 * @param        rate                        震动频率(一秒震动多少次)
		 * @param        maxDis        震动最大距离
		 */
		public static function shakeObj(target:DisplayObject , time:Number ,rate:Number, maxDis:Number):void
		{
			_target                         = target;
			_shake_init_x         = target.x;
			_shake_init_y         = target.y;
			_maxDis                         = maxDis;
			_count                                 = time * rate;
			_rate                                 = rate;
			
			var timer:Timer = new Timer(1000 / rate, _count );
			timer.addEventListener(TimerEvent.TIMER, shaking);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
			timer.start();
		}
		
		static private function shaking(e:TimerEvent):void 
		{
			TweenMax.killTweensOf(_target);
			_target.x         = _shake_init_x +Math.random() * _maxDis;
			_target.y        = _shake_init_y +Math.random() * _maxDis;
			TweenMax.to( _target,999 / _rate, { x : _shake_init_x, y:_shake_init_y } );
		}
		
		static private function shakeComplete(e:TimerEvent):void 
		{
			TweenMax.killTweensOf(_target);
			_target.x         = _shake_init_x;
			_target.y         = _shake_init_y;
		}
		//==============================================================
		//==============================================================
	}
}