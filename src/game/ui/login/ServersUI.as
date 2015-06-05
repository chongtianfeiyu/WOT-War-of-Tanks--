/**Created by the Morn,do not modify.*/
package game.ui.login {
	import morn.core.components.*;
	import game.ui.login.ServerRenderUI;
	public class ServersUI extends View {
		public var list:List;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg" x="0" y="0" sizeGrid="4,30,4,4" width="472" height="333"/>
			  <List x="10" y="58" repeatX="2" repeatY="5" spaceX="2" spaceY="2" var="list">
			    <ServerRender name="render" runtime="game.ui.login.ServerRenderUI"/>
			    <VScrollBar skin="png.uiLib.vscroll" x="437" width="17" height="264" name="scrollBar" y="0"/>
			  </List>
			  <Label text="选择相应的服务器进入！" x="11.5" y="34" width="451" height="18" color="0xcccccc" align="center"/>
			</View>;
		public function ServersUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.login.ServerRenderUI"] = ServerRenderUI;
			createView(uiXML);
		}
	}
}