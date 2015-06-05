package game.manager
{
	public class UrlManager
	{
		public function UrlManager()
		{
		}
		
		public function setup():void
		{
			
		}
		
		public function getConfigUrl(s:String=""):String
		{
			return "game/assets/xml/config.xml"+s;
		}
		
		public function getPluginUrl(name:String):String
		{
			return "game/plugin/"+name+".swf";
		}
		
		public function getMornuiUrl(name:String):String
		{
			return "game/assets/"+name+".swf";
		}
		
		public function getMusic(name:String):String
		{
			return "game/assets/sound/"+name+".mp3";
		}
		
		public function getTankIcon(id:String,name:String):String
		{
			var type:String="m";
			if(id.charAt(0) == "1")//1开头 M系
			{
				type = "m";
			}
			return "game/assets/image/"+type+"/"+name+".png";
		}
		
		public function getItemIcon(icon:String):String
		{
			return "game/assets/image/item/"+icon+".jpg";
		}
		
		public function getSkillIcon(icon:String):String
		{
			return "game/assets/image/skill/"+icon+".jpg";
		}
	}
}