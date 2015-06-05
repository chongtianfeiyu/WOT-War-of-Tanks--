package game.plugin.cfg.model.vo
{
	public class CfgTankVO
	{
		public function CfgTankVO()
		{
		}
/**
 * id 战车的id 1开头 M系 2开头S系 3开头D系
icon
lv
type 战车的类型 l轻型  m中型 h重型 g为金币战车
name 战车的名字
hp 战车的血量
chuan 穿透率
attack 杀伤力
shoot_rate 射击速度
amor 装甲厚度
move_speed 移动速度
 */
		public var id:String="";
		public var icon:String="";
		public var lv:String="";
		public var lock:int;
		public var type:String="";
		public var name:String="";
		public var hp:int;
		public var chuan:int;
		public var attack:int;
		public var shoot_rate:int;
		public var armor:int;
		public var move_speed:int;
		public var desc:String="";
		
		public var gun:int;
		public var gun_lv:int;
		public var ta:int;
		public var ta_lv:int;
		public var fdj:int;
		public var fdj_lv:int;
		public var dai:int;
		public var dai_lv:int;
		public var money:int;
		public var rate:int;
	}
}