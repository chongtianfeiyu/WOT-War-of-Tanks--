package engine.utils
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;

	public class FxFilter
	{
		public function FxFilter()
		{
		}
		
		public static function gray(d:DisplayObject):void
		{
			d.filters =[new ColorMatrixFilter(
					[1,0,0,0,0,
					1,0,0,0,0,
					1,0,0,0,0,
					0,0,0,1,0]
			)];
		}
	}
}