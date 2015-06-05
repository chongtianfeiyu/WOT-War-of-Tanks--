package engine.manager.cache
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import engine.manager.cache.ICache;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.IProxy;

	public class CacheManager
	{
		/**
		 * 处理缓存的东西，进行内存
		 */
		public function CacheManager()
		{
			
		}
		
		public function setup():void
		{
			
		}
		
		private  var pool:Dictionary = new Dictionary();

		/**
		 * 缓存位图数据
		 */
		public function cacheBitmapData(url:String,bitd:BitmapData):void{
			var bit:BitmapData=pool[url];
			if(!bit){
				pool[url]=bitd;
			}
		}
		
		/**
		 * 获取缓存的位图数据
		 */
		public function getCacheBitmapData(url:String):BitmapData{
			var bit:BitmapData=pool[url];
			return bit;
		}

		/**
		 * 获取mediator，并将mediator缓存起来，这样避免不断的创建mediator。
		 */
		public function createCacheMediator(ClassRef:Class):IMediator
		{
			var mediator:IMediator = pool["m"+ClassRef];
			if(!mediator)
			{
				mediator = new ClassRef() as IMediator; 
				if(mediator)
				{
					pool["m"+ClassRef] = mediator;
				}
			}
			
			return mediator;
		}
		
		/**
		 * 获取proxy，并将proxy缓存起来，这样避免不断的创建proxy。
		 */
		public function createCacheProxy(ClassRef:Class):IProxy
		{
			var proxy:IProxy = pool["p"+ClassRef];
			if(!proxy)
			{
				proxy = new ClassRef() as IProxy;
				if(proxy)
				{
					pool["p"+ClassRef] = proxy;
				}
			}
			
			return proxy;
		}
		
		/**
		 * 从对象池里 获取 相应的显示对象
		 * 缓存的对象 必须实现 ICache 接口
		 */
		public function createFromPool(ClassRef:Class):DisplayObject
		{
			var arr:Array =  pool["arr"+ClassRef];
			var d:DisplayObject;
			if(arr) //如果有数组 就查找可用的 显示对象
			{
				var i:int = arr.length;
				while(i--)
				{
					d = arr[i];
					if(d && d.parent == null)
					{
						break;
					}
					d = null;
				}
			}else//如果没有数值 就创建数组
			{
				pool["arr"+ClassRef] = [];
			}
			
			if(d == null) //如果没找到可用的显示对象，就创建新的显示对象
			{
				d = new ClassRef() as DisplayObject;
				arr.push(d);
			}
			
			var temp:ICache = d as ICache;
			if(temp)//将显示对象 reset
			{
				temp.reset();
			}
			
			return d;
			
		}
		
	}
}