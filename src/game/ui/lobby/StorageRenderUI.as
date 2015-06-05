/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class StorageRenderUI extends View {
		public var txt_desc:Label;
		public var txt_name:Label;
		public var icon:Image;
		public var txt_num:Label;
		public var over_tip:Image;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="0" y="1" sizeGrid="4,4,4,4" width="365" height="70" alpha="0.1" visible="true" mouseEnabled="true" mouseChildren="true" buttonMode="false"/>
			  <Label text="可用于制造: M2 T6 T8" x="72" y="26" width="286" height="38" multiline="true" wordWrap="true" color="0x666666" var="txt_desc" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="100 mm D-10T" x="72" y="4" width="130" height="18" color="0xcccccc" var="txt_name" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Image url="jpg.uiLib.pao_guan" x="5" y="5" var="icon" mouseChildren="false" mouseEnabled="false"/>
			  <Label text="999" x="10" y="45" width="53" height="18" color="0xcccccc" var="txt_num" mouseChildren="false" mouseEnabled="false" isHtml="true" align="right" stroke="0x000000,1,2,2,4,1"/>
			  <Image url="png.uiLib.mouse_over_tip" x="0" y="0" sizeGrid="4,4,4,4" width="364" height="70" var="over_tip" visible="false" mouseChildren="false" mouseEnabled="false"/>
			</View>;
		public function StorageRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}