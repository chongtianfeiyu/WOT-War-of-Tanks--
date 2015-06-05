/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class TaskRenderUI extends View {
		public var txt_desc:Label;
		public var txt_name:Label;
		public var btn_get:Button;
		public var txt_reward:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="0" y="1" sizeGrid="4,4,4,4" width="365" height="70" alpha="0.1" visible="true" mouseEnabled="true" mouseChildren="true" buttonMode="false"/>
			  <Label text="击毁1辆战车" x="6" y="25" width="241" height="22" multiline="true" wordWrap="true" color="0xcccccc" var="txt_desc" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="第一滴血(3星)" x="6" y="3" width="130" height="18" color="0xcccccc" var="txt_name" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Button label="获取奖励" skin="png.uiLib.button" x="236" y="45" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_get" width="124" height="22"/>
			  <Label text="100金币 200经验" x="237" y="24" width="121" height="22" multiline="true" wordWrap="true" color="0xffffff" var="txt_reward" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <ProgressBar skin="png.uiLib.progress" x="10" y="51" width="196" height="14" value="0.21"/>
			  <Label text="奖励:" x="240" y="4" width="91" height="22" multiline="true" wordWrap="true" color="0xcccccc" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			</View>;
		public function TaskRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}