package engine.manager.version
{
	public class VersionManager
	{
		public function VersionManager()
		{
		}
		
		private static var _ver:String="";
		public static function setup(v:String):void
		{
			_ver = v;
		}
		
		public static function get ver():String
		{
			var v:String="";
			if(_ver.length)
			{
				v = "?"+_ver;
			}
			return v;
		}
	}
}