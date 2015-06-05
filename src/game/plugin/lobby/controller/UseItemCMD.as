package game.plugin.lobby.controller
{
	import game.global.CMD;
	import game.plugin.lobby.model.ItemsProxy;
	import game.plugin.lobby.model.vo.AddOrUseItemVO;
	import game.plugin.lobby.model.vo.ItemVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UseItemCMD extends SimpleCommand
	{
		public function UseItemCMD()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var vo:AddOrUseItemVO = notification.getBody() as AddOrUseItemVO;
			if(vo)
			{
				var ip:ItemsProxy = facade.retrieveProxy(ItemsProxy.NAME) as ItemsProxy;
				if(ip)
				{
					var arr:Array = vo.items;
					var i:int = arr.length;
					var item:ItemVO;
					while(i--)
					{
						item = arr[i];
						if(item)
						{
							ip.addOrUseItem(item.id,item.num);
						}
					}
					
					facade.sendNotification(CMD.ON_ITEM_CHANGE);
					
				}
			}
		}
	}
}