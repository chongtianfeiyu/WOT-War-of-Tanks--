package game.utils
{
	public class FxUID
	{
		public function FxUID()
		{
		}
		
		public static function uuid():String {
			var specialChars:Array = new Array('8', '9', 'A', 'B');
			var d:Date = new Date();
			var time:String = d.fullYear+""+d.month+""+d.date+""+d.hours+""+d.minutes+""+d.seconds;
//			time.substr(-5);
			return time.substr(2)+""+createRandomIdentifier(8, 15) + '' + createRandomIdentifier(4, 15) + '4' + createRandomIdentifier(3, 15) + '' + specialChars[randomIntegerWithinRange(0, 3)] + createRandomIdentifier(3, 15) + '' + createRandomIdentifier(12, 15);
		}
		
		/**
		 * 创建一个随机的标识符指定长度和复杂性。
		 
		 @param length: 随机标识符长度.
		 @param radix: 许多独特的/允许值为每个人物(61是最大的复杂性)。.
		 @return 一个随机的标识符
		 @通过对大小写敏感的标识符@usageNote最大基数<代码> < /代码> 35,通过最大限度numberic标识符<代码>基数< /代码> 9。
		 */
		private static function createRandomIdentifier(length:uint, radix:uint = 61):String {
			var characters:Array = new Array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');
			var id:Array  = new Array();
			radix = (radix > 61) ? 61 : radix;
			while (length--) {
				id.push(characters[randomIntegerWithinRange(0, radix)]);
			}
			
			return id.join('');
		}
		
		/**
		 创建一个随机整数在定义的范围。.
		 
		 @param min: 最小值随机整数。
		 @param min: 最大价值的随机整数.
		 */
		private static function randomIntegerWithinRange(min:int, max:int):int {
			return Math.floor(Math.random() * (1 + max - min) + min);
		}
	}
}

