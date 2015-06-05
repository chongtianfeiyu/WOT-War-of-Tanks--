package game.plugin.lobby.view
{
	import game.ui.lobby.TaskUI;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TaskViewMediator extends Mediator
	{
		public static const NAME:String = "TaskViewMediator";
		public function TaskViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		public function get view():TaskUI
		{
			return  this.getViewComponent() as TaskUI;
		}
		
		public function show():void
		{
			view.visible = true;
		}
	}
}