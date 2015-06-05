package game.plugin.battle.model
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
	import com.smartfoxserver.v2.entities.variables.UserVariable;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.LeaveRoomRequest;
	import com.smartfoxserver.v2.requests.PrivateMessageRequest;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	import com.smartfoxserver.v2.requests.SetUserVariablesRequest;
	
	import flash.geom.Point;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.battle.model.vo.SendPosVO;
	import game.plugin.battle.model.vo.SendShootVO;
	import game.plugin.battle.model.vo.TankHpVO;
	import game.plugin.battle.model.vo.TankInitVO;
	import game.plugin.battle.model.vo.TankMoveVO;
	import game.plugin.battle.model.vo.TankShootVO;
	import game.plugin.battle.model.vo.TankStopVO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BattleRoomProxy extends Proxy
	{
		public static const NAME:String="BattleRoomProxy";
		public function BattleRoomProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void
		{
			GM.fun.sfs.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVarsUpdate);
			GM.fun.sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE,onPublicMsg);
			GM.fun.sfs.addEventListener(SFSEvent.PRIVATE_MESSAGE,onPrivateMsg);
			GM.fun.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE,onExt);
		}
		
		protected function onExt(event:SFSEvent):void
		{
//			signaling  （单用户发送）
//			broadcast  （广播）
			var cmd:String = event.params.cmd;
			var params:ISFSObject = event.params.params;
			GM.fun.console.echo(cmd,params.getUtfString("msg"));
		}
		
		protected function onPrivateMsg(event:SFSEvent):void
		{
			var sender:User = event.params.sender; // sender可能是null
			var msg:String = event.params.message;
			var arr:Array = msg.split("##");
			var cmd:String = arr[0];
			msg = arr[1];
			switch(cmd)
			{
				case "kill":
					killTank(sender);
					break;
			}
		}
		
		private function killTank(sender:User):void
		{
			var user:User = GM.fun.sfs.mySelf;
			if(sender != user)
			{
				var ukv:UserVariable = user.getVariable("kl");
				if(ukv)
				{
					var kills:int = ukv.getIntValue();
					kills++;
					setKills(kills);
				}
			}
			
					
		}
		
		override public function onRemove():void
		{
			GM.fun.sfs.removeEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVarsUpdate);
			GM.fun.sfs.removeEventListener(SFSEvent.PUBLIC_MESSAGE,onPublicMsg);
			GM.fun.sfs.addEventListener(SFSEvent.PRIVATE_MESSAGE,onPrivateMsg);
		}
		
		protected function onUserVarsUpdate(event:SFSEvent):void
		{
			var changedVars:Array = event.params.changedVars as Array;
			var user:User = event.params.user as User;
			
			if (changedVars.indexOf("ix") != -1 || changedVars.indexOf("iy") != -1)
			{
				checkUserInit(user);
			}
			
			if(changedVars.indexOf("hp") != -1)
			{
				var hp:int = user.getVariable("hp").getIntValue();
				var hpvo:TankHpVO = new TankHpVO();
				hpvo.user = user;
				hpvo.hp = hp;
				facade.sendNotification(CMD.TANK_HP,hpvo);
			}
			
			if(changedVars.indexOf("kl") != -1)
			{
//				var kills:int = user.getVariable("kl").getIntValue();
//				var kvo:TankKillsVO = new TankKillsVO();
//				kvo.kills = kills;
				facade.sendNotification(CMD.TANK_KILLS);
			}
			
		}
		
		protected function onPublicMsg(event:SFSEvent):void
		{
			var sender:User = event.params.sender; // sender可能是null
			var msg:String = event.params.message;
			var arr:Array = msg.split("##");
			var cmd:String = arr[0];
			msg = arr[1];
			switch(cmd)
			{
				case "chat":
					showChat(sender,msg);
					break;
				
				case "shoot":
					showShoot(sender,msg);
					break;
				
				case "move":
					showMove(sender,msg);
					break;
				
				case "stop":
					showStop(sender,msg);
					break;
			}
			
		}
		
		/**
		 * 将先 加载完的 客户端的坦克显示出来
		 */
		public function checkTanksExist():void
		{
			var rm:Room = GM.fun.sfs.lastJoinedRoom;
			if(rm)
			{
				var users:Array = rm.userList;
				var i:int = users.length;
				var u:User;
				while(i--)
				{
					u = users[i];
					if(u)
					{
						checkUserInit(u);
					}
				}
			}
			
		}
		
		private function checkUserInit(user:User):void
		{
			var ubx:UserVariable = user.getVariable("ix");
			var uby:UserVariable = user.getVariable("iy");
			var unk:UserVariable = user.getVariable("nk");
			if(ubx && uby && unk)
			{
				var ix:int = ubx.getIntValue();
				var iy:int = uby.getIntValue();
				GM.fun.console.echo(ix,iy);
				var ivo:TankInitVO = new TankInitVO();
				ivo.ix = ix;
				ivo.iy = iy;
				ivo.nick = unk.getStringValue();
				ivo.user = user;
				facade.sendNotification(CMD.TANK_INIT,ivo);
			}
		}
		
		private function showStop(sender:User, msg:String):void
		{
//			var msg:String = "move##"+vo.ix+","+vo.iy		
			var arr:Array = msg.split(",");
			var ix:int = int(arr[0]);
			var iy:int = int(arr[1]);
			var vo:TankStopVO = new TankStopVO();
			vo.ix = ix;
			vo.iy = iy;
			vo.user = sender;
			facade.sendNotification(CMD.TANK_STOP,vo);
		}
		
		private function showMove(sender:User, msg:String):void
		{
//			var msg:String = "move##"+vo.ix+","+vo.iy+","+vo.t;
			var arr:Array = msg.split(",");
			var ix:int = int(arr[0]);
			var iy:int = int(arr[1]);
			var t:Number = Number(arr[2]);
			var vo:TankMoveVO = new TankMoveVO();
			vo.ix = ix;
			vo.iy = iy;
			vo.t = t;
			vo.user = sender;
			facade.sendNotification(CMD.TANK_MOVE,vo);
		}
		
		private function showChat(sender:User,msg:String):void
		{
			
		}
		
		private function showShoot(sender:User,msg:String):void
		{
			//"shoot##"+vo.sp.x+","+vo.sp.y+"|"+vo.ep.x+","+vo.ep.y+"|"+vo.t;
			var arr:Array = msg.split("|");
			var sp_str:String = arr[0];
			var ep_str:String = arr[1];
			var t:Number = Number(arr[2]);
			
			arr = sp_str.split(",");
			
			var sp:Point = new Point(int(arr[0]),int(arr[1]));
			
			arr = ep_str.split(",");
			
			var ep:Point = new Point(int(arr[0]),int(arr[1]));
			
			var vo:TankShootVO = new TankShootVO();
			vo.user = sender;
			vo.sp = sp;
			vo.ep = ep;
			vo.t = t;
			
			facade.sendNotification(CMD.TANK_SHOOT,vo);
		}
		
		private function showAimAt(sender:User,msg:String):void
		{
			
		}
		
		/**
		 * 通过私聊借口，发送消息
		 */
		private function sendMsgToOne(msg:String,uid:int):void
		{
			var req:PrivateMessageRequest = new PrivateMessageRequest(msg,uid);
			GM.fun.sfs.send(req);
		}
		
		public function beKilledByUser(uid:int):void
		{
			var msg:String = "kill##";
			sendMsgToOne(msg,uid);
		}
		
		/**
		 * 通过公共聊天接口，广播消息
		 */
		private function sendMsg(msg:String):void
		{
			var req:PublicMessageRequest = new PublicMessageRequest(msg);
			GM.fun.sfs.send(req);
		}
		
		public function sendChat(s:String):void
		{
			var msg:String = "chat##"+s;
			sendMsg(msg);
		}
		
		public function sendShoot(vo:SendShootVO):void
		{
			var msg:String = "shoot##"+vo.sp.x+","+vo.sp.y+"|"+vo.ep.x+","+vo.ep.y+"|"+vo.t;
			sendMsg(msg);
//			好，那参数 就roomId, userId, type吧
//			type=1不发给自己
//			var params:ISFSObject = new SFSObject();
//			params.putInt("roomId", GM.fun.sfs.lastJoinedRoom.id);
//			params.putInt("userId", GM.fun.sfs.mySelf.id);
//			params.putInt("type", 0);
//			params.putUtfString("msg","hello fox !");
//			var req:ExtensionRequest = new ExtensionRequest("broadcast",params);
//			var req:ExtensionRequest = new ExtensionRequest("signaling",params);
//			GM.fun.sfs.send(req);
		}
		
		public function sendMove(vo:SendPosVO):void
		{
			var msg:String = "move##"+vo.ix+","+vo.iy+","+vo.t;
			sendMsg(msg);
		}
		
		public function sendStop(vo:SendPosVO):void
		{
			var msg:String = "stop##"+vo.ix+","+vo.iy;
			sendMsg(msg);
		}
		
		/**
		 * 设置玩家的位置
		 */
		public function setMyPos(ix:int,iy:int):void
		{
			// Create some User Variables
			var userVars:Array = [];
			userVars.push(new SFSUserVariable("ix", ix));
			userVars.push(new SFSUserVariable("iy", iy));
			
			userVars.push(new SFSUserVariable("hp", 100));// 重生都满血
			
			GM.fun.sfs.send(new SetUserVariablesRequest(userVars));
		}
		
		/**
		 * 设置玩家的血量
		 */
		public function setMyHP(hp:int):void
		{
			var userVars:Array = [];
			userVars.push(new SFSUserVariable("hp", hp));
			
			GM.fun.sfs.send(new SetUserVariablesRequest(userVars));
		}
		
		public function setInBattle(tankId:String,nick:String,ix:int,iy:int):void
		{
			var userVars:Array = [];
			userVars.push(new SFSUserVariable("ix", ix));
			userVars.push(new SFSUserVariable("iy", iy));
			userVars.push(new SFSUserVariable("hp", 100));
			userVars.push(new SFSUserVariable("kl", 0));
			userVars.push(new SFSUserVariable("nk", nick));
			userVars.push(new SFSUserVariable("tk", tankId));
			GM.fun.sfs.send(new SetUserVariablesRequest(userVars));
		}
		
		/**
		 * 击毁敌人的次数
		 */
		public function setKills(kill:int):void
		{
			var userVars:Array = [];
			userVars.push(new SFSUserVariable("kl", kill));
			
			GM.fun.sfs.send(new SetUserVariablesRequest(userVars));
		}
		
		public function leaveBattle():void
		{
			var req:LeaveRoomRequest = new LeaveRoomRequest();
			GM.fun.sfs.send(req);
		}
	}
}