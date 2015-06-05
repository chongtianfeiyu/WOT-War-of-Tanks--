/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.ItemRenderUI;
	public class ItemListUI extends View {
		public var list:List;
		protected var uiXML:XML =
			<View>
			  <List repeatY="5" spaceY="3" x="0" y="0" var="list">
			    <VScrollBar skin="png.uiLib.vscroll" x="552" y="1" width="17" height="425" name="scrollBar"/>
			    <ItemRender x="0" y="0" name="render" runtime="game.ui.lobby.ItemRenderUI"/>
			  </List>
			</View>;
		public function ItemListUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.ItemRenderUI"] = ItemRenderUI;
			createView(uiXML);
		}
	}
}