package game.plugin.lobby.model.vo
{
	public class UserInfoVO
	{
		public function UserInfoVO()
		{
		}
		
		/**
		 * 昵称
		 */
		public var nick:String="";
		/**
		 * 平台id
		 */
		public var uid:String="";
		/**
		 * 银币
		 */
		public var cash:Number = 0;
		/**
		 * 金币
		 */
		public var gold:Number = 0;
		/**
		 * 经验值
		 */
		public var exp:Number = 0;
		/**
		 * 战斗力
		 */
		public var power:Number = 0;
		
		public var lv:int;
	}
}