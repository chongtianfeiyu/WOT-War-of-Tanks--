/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.ItemListUI;
	public class BagUI extends View {
		public var bag:ItemListUI;
		public var txt_cap:Label;
		public var info:Container;
		public var icon:Image;
		public var btn_destory:Button;
		public var skill0:Image;
		public var skill1:Image;
		public var txt_name:Label;
		public var skill2:Image;
		public var skill3:Image;
		public var btn_main:Button;
		public var stars:Container;
		public var star4:Image;
		public var star3:Image;
		public var star2:Image;
		public var star1:Image;
		public var star0:Image;
		public var txt_attack:Label;
		public var txt_chuan:Label;
		public var txt_shoot_rate:Label;
		public var txt_hp:Label;
		public var txt_armor:Label;
		public var txt_move_speed:Label;
		public var select_tip:Image;
		public var how:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="571" y="2" sizeGrid="4,4,4,4" width="180" height="460" alpha="0.1"/>
			  <ItemList x="0" y="35" var="bag" runtime="game.ui.lobby.ItemListUI"/>
			  <ComboBox labels="全系列,M系,D系,S系" skin="png.uiLib.combobox" x="8" y="5" width="104" height="23" sizeGrid="4,4,40,4" labelColors="0xcccccc,0xcccccc,0xcccccc,0xcccccc" selectedIndex="0"/>
			  <CheckBox label="轻型战车" skin="png.uiLib.checkbox" x="134" y="8" labelColors="0xCCCCCC"/>
			  <CheckBox label="中型战车" skin="png.uiLib.checkbox" x="223" y="8" labelColors="0xCCCCCC"/>
			  <CheckBox label="重型战车" skin="png.uiLib.checkbox" x="312" y="8" labelColors="0xCCCCCC"/>
			  <Label text="车库容量(3/5)" x="394" y="6" width="104" height="18" color="0xffffff" var="txt_cap" align="center"/>
			  <Container x="572" y="3" var="info" mouseEnabled="false">
			    <Image url="png.uiLib.tank" y="15" width="160" height="100" var="icon" x="11"/>
			    <Image url="png.uiLib.bgs" x="21" y="215" width="60" height="60" sizeGrid="4,4,4,4"/>
			    <Image url="png.uiLib.bgs" x="90" y="215" width="60" height="60" sizeGrid="4,4,4,4"/>
			    <Button label="回收" skin="png.uiLib.button" x="4" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" width="170" height="25" var="btn_destory" y="428"/>
			    <Image url="png.uiLib.bgs" x="22" y="281" width="60" height="60" sizeGrid="4,4,4,4"/>
			    <Image url="png.uiLib.bgs" x="91" y="281" width="60" height="60" sizeGrid="4,4,4,4"/>
			    <Image url="png.uiLib.Loader_desperado" x="26" y="220" var="skill0"/>
			    <Image url="png.uiLib.Loader_intuition" x="95" y="219" var="skill1"/>
			    <Label text="谢尔曼M4" x="9" width="106" height="18" color="0x999999" var="txt_name" y="2"/>
			    <Image url="png.uiLib.Loader_pedant" x="26" y="286" var="skill2"/>
			    <Image url="png.uiLib.Repair" x="96" y="286" var="skill3"/>
			    <Button label="设置为主力战车" skin="png.uiLib.button" y="395" labelColors="0xffff00,0xffff00,0xffff00,0xffff00" width="170" height="30" var="btn_main" x="4"/>
			    <Label text="战车特性:" x="9" y="194" width="78" height="18" color="0x999999" size="12"/>
			    <Container x="105" y="5" var="stars">
			      <Image url="png.uiLib.star" var="star4"/>
			      <Image url="png.uiLib.star" x="13" var="star3"/>
			      <Image url="png.uiLib.star" x="26" var="star2"/>
			      <Image url="png.uiLib.star" x="39" var="star1"/>
			      <Image url="png.uiLib.star" x="52" var="star0"/>
			    </Container>
			    <Label text="战车属性:" x="9" y="116" width="78" height="18" color="0x999999" size="12"/>
			    <Label text="杀伤:100" x="17" y="135" width="78" height="18" color="0xffffff" size="12" var="txt_attack"/>
			    <Label text="穿透:100" x="17" y="154" width="78" height="18" color="0xffffff" size="12" var="txt_chuan"/>
			    <Label text="射速:100" x="17" y="174" width="78" height="18" color="0xffffff" size="12" var="txt_shoot_rate"/>
			    <Label text="生命:100" x="95" y="135" width="78" height="18" color="0xffffff" size="12" var="txt_hp"/>
			    <Label text="装甲:100" x="95" y="154" width="78" height="18" color="0xffffff" size="12" var="txt_armor"/>
			    <Label text="速度:100" x="95" y="174" width="78" height="18" color="0xffffff" size="12" var="txt_move_speed"/>
			    <Label text="战车战绩:" x="9" y="349" width="78" height="18" color="0x999999" size="12"/>
			    <Label text="歼敌:100" x="17" y="369" width="78" height="18" color="0xffffff" size="12"/>
			    <Label text="被毁:100" x="97" y="369" width="78" height="18" color="0xffffff" size="12"/>
			    <Image url="png.uiLib.mouse_over_tip" sizeGrid="4,4,4,4" width="178" height="457" var="select_tip" visible="true" x="0" y="0" mouseEnabled="false" mouseChildren="false"/>
			  </Container>
			  <Button skin="png.uiLib.btn_how" x="532" y="9" var="how"/>
			</View>;
		public function BagUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.ItemListUI"] = ItemListUI;
			createView(uiXML);
		}
	}
}