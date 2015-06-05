package game.plugin.battle.model.vo
{
	import com.smartfoxserver.v2.entities.User;

	public class TankInitVO
	{
		public function TankInitVO()
		{
		}
		
		public var ix:int;
		public var iy:int;
		public var nick:String="";
		public var user:User;
	}
}