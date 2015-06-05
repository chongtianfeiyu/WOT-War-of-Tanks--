/**Created by the Morn,do not modify.*/
package game.ui.login {
	import morn.core.components.*;
	public class LoginUI extends View {
		public var btnLogin:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.uiLib.bg" x="0" y="-1" sizeGrid="4,30,4,4" width="366" height="354"/>
			  <Button skin="png.uiLib.button" x="118" y="238" width="140" height="35" var="btnLogin" label="开始游戏" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Label text="《钢铁战车》已获得版权登记，受法律保护，请尊重开发者的劳动成果，不得转载、破解、篡改我们的游戏，侵权必究。" x="7" y="306" color="0x666666" width="345" height="39" align="center" multiline="true" wordWrap="true"/>
			  <Label text="（演示版）" x="9" y="27" color="0x666666" width="69" height="21" align="left"/>
			  <Image url="png.uiLib.wot" x="58" y="98"/>
			</View>;
		public function LoginUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}