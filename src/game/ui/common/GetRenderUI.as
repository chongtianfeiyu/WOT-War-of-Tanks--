/**Created by the Morn,do not modify.*/
package game.ui.common {
	import morn.core.components.*;
	public class GetRenderUI extends View {
		public var icon_tank:Image;
		public var icon_item:Image;
		public var txt_desc:Label;
		public var txt_name:Label;
		public var txt_num:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="0" y="0" sizeGrid="4,4,4,4" width="369" height="78" alpha="0.1" visible="true" mouseEnabled="false" mouseChildren="false" buttonMode="false"/>
			  <Image url="png.uiLib.tank" x="0" y="0" width="122" height="78" var="icon_tank" mouseChildren="false" mouseEnabled="false"/>
			  <Image url="jpg.uiLib.pao_guan" x="10" y="9" var="icon_item"/>
			  <Label text="可用于制造: M2 T6 T8" x="114" y="30" width="254" height="46" multiline="true" wordWrap="true" color="0x666666" var="txt_desc" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="100 mm D-10T" x="114" y="7" width="130" height="18" color="0xcccccc" var="txt_name" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="999" x="14" y="46" width="53" height="18" color="0xcccccc" var="txt_num" mouseChildren="false" mouseEnabled="false" isHtml="true" align="right" stroke="0x000000,1,2,2,4,1"/>
			</View>;
		public function GetRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}