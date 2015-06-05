/**Created by the Morn,do not modify.*/
package game.ui.lobby {
	import morn.core.components.*;
	public class ItemRenderUI extends View {
		public var icon:Image;
		public var txt_desc:Label;
		public var txt_info:Label;
		public var stars:Container;
		public var star4:Image;
		public var star3:Image;
		public var star2:Image;
		public var star1:Image;
		public var star0:Image;
		public var txt_name:Label;
		public var txt_state:Label;
		public var txt_left:Label;
		public var gou_gun:Image;
		public var over_tip:Image;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg2" x="0" y="0" sizeGrid="4,4,4,4" width="550" height="83" alpha="0.1" visible="true" mouseEnabled="true" mouseChildren="true" buttonMode="true"/>
			  <Image url="png.uiLib.tank" x="1" y="1" width="122" height="78" var="icon" mouseChildren="false" mouseEnabled="false"/>
			  <Label text="在1953年到1957年研制的用以取代T-54的中型坦克，制造了几辆原型车。当时苏军较为强调核条件下的生存力，所以在1961年该项目被终止，转而发展432工程。" x="114" y="26" width="434" height="52" multiline="true" wordWrap="true" color="0x666666" var="txt_desc" size="12" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="  (14吨   装甲最大厚度18毫米  炮88毫米)" x="215" y="3" width="330" height="18" color="0xffffff" var="txt_info" mouseChildren="false" mouseEnabled="false" isHtml="true" align="right"/>
			  <Container x="475" y="4" var="stars">
			    <Image url="png.uiLib.star" var="star4"/>
			    <Image url="png.uiLib.star" x="13" var="star3"/>
			    <Image url="png.uiLib.star" x="26" var="star2"/>
			    <Image url="png.uiLib.star" x="39" var="star1"/>
			    <Image url="png.uiLib.star" x="52" var="star0"/>
			  </Container>
			  <Label text="430工程" x="114" y="3" width="130" height="18" color="0xcccccc" var="txt_name" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="已经解锁" x="2" y="61" width="125" height="18" color="0xcccccc" var="txt_state" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Label text="M系" x="2" y="3" width="88" height="18" color="0xcccccc" var="txt_left" mouseChildren="false" mouseEnabled="false" isHtml="true"/>
			  <Image url="png.uiLib.mouse_over_tip" x="0" y="0" sizeGrid="4,4,4,4" width="548" height="82" var="gou_gun" visible="false" alpha="0.2" mouseChildren="false" mouseEnabled="false"/>
			  <Image url="png.uiLib.mouse_over_tip" x="0" y="0" sizeGrid="4,4,4,4" width="548" height="82" var="over_tip" visible="false"/>
			</View>;
		public function ItemRenderUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}