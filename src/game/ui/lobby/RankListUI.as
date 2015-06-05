/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.RankListRenderUI;
	public class RankListUI extends View {
		protected var uiXML:XML =
			<View repeatY="20">
			  <List x="1" y="0" repeatY="20">
			    <RankListRender name="render" runtime="game.ui.lobby.RankListRenderUI"/>
			  </List>
			</View>;
		public function RankListUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.RankListRenderUI"] = RankListRenderUI;
			createView(uiXML);
		}
	}
}