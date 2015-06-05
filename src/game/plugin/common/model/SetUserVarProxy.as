package game.plugin.common.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
	import com.smartfoxserver.v2.requests.SetUserVariablesRequest;
	
	import game.manager.GM;
	import game.plugin.common.model.vo.SetUserVarVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SetUserVarProxy extends Proxy
	{
		public static const NAME:String = "SetUserVarProxy";
		public function SetUserVarProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVarsUpdate);
		}
		
		protected function onUserVarsUpdate(event:SFSEvent):void
		{
			var changedVars:Array = event.params.changedVars as Array;
			var user:User = event.params.user as User;
			
			// Check if the user changed his x and y user variables
			if (changedVars.indexOf("x") != -1 || changedVars.indexOf("y") != -1)
			{
				// Move the user avatar to a new position
			}
		}
		
		public function setUserVar(vo:SetUserVarVO):void
		{
			var userVars:Array = [];
			userVars.push(new SFSUserVariable("id", vo.uid));
			userVars.push(new SFSUserVariable("nk", vo.nick));
			
			GM.fun.sfs.send(new SetUserVariablesRequest(userVars));
		}
		
		override public function onRemove():void
		{
			
		}
	}
}