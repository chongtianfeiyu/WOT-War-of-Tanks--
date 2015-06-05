/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class StoreInfoUI extends Dialog {
		public var txt_desc:Label;
		public var txt_name:Label;
		public var icon:Image;
		public var txt_num:Label;
		public var btn_use:Button;
		public var txt_num2:TextInput;
		public var btn_jian:Button;
		public var btn_jia:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.uiLib.bg" x="0" y="0" sizeGrid="4,30,4,4" width="395" height="202"/>
			  <Image url="png.uiLib.bg2" x="15" y="36" sizeGrid="4,4,4,4" width="365" height="70" alpha="0.1" visible="true" mouseEnabled="false" mouseChildren="false" buttonMode="false"/>
			  <Label text="可用于制造: M2 T6 T8" x="87" y="61" width="286" height="38" multiline="true" wordWrap="true" color="0x666666" var="txt_desc" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="100 mm D-10T" x="84" y="42" width="130" height="18" color="0xcccccc" var="txt_name" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Image url="jpg.uiLib.pao_guan" x="21" y="41" var="icon"/>
			  <Label text="999" x="26" y="81" width="53" height="18" color="0xcccccc" var="txt_num" mouseChildren="false" mouseEnabled="false" isHtml="true" align="right" stroke="0x000000,1,2,2,4,1"/>
			  <Button label="使用" skin="png.uiLib.button" x="121" y="161" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_use" width="145" height="30"/>
			  <TextInput text="100" skin="png.uiLib.textinput" x="155" y="123" color="0xffffff" width="78" height="22" align="center" var="txt_num2"/>
			  <Button label="-" skin="png.uiLib.button" x="122" y="121" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_jian" width="30" height="25"/>
			  <Button label="+" skin="png.uiLib.button" x="236" y="121" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_jia" width="30" height="25"/>
			  <Label text="物品" x="136" y="2" width="116" height="18" align="center" color="0x999999"/>
			  <Button skin="png.uiLib.btn_close" x="369" y="2" width="20" height="20" name="close"/>
			</Dialog>;
		public function StoreInfoUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}