/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.RankListUI;
	public class RankViewUI extends View {
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg3" x="0" y="0" sizeGrid="8,8,8,8" width="193" height="651"/>
			  <Button label="&lt;" skin="png.uiLib.button" x="9" y="623" width="53" height="22" labelColors="#000000,#000000,#000000,#000000"/>
			  <Button label=">" skin="png.uiLib.button" x="131" y="623" width="56" height="22" labelColors="#000000,#000000,#000000,#000000"/>
			  <TextInput text="1/10" skin="png.uiLib.textinput" x="65" y="623" width="62" height="22" color="0xcccccc" align="center"/>
			  <Image url="png.uiLib.bgs" x="6" y="30" width="181" height="589" sizeGrid="5,5,5,5"/>
			  <RankList x="9" y="34" runtime="game.ui.lobby.RankListUI"/>
			  <Label text="战斗力排行榜" x="29" y="8" color="0xcccccc" width="133" height="18" align="center"/>
			  <Label text="我的荣誉点:12487 排名:10000" x="9" y="598" width="176" height="18" color="0xffffff" align="left"/>
			</View>;
		public function RankViewUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.RankListUI"] = RankListUI;
			createView(uiXML);
		}
	}
}