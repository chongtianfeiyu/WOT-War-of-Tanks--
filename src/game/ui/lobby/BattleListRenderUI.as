/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class BattleListRenderUI extends View {
		public var view:ViewStack;
		public var txt_id:Label;
		public var txt_map:Label;
		public var txt_state:Label;
		public var txt_players:Label;
		public var txt_creator:Label;
		public var btn_join:Button;
		public var btn_new:Button;
		public var cb_map:ComboBox;
		public var cb_max:ComboBox;
		public var cb_mode:ComboBox;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="0" y="0" width="727" height="42" sizeGrid="4,4,4,4" alpha="0.1"/>
			  <ViewStack x="15" y="4" selectedIndex="true" var="view">
			    <Box name="item0" y="2">
			      <Label text="ID:123" y="6" width="66" height="18" color="0xffffff" var="txt_id"/>
			      <Label text="地图:锡默尔斯多夫" x="59" y="6" width="143" height="18" color="0xffffff" var="txt_map"/>
			      <Label text="状态:准备中" x="288" y="6" width="79" height="18" color="0xffffff" var="txt_state"/>
			      <Label text="人数:10vs10" x="192" y="6" width="82" height="18" color="0xffffff" var="txt_players"/>
			      <Label text="创建者:坑爹刚弄死他" x="382" y="6" width="131" height="18" color="0xffffff" var="txt_creator"/>
			      <Button label="加入" skin="png.uiLib.button" x="535" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_join" height="30" width="150" y="0"/>
			    </Box>
			    <Box name="item1" visible="true" width="713" height="30">
			      <Button label="创建新战场" skin="png.uiLib.button" x="535" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="btn_new" height="30" width="150" y="2"/>
			      <ComboBox labels="锡默尔斯多夫,北非战场,北欧小镇" skin="png.uiLib.combobox" x="54" y="5.5" selectedIndex="0" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" width="127" height="23" sizeGrid="4,4,40,4" var="cb_map"/>
			      <ComboBox labels="1,2,3,4,5,6,7,8,9,10" skin="png.uiLib.combobox" x="241" y="5.5" selectedIndex="0" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" sizeGrid="4,4,40,4" var="cb_max"/>
			      <Label text="地图：" x="-4" y="8" width="41" height="18" color="0xcccccc"/>
			      <Label text="人数：" x="200" y="8" width="38" height="18" color="0xcccccc"/>
			      <ComboBox labels="团队模式,混战模式,生死模式" skin="png.uiLib.combobox" x="391" y="5.5" selectedIndex="0" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" sizeGrid="4,4,40,4" var="cb_mode"/>
			      <Label text="模式：" x="350" y="8" width="38" height="18" color="0xcccccc"/>
			    </Box>
			  </ViewStack>
			</View>;
		public function BattleListRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}