/**Created by the Morn,do not modify.*/
package game.ui.battle {
	import morn.core.components.*;
	public class GameOverUI extends View {
		public var btn_back:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg" x="0" y="0" sizeGrid="4,40,4,4" width="400" height="319"/>
			  <Image url="png.uiLib.bg3" x="10" y="31" width="377" height="248" sizeGrid="4,4,4,4"/>
			  <Button label="返回大厅" skin="png.uiLib.button" x="13" y="286" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_back" width="372" height="22"/>
			  <Label text="游戏结束" x="116" y="1" width="173" height="18" color="0xcccccc" align="center"/>
			  <Image url="jpg.uiLib.pao_guan" x="48" y="136"/>
			  <Image url="jpg.uiLib.pao_tai" x="130" y="136"/>
			  <Image url="jpg.uiLib.lv_dai" x="296" y="135"/>
			  <Image url="jpg.uiLib.fa_dong_ji" x="214" y="136"/>
			  <Button label="再次打扫战场" skin="png.uiLib.button" x="127" y="228" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" width="132" height="22"/>
			  <Label text="战利品" x="28" y="108" width="173" height="18" color="0xcccccc" align="left"/>
			  <Label text="100金币" x="130" y="206" width="129" height="18" color="0xffff00" align="center"/>
			  <Label text="战报" x="28" y="36" width="173" height="18" color="0xcccccc" align="left"/>
			  <Label text="经验 +200  战斗力 -15 银币 +230" x="45" y="76" width="238" height="18" color="0xffffff" align="left"/>
			  <Label text="+10" x="66" y="175" width="35" height="18" color="0xffffff" align="right"/>
			  <Label text="+10" x="149" y="174" width="35" height="18" color="0xffffff" align="right"/>
			  <Label text="+0" x="234" y="174" width="35" height="18" color="0xffffff" align="right"/>
			  <Label text="+1" x="316" y="174" width="35" height="18" color="0xffffff" align="right"/>
			</View>;
		public function GameOverUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}