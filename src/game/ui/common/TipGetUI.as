/**Created by the Morn,do not modify.*/
package game.ui.common {
	import morn.core.components.*;
	import game.ui.common.GetRenderUI;
	public class TipGetUI extends Dialog {
		public var bg:Image;
		public var black:Image;
		public var txt_title:Label;
		public var list:List;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.uiLib.bg" x="1" y="0" sizeGrid="4,30,4,4" width="420" height="410" var="bg"/>
			  <Image url="png.uiLib.bgs" x="10" y="29" width="402" height="331" sizeGrid="5,5,5,5" var="black"/>
			  <Button label="关闭" skin="png.uiLib.button" x="138.5" y="368" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" width="145" height="30" name="close"/>
			  <Label text="物品" x="153" y="3" width="116" height="18" align="center" color="0x999999" var="txt_title"/>
			  <List x="15.5" y="34" repeatY="4" spaceY="2" var="list">
			    <GetRender name="render" runtime="game.ui.common.GetRenderUI"/>
			    <VScrollBar skin="png.uiLib.vscroll" x="374" width="17" height="320" name="scrollBar" y="0"/>
			  </List>
			</Dialog>;
		public function TipGetUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.common.GetRenderUI"] = GetRenderUI;
			createView(uiXML);
		}
	}
}