package game.utils
{
	/**
	 * ...
	 * @author ...
	 */
	public class FxArray 
	{
		
		public function FxArray() 
		{
			
		}
		
		/**
		 * 随机打乱一个数组
		 * @param	arr
		 * @return
		 */
		public static function randomArr(arr:Array):Array
		{
			arr.sort(function():int { return Math.random() > 0.5?1: -1 } );
			return arr;
		}
		
		/**
		 * 扣取数组里随机一个元素返回，并修改数组
		 * @param	arr
		 * @return
		 */
		public static function fetchArrElement(arr:Array):*
		{
			return arr.splice(int(Math.random()*(arr.length)),1)[0]
		}
		
	}

}