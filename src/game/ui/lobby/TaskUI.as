/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.TaskRenderUI;
	public class TaskUI extends View {
		protected var uiXML:XML =
			<View>
			  <List x="3" y="25" repeatX="2" repeatY="6" spaceX="2" spaceY="2">
			    <TaskRender name="render" runtime="game.ui.lobby.TaskRenderUI"/>
			    <VScrollBar skin="png.uiLib.vscroll" x="734" width="17" height="437" name="scrollBar" y="0"/>
			  </List>
			  <Label text="成就的提示文字！！！" x="3" y="2" width="714" height="18" color="0xcccccc"/>
			</View>;
		public function TaskUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.TaskRenderUI"] = TaskRenderUI;
			createView(uiXML);
		}
	}
}