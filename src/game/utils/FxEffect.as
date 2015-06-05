package game.utils
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;

	public class FxEffect
	{
		public function FxEffect()
		{
		}
		
		public static function showSelectEffect(d:DisplayObject):void
		{
			TweenMax.killTweensOf(d);
			d.alpha = 1;
//			d.scaleX = d.scaleY = 1.2;
			TweenMax.to(d,0.5,{alpha:0.2,scaleX:1,scaleY:1});
		}
	}
}