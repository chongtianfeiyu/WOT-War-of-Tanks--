package game.manager
{
	import morn.core.managers.LogManager;

	public class LogerManager
	{
		public function LogerManager()
		{
		}
		
		public function setup():void
		{
			
		}
		
		public function get log():LogManager
		{
			return App.log;
		}
	}
}