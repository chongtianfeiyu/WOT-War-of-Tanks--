/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	import game.ui.lobby.BagUI;
	import game.ui.lobby.BattleFieldUI;
	import game.ui.lobby.FactoryUI;
	import game.ui.lobby.RankViewUI;
	import game.ui.lobby.StorageUI;
	import game.ui.lobby.TaskUI;
	public class LobbyUI extends View {
		public var txt_chat:TextInput;
		public var btn_send:Button;
		public var tabs:Tab;
		public var ta_chat:TextArea;
		public var txt_cash:Label;
		public var txt_gold:Label;
		public var txt_vip:Label;
		public var txt_nick:Label;
		public var progress_exp:ProgressBar;
		public var txt_lv:Label;
		public var txt_uid:Label;
		public var btn_setting:Button;
		public var rooms:BattleFieldUI;
		public var store:BagUI;
		public var factory:FactoryUI;
		public var storage:StorageUI;
		public var task:TaskUI;
		protected var uiXML:XML =
			<View>
			  <Image url="jpg.uiLib.bg4" x="0" y="35" width="980" height="665"/>
			  <Image url="png.uiLib.bg3" x="200" y="39" sizeGrid="8,8,8,8" width="775" height="519"/>
			  <Image url="png.uiLib.bg3" x="200" y="563" width="774" height="133" sizeGrid="8,8,8,8"/>
			  <Image url="png.uiLib.bgs" x="204" y="568" width="766" height="99" sizeGrid="5,5,5,5"/>
			  <TextInput text="输入..." skin="png.uiLib.textinput" x="206" y="669" width="662" height="22" color="0xcccccc" var="txt_chat"/>
			  <Button label="发送" skin="png.uiLib.button" x="869" y="670" labelColors="#000000,#000000,#000000,#000000" width="100" height="22" var="btn_send"/>
			  <Image url="png.uiLib.bgs" x="207" y="76" width="761" height="474" sizeGrid="5,5,5,5"/>
			  <Tab labels="战场,车库,工厂,仓库,成就" skin="png.uiLib.tab" x="207" y="47" direction="horizontal" selectedIndex="0" labelColors="0x000000,0xffffff,0xffffff,0xffffff" labelSize="18" var="tabs"/>
			  <TextArea x="207" y="571" isHtml="true" multiline="true" wordWrap="true" width="761" height="95" var="ta_chat" scrollBarSkin="png.uiLib.vscroll" color="0x999999"/>
			  <Container x="0" y="0">
			    <Image url="jpg.uiLib.title" width="980" height="35"/>
			    <Image url="jpg.uiLib.split" x="200" y="3" height="30"/>
			    <ComboBox labels="线路1,线路2,线路3" skin="png.uiLib.combobox" x="44" sizeGrid="4,4,40,4" width="148" height="23" selectedIndex="0" labelColors="0xcccccc,0xcccccc,0xcccccc,0xcccccc" y="6"/>
			    <Label text="银币:99999" x="658" y="9" color="0xffffff" width="105" height="18" var="txt_cash"/>
			    <Label text="金币:99999" x="750" y="9" color="0xffff00" width="105" height="18" var="txt_gold"/>
			    <Label text="VIP:5" x="212" y="9" color="0xffff00" width="44" height="18" var="txt_vip"/>
			    <Label text="玩家的名字名字" x="253" y="7" color="0xcccccc" width="105" height="18" var="txt_nick"/>
			    <ProgressBar skin="png.uiLib.progress" x="353" y="10" value="0.4" width="180" sizeGrid="2,2,2,2" height="14" label="1000/2500" var="progress_exp"/>
			    <Label text="中尉" x="544" y="7" color="0xcccccc" width="50" height="18" var="txt_lv"/>
			    <Image url="png.uiLib.more" x="581" y="11"/>
			    <LinkButton label="充值金币" x="832" y="8" labelColors="0xffff00,0xffff00,0xffff00,0xffff00"/>
			    <Image url="jpg.uiLib.split" x="642" y="3" height="30"/>
			    <Label text="uid:HIGGTYBJBJHIJBJKJKBJJ" x="7" width="184" height="18" var="txt_uid" color="0xcccccc" size="10" y="-23"/>
			    <Button skin="png.uiLib.btn_shop" x="903" y="5"/>
			    <Button skin="png.uiLib.btn_setting" x="7" y="4" var="btn_setting"/>
			  </Container>
			  <BattleField x="213" y="78" var="rooms" visible="false" runtime="game.ui.lobby.BattleFieldUI"/>
			  <Bag x="212" y="81" var="store" runtime="game.ui.lobby.BagUI"/>
			  <Factory x="212" y="81" var="factory" runtime="game.ui.lobby.FactoryUI"/>
			  <RankView x="4" y="39" runtime="game.ui.lobby.RankViewUI"/>
			  <Storage x="211" y="84" var="storage" runtime="game.ui.lobby.StorageUI"/>
			  <Task x="209" y="82" var="task" runtime="game.ui.lobby.TaskUI"/>
			</View>;
		public function LobbyUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.lobby.BagUI"] = BagUI;
			viewClassMap["game.ui.lobby.BattleFieldUI"] = BattleFieldUI;
			viewClassMap["game.ui.lobby.FactoryUI"] = FactoryUI;
			viewClassMap["game.ui.lobby.RankViewUI"] = RankViewUI;
			viewClassMap["game.ui.lobby.StorageUI"] = StorageUI;
			viewClassMap["game.ui.lobby.TaskUI"] = TaskUI;
			createView(uiXML);
		}
	}
}