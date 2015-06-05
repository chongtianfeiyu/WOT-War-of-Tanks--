package game.plugin.battle.model.vo
{
	import com.smartfoxserver.v2.entities.User;
	
	import flash.geom.Point;

	public class TankShootVO
	{
		public function TankShootVO()
		{
		}
		
		public var user:User;
		public var sp:Point;
		public var ep:Point;
		public var t:Number;
	}
}