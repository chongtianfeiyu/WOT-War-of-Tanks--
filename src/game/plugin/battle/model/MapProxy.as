package game.plugin.battle.model
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import game.plugin.battle.model.vo.TileVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MapProxy extends Proxy
	{
		public static const NAME:String = "MapProxy";
		public function MapProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			
		}
		
		override public function onRemove():void
		{
			
		}
		
		private var ix_width:int;
		private var iy_height:int;
		
		public var map_width:int;
		public var map_height:int;
		
		/**
		 * tile拼地图
		 */
		public function getMapData(w:int,h:int):Array
		{
			ix_width = w;
			iy_height = h;
			
			map_width = w*size;
			map_height = h*size;
			
			var arr:Array = [];
			var t:TileVO;
			for(var i:int=0;i<h;i++)
			{
				for(var j:int=0;j<w;j++)
				{
					t = new TileVO();
					t.ix = j;
					t.iy = i;
					t.type = 1;//int(Math.random()*4);
					t.px = j*size;
					t.py = i*size;
					t.size = size;
					arr.push(t);
				}
			}
			
			return arr;
		}
		
		/**
		 * 大位图
		 */
		public function getMap(mapClass:Class):Bitmap
		{
			var bm:Bitmap = new mapClass() as Bitmap;
			map_width = bm.width;
			map_height = bm.height;
			ix_width = map_width/size;
			iy_height = map_height/size;
			
			return bm;
		}
		
		private var _size:int=128;
		public function get size():int
		{
			return _size;
		}
		
		public function getPos(ix:int,iy:int):Point
		{
			var p:Point = new Point(ix,iy);
			p.x = ix*size+size*0.5;
			p.y = iy*size+size*0.5;
			return p;
		}
		
		/**
		 * 获取初始化 位置
		 */
		public function getInitPos():Point
		{
			var ix:int = ix_width*Math.random();
			var iy:int = iy_height*Math.random();
			var p:Point = new Point(ix,iy);
			return p;
		}
	}
}