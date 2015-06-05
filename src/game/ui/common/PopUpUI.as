/**Created by the Morn,do not modify.*/
package game.ui.common {
	import morn.core.components.*;
	public class PopUpUI extends Dialog {
		public var txt_msg:Label;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.uiLib.bg" x="0" y="0" width="426" height="212" sizeGrid="4,30,4,4"/>
			  <Label text="提示信息！！" x="48" y="63" width="338" height="95" color="0xcccccc" multiline="true" wordWrap="true" isHtml="true" var="txt_msg"/>
			  <Button label="OK" skin="png.uiLib.button" x="167" y="178" labelColors="#000000,#000000,#000000,#000000" width="94" height="22" name="close"/>
			</Dialog>;
		public function PopUpUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}