package game.plugin.lobby.model.vo
{
	public class SwitchPanelVO
	{
		public function SwitchPanelVO()
		{
		}
		
		public static const TYPE_BATTLE:int = 0;
		public static const TYPE_STORE:int = 1;
		public static const TYPE_FACTORY:int = 2;
		public static const TYPE_STORAGE:int = 3;
		public static const TYPE_TASK:int = 4;
		
		public var type:int;
		public var data:Object;
	}
}