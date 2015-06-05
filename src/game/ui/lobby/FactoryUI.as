/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.ItemListUI;
	public class FactoryUI extends View {
		public var factory:ItemListUI;
		public var cb_type:ComboBox;
		public var cb_l:CheckBox;
		public var cb_m:CheckBox;
		public var cb_h:CheckBox;
		public var info:Container;
		public var icon:Image;
		public var btn_buy:Button;
		public var txt_name:Label;
		public var gun:Label;
		public var ta:Label;
		public var fdj:Label;
		public var dai:Label;
		public var gou_gun:Image;
		public var gou_fdj:Image;
		public var gou_dai:Image;
		public var money:Label;
		public var rate:Label;
		public var gou_ta:Image;
		public var gun_lv:Label;
		public var ta_lv:Label;
		public var fdj_lv:Label;
		public var dai_lv:Label;
		public var txt_attack:Label;
		public var txt_hp:Label;
		public var txt_shoot_rate:Label;
		public var txt_speed:Label;
		public var txt_chuan:Label;
		public var txt_armor:Label;
		public var select_tip:Image;
		public var how:Button;
		protected var uiXML:XML =
			<View>
			  <ItemList x="0" y="35" var="factory" runtime="game.ui.lobby.ItemListUI"/>
			  <Image url="png.uiLib.bg2" x="571" y="2" sizeGrid="4,4,4,4" width="180" height="460" alpha="0.1"/>
			  <ComboBox labels="全系列,M系,D系,S系" skin="png.uiLib.combobox" x="8" y="5.5" width="143" height="23" sizeGrid="4,4,40,4" labelColors="0xcccccc,0xcccccc,0xcccccc,0xcccccc" selectedIndex="0" var="cb_type"/>
			  <CheckBox label="轻型战车" skin="png.uiLib.checkbox" x="174" y="8.75" labelColors="0xCCCCCC" var="cb_l"/>
			  <CheckBox label="中型战车" skin="png.uiLib.checkbox" x="263" y="8.75" labelColors="0xCCCCCC" var="cb_m"/>
			  <CheckBox label="重型战车" skin="png.uiLib.checkbox" x="352" y="8.75" labelColors="0xCCCCCC" var="cb_h"/>
			  <Container x="573" y="4" var="info">
			    <Image url="png.uiLib.tank" y="27" width="160" height="100" var="icon" x="7"/>
			    <Button label="制造战车" skin="png.uiLib.button" y="422" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" width="170" height="30" var="btn_buy" x="4"/>
			    <Label text="430工程" x="8" width="163" height="18" color="0xffffff" var="txt_name" y="5"/>
			    <Image url="jpg.uiLib.pao_guan" x="16" y="201"/>
			    <Image url="jpg.uiLib.pao_tai" x="98" y="201"/>
			    <Image url="jpg.uiLib.lv_dai" x="99" y="286"/>
			    <Image url="jpg.uiLib.fa_dong_ji" x="17" y="287"/>
			    <Label text="100/200" x="20" y="263" width="57" height="18" color="0xff00" align="center" var="gun"/>
			    <Label text="100/36" x="98" y="264" width="57" height="18" color="0xff0000" align="center" var="ta"/>
			    <Label text="300/300" x="20" y="349" width="57" height="18" color="0xff00" align="center" var="fdj"/>
			    <Label text="100/263" x="98" y="350" width="57" height="18" color="0xff00" align="center" var="dai"/>
			    <Label text="炮" y="240" width="34" height="18" color="0xcccccc" align="center" x="28"/>
			    <Label text="炮塔" x="100" y="241" width="58" height="18" color="0xcccccc" align="center"/>
			    <Label text="发动机" x="21" y="328" width="54" height="18" color="0xcccccc" align="center"/>
			    <Label text="履带" x="100" y="328" width="56" height="18" color="0xcccccc" align="center"/>
			    <Image url="png.uiLib.gou" x="60" y="201" var="gou_gun"/>
			    <Image url="png.uiLib.gou" x="58" y="291" var="gou_fdj"/>
			    <Image url="png.uiLib.gou" x="140" y="291" var="gou_dai"/>
			    <Label text="消耗银币:90000" x="19" y="376" width="125" height="18" color="0xffffff" var="money" isHtml="true"/>
			    <Label text="成功率:100%" x="19" y="395" width="125" height="18" color="0xffffff" var="rate" isHtml="true"/>
			    <Image url="png.uiLib.gou" x="138" y="203" var="gou_ta"/>
			    <Label text="Ⅰ" y="202" width="34" height="18" color="0xffffff" align="left" x="19" var="gun_lv"/>
			    <Label text="Ⅰ" y="202" width="34" height="18" color="0xffffff" align="left" x="98" var="ta_lv"/>
			    <Label text="Ⅰ" y="289" width="34" height="18" color="0xffffff" align="left" x="21" var="fdj_lv"/>
			    <Label text="Ⅰ" y="288" width="34" height="18" color="0xffffff" align="left" x="100" var="dai_lv"/>
			    <Label text="杀伤:" x="16" y="129" width="75" height="18" color="0xffffff" align="left" var="txt_attack"/>
			    <Label text="生命:" x="90" y="129" width="84" height="18" color="0xffffff" align="left" var="txt_hp"/>
			    <Label text="射速:" x="16" y="150" width="77" height="18" color="0xffffff" align="left" var="txt_shoot_rate"/>
			    <Label text="速度:" x="90" y="150" width="81" height="18" color="0xffffff" align="left" var="txt_speed"/>
			    <Label text="穿透:" x="16" y="170" width="78" height="18" color="0xffffff" align="left" var="txt_chuan"/>
			    <Label text="装甲:" x="90" y="170" width="83" height="18" color="0xffffff" align="left" var="txt_armor"/>
			    <Image url="png.uiLib.mouse_over_tip" sizeGrid="4,4,4,4" width="178" height="457" var="select_tip" visible="true" mouseEnabled="false" mouseChildren="false" x="0" y="0"/>
			  </Container>
			  <Button skin="png.uiLib.btn_how" x="531" y="9" var="how"/>
			</View>;
		public function FactoryUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.ItemListUI"] = ItemListUI;
			createView(uiXML);
		}
	}
}