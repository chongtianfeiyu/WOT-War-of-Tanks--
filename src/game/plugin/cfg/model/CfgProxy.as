package game.plugin.cfg.model
{
	import flash.utils.Dictionary;
	
	import game.manager.GM;
	import game.plugin.cfg.model.vo.CfgItemVO;
	import game.plugin.cfg.model.vo.CfgTankVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CfgProxy extends Proxy
	{
		public static const NAME:String="CfgProxy";
		public function CfgProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		public function setup():void
		{
			setupTanks();
			setupItems();
			setupSkills();
			setupFactory();
		}
		
		private function setupFactory():void
		{
			
		}
		
		private function setupSkills():void
		{
			
		}
		
		//------------------------------------------ tanks -----------------------------------------
		[Embed(source = "game/assets/xml/tanks.xml",mimeType = "application/octet-stream")]
		private var mXML:Class;	
		
		private var tankArr:Array
		private var tanksDic:Dictionary;
		public function getCfgTankVOById(id:String):CfgTankVO
		{
			var vo:CfgTankVO;
			if(tanksDic)
			{
				vo = tanksDic[id];
			}
			
			return vo;
		}
		
		public function getTanks():Array
		{
			return tankArr;
		}
		
		public function getCfgTankVOByIndex(index:int):CfgTankVO
		{
			var vo:CfgTankVO = tankArr[index];
			return vo;
		}
		
		private function setupTanks():void
		{
			if(tankArr == null && tanksDic == null)
			{
				tankArr = [];
				tanksDic = new Dictionary();
				var data:Object = new mXML()
				var tk_xml:XML = new XML(data);
				GM.fun.console.echo(tk_xml);
				var tanks:XMLList=tk_xml.tk as XMLList;
				var len:int=tanks.length();
				var i:int = 0;
				var tank:XML;
				var info:CfgTankVO;
				while(i < len)
				{
					tank = tanks[i] as XML;
					if(tank)
					{
						info = new CfgTankVO();
						info.desc = tank.des+"";
						info.armor = int(tank.@armor);
						info.attack = int(tank.@attack);
						info.chuan = int(tank.@chuan);
						info.hp = int(tank.@hp);
						info.icon = tank.@icon+"";
						info.id = tank.@id+"";
						info.lock = int(tank.@lock);
						info.lv = tank.@lv+"";
						info.move_speed = int(tank.@move_speed);
						info.name = tank.@name+"";
						info.shoot_rate = int(tank.@shoot_rate);
						info.type = tank.@type+"";
						
						info.gun = int(tank.req.@pao);
						info.gun_lv = int(tank.req.@pao_lv);
						info.ta = int(tank.req.@ta);
						info.ta_lv = int(tank.req.@ta_lv);
						info.fdj = int(tank.req.@fdj);
						info.fdj_lv = int(tank.req.@fdj_lv);
						info.dai = int(tank.req.@dai);
						info.dai_lv = int(tank.req.@dai_lv);
						info.money = int(tank.req.@money);
						info.rate = int(tank.req.@rate);
						
						tankArr.push(info);
						tanksDic[tank.@id+""] = info;
					}
					i++;
				}
			}
		}
		
		//---------------------------- items  ----------------------------------------------
		[Embed(source = "game/assets/xml/items.xml",mimeType = "application/octet-stream")]
		private var itemsXML:Class;
		
		private var itemsArr:Array;
		private var itemsDic:Dictionary;
		private function setupItems():void
		{
			if(itemsArr == null && itemsDic == null)
			{
				itemsArr = [];
				itemsDic = new Dictionary();
				var data:Object = new itemsXML()
				var items_xml:XML = new XML(data);
				
				var items:XMLList=items_xml.it as XMLList;
				var len:int=items.length();
				var i:int = 0;
				var item:XML;
				var info:CfgItemVO;
				while(i < len)
				{
					item = items[i] as XML;
					if(item)
					{
						info = new CfgItemVO();
						info.des = item.@des;
						info.icon = item.@icon;
						info.id = item.@id;
						info.money = item.@money;
						info.name = item.@name;
						
						itemsArr.push(info);
						itemsDic[item.@id+""] = info;
					}
					i++;
				}
			}
		}
		
		public function getCfgItemVOById(id:String):CfgItemVO
		{
			var vo:CfgItemVO = itemsDic[id];
			return vo;
		}
		
	}
}