/**Created by the Morn,do not modify.*/
package game.ui.common {
	import morn.core.components.*;
	public class TipBoxUI extends View {
		public var icon:Image;
		public var txt_num:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="jpg.uiLib.pao_guan" x="0" y="0" var="icon" mouseChildren="false" mouseEnabled="false"/>
			  <Label text="999" x="4" y="40" width="53" height="18" color="0xffffff" var="txt_num" mouseChildren="false" mouseEnabled="false" isHtml="true" align="right" stroke="0x000000,1,2,2,4,1"/>
			</View>;
		public function TipBoxUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}