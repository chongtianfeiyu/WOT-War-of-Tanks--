/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.BattleListRenderUI;
	public class BattleFieldUI extends View {
		public var list:List;
		protected var uiXML:XML =
			<View name="render">
			  <List x="-1" y="27" repeatY="10" spaceY="2" var="list">
			    <BattleListRender name="render" y="0" runtime="game.ui.lobby.BattleListRenderUI"/>
			    <VScrollBar skin="png.uiLib.vscroll" x="733" y="0" width="17" height="440" name="scrollBar"/>
			  </List>
			  <Label text="战场的提示文字：创建战场，加入战场，战场模式 巴拉巴拉！！！！" x="3" y="3" width="714" height="18" color="0xcccccc"/>
			</View>;
		public function BattleFieldUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.BattleListRenderUI"] = BattleListRenderUI;
			createView(uiXML);
		}
	}
}