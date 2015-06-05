/**Created by the Morn,do not modify.*/
package game.ui.login {
	import morn.core.components.*;
	public class ServerRenderUI extends View {
		public var txt_name:Label;
		public var progress:ProgressBar;
		public var over_tip:Image;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="2" y="1" sizeGrid="4,4,4,4" width="212" height="50" alpha="0.1" visible="true" mouseEnabled="true" mouseChildren="true" buttonMode="false"/>
			  <Label text="沙漠风暴(爆满)" x="9" y="5" width="191" height="18" color="0xff00" var="txt_name" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <ProgressBar skin="png.uiLib.progress" x="8" y="26" width="196" height="14" value="1" sizeGrid="1,1,1,1" var="progress"/>
			  <Image url="png.uiLib.mouse_over_tip" x="1" y="0" sizeGrid="4,4,4,4" width="213" height="48" var="over_tip" visible="false" mouseChildren="false" mouseEnabled="false"/>
			</View>;
		public function ServerRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}