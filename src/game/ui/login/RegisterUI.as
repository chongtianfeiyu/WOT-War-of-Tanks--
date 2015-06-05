/**Created by the Morn,do not modify.*/
package game.ui.login {
	import morn.core.components.*;
	public class RegisterUI extends View {
		public var btnReg:Button;
		public var txtNick:TextInput;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg" x="0" y="0" sizeGrid="4,30,4,4" width="366" height="230"/>
			  <Button skin="png.uiLib.button" x="116" y="166" width="140" height="23" var="btnReg" label="注册" labelColors="#000000,#ffffff,#000000,#000000"/>
			  <TextInput skin="png.uiLib.textinput" x="116" y="95" width="140" var="txtNick" align="center" stroke="ox000000,1,2,2,2,1" color="0xffffff" text="player"/>
			  <Label text="注册玩家" x="152" y="2"/>
			  <Label text="输入昵称" x="127" y="71" width="121" height="18" color="0xcccccc" align="center"/>
			</View>;
		public function RegisterUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}