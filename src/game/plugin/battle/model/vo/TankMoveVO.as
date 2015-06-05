package game.plugin.battle.model.vo
{
	import com.smartfoxserver.v2.entities.User;

	public class TankMoveVO
	{
		public function TankMoveVO()
		{
		}
		
		public var user:User;
		public var ix:int;
		public var iy:int;
		public var t:Number=0;
	}
}