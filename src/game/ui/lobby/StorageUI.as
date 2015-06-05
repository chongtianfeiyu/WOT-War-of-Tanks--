/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.StorageRenderUI;
	public class StorageUI extends View {
		public var list:List;
		public var btn_add:Button;
		protected var uiXML:XML =
			<View>
			  <List x="2" y="25" repeatX="2" repeatY="6" spaceX="2" spaceY="2" var="list">
			    <VScrollBar skin="png.uiLib.vscroll" x="734" width="17" height="437" name="scrollBar" y="0"/>
			    <StorageRender name="render" y="0" runtime="game.ui.lobby.StorageRenderUI"/>
			  </List>
			  <CheckBox label="火炮残件" skin="png.uiLib.checkbox" x="365" y="4.5" labelColors="0xCCCCCC"/>
			  <CheckBox label="炮塔残件" skin="png.uiLib.checkbox" x="288" y="4.5" labelColors="0xCCCCCC"/>
			  <CheckBox label="发动机残件" skin="png.uiLib.checkbox" x="199" y="4.5" labelColors="0xCCCCCC"/>
			  <CheckBox label="履带残件" skin="png.uiLib.checkbox" x="122" y="4.5" labelColors="0xCCCCCC"/>
			  <CheckBox label="消耗品" skin="png.uiLib.checkbox" x="4" y="4.5" labelColors="0xCCCCCC"/>
			  <CheckBox label="炮弹" skin="png.uiLib.checkbox" x="69" y="4.5" labelColors="0xCCCCCC"/>
			  <Button label="随机获得物品" skin="png.uiLib.button" x="655" y="1" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_add" width="99" height="22"/>
			</View>;
		public function StorageUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.StorageRenderUI"] = StorageRenderUI;
			createView(uiXML);
		}
	}
}