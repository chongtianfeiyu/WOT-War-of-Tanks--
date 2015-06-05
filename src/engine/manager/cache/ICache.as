package engine.manager.cache
{
	public interface ICache
	{
		/**
		 * 重置方法 所有对象池的显示对象必须实现这个接口
		 */
		function reset():void;
	}
}