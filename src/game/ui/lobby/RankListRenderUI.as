/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class RankListRenderUI extends View {
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="0" y="0" sizeGrid="4,4,4,4" width="175" height="28" alpha="0.1"/>
			  <Label text="999" x="3" y="6" width="27" height="18" color="0xcccccc"/>
			  <Label text="玩家的名字哦" x="34" y="6" width="84" height="18" color="0xcccccc"/>
			  <Label text="999999" x="116" y="5" width="52" height="18" color="0xcccccc" align="right"/>
			</View>;
		public function RankListRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}