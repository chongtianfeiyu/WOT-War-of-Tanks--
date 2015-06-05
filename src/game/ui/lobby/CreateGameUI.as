/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class CreateGameUI extends View {
		public var btn_yes:Button;
		public var btn_no:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg" x="1" y="1" width="278" height="326" sizeGrid="8,40,8,8"/>
			  <Button label="创建" skin="png.uiLib.button" x="44" y="248" width="200" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_yes"/>
			  <Button label="取消" skin="png.uiLib.button" x="44" y="285" width="200" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_no"/>
			  <ComboBox labels="沙漠风暴,密林小镇" skin="png.uiLib.combobox" x="44" y="82" width="200" height="23" sizeGrid="4,4,40,4" selectedIndex="0"/>
			  <Label text="地图" x="44" y="56" color="0xffffff" width="39" height="18"/>
			  <Label text="人数" x="44" y="125" color="0xffffff" width="39" height="18"/>
			  <ComboBox labels="3v3,5v5,10v10" skin="png.uiLib.combobox" x="44" y="154" width="200" height="23" sizeGrid="4,4,40,4" selectedIndex="0"/>
			  <Label text="创建战场" x="101" y="4" color="0xffffff" width="90" height="18" align="center"/>
			</View>;
		public function CreateGameUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}