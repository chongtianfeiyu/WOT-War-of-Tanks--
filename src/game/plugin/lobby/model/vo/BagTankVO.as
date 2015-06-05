package game.plugin.lobby.model.vo
{
	public class BagTankVO
	{
		public function BagTankVO()
		{
		}
		
		// id|星级|耐久|技能1,技能2,技能3,技能4
		public var id:String="";
		public var star:int;
		public var nai:int;
		public var skill0:String="";
		public var skill1:String="";
		public var skill2:String="";
		public var skill3:String="";
		public var state:int=-1;// 1使用   0空闲 -1待开启 -2未开启 
		public var main:Boolean;
		public var index:int;
	}
}