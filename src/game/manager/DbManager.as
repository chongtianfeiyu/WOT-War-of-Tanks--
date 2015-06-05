package game.manager
{
	import flash.events.EventDispatcher;
	
	import engine.utils.FxSo;
	
	import game.plugin.lobby.model.vo.BagTankVO;
	import game.utils.FxUID;

	/**
	 * 对游戏数据进行统一管理
	 */
	public class DbManager extends EventDispatcher
	{
		public function DbManager()
		{
		}
		
		public function setup():void
		{
			var d:Date = new Date();
//			storekEY = "K"+d.getTime();
		}
		
		/**
		 * 解析xml文件
		 */
		public function parseXML():void
		{
			
		}
		
		public function get gameGroupId():String
		{
			return "default";
		}
		
		public function get lobbyName():String
		{
			return "Lobby";
		}
		
		public function get battleWidth():int
		{
			return 850;
		}
		
		public function get battleHeight():int
		{
			return 700;
		}
		
		public function get max():int
		{
			return 1;
		}
		
		private var _data:Object = {};
		public function saveData():void
		{
			
		}
		
		private var storekEY:String = "wwot9";
		public function getData():Object
		{
			return FxSo.getData(storekEY);
		}
		
		private function setData(data:Object):void
		{
			FxSo.saveData(storekEY,data);
		}
		
		/**
		 * 按照键值保存数据
		 */
		public function setDataByKey(key:String,value:*):void
		{
			var d:Object = FxSo.getData(storekEY);
			if(d)
			{
				d[key] = value;
				setData(d);
			}
		}
		
		/**
		 * 初始化数据
		 */
		public function setupData(nick:String):void
		{
			var data:Object = {};	
			data.uid = FxUID.uuid();
			data.nick = nick;
			data.exp = 0;
			data.power = 0;
			data.silver = 0;
			data.gold = 0;
			data.usedTank = 0;//使用的坦克的索引
			
			// id,星级,耐久,技能1,技能2,技能3,技能4
			data.myTanks = ["1000,2,100,0,0,0,0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"];//一共15个车位
			//id,数量
			data.items = [];
			data.task = [];
			
			setData(data);
		}
		
		public function getDataByKey(key:String):*
		{
			var d:Object = FxSo.getData(storekEY);
			if(d)
			{
				return d[key];
			}else
			{
				return null;
			}
		}
		
		public function getMyLv():int
		{
			var lv:int=1;
			var exp:int = getDataByKey("exp");
			lv =Math.ceil(exp/100);
			if(lv == 0)
			{
				lv = 1;
			}
			return lv;
		}
		
		public function getCountry(id:String):String
		{
			var ct:String = "";
			switch(id.charAt())
			{
				case "1":
					ct = "M系"
					break;
				
				case "2":
					ct = "S系"
					break;
				
				case "3":
					ct = "D系"
					break;
			}
			return ct;
		}
		
		public var usedTankVO:BagTankVO;
		
	}
}