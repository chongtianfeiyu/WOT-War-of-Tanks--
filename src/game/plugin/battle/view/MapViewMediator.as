package game.plugin.battle.view
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	import com.smartfoxserver.v2.entities.User;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import game.global.CMD;
	import game.manager.GM;
	import game.plugin.battle.model.MapProxy;
	import game.plugin.battle.model.vo.SendHpVO;
	import game.plugin.battle.model.vo.SendKilledVO;
	import game.plugin.battle.model.vo.SendPosVO;
	import game.plugin.battle.model.vo.SendShootVO;
	import game.plugin.battle.model.vo.TankHpVO;
	import game.plugin.battle.model.vo.TankInitVO;
	import game.plugin.battle.model.vo.TankMoveVO;
	import game.plugin.battle.model.vo.TankShootVO;
	import game.plugin.battle.model.vo.TankStopVO;
	import game.plugin.battle.model.vo.TankVO;
	import game.plugin.battle.model.vo.TileVO;
	import game.utils.FxQuake;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 地图的显示
	 * 镜头跟踪
	 * 地形的修改
	 */
	public class MapViewMediator extends Mediator
	{
		public static var NAME:String = "BattleViewMediator";
		
		public function MapViewMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		[Embed(source = "game/assets/image/tile_grass1.jpg")]
		private var t_grass1_class:Class;	
		
		[Embed(source = "game/assets/image/tile_grass2.jpg")]
		private var t_grass2_class:Class;
		
		[Embed(source = "game/assets/image/tile_house.jpg")]
		private var t_house_class:Class;
		
		[Embed(source = "game/assets/image/tile_tree.jpg")]
		private var t_tree_class:Class;
		
		private var _bg:Bitmap;
		private var _mark:markBMD;
		private var _render:Bitmap;
		
		private var scene:Sprite;
		override public function onRegister():void
		{
			scene = GM.fun.layer.sceneLayer;
			GM.fun.bLayer.setBattleLayer();
			_mark = new markBMD();//爆炸后的痕迹
			//---------------------------------
			
			keysDown[Keyboard.W] = false;
			keysDown[Keyboard.S] = false;
			keysDown[Keyboard.A] = false;
			keysDown[Keyboard.D] = false;
			GM.fun.layer.stage.addEventListener(KeyboardEvent.KEY_DOWN,_onKeyDown);
			GM.fun.layer.stage.addEventListener(KeyboardEvent.KEY_UP,_onKeyUp);
			GM.fun.layer.stage.addEventListener(Event.ENTER_FRAME,_update);
			GM.fun.layer.stage.addEventListener(MouseEvent.CLICK,_shoot);
		}
		
		override public function listNotificationInterests():Array
		{
			return [CMD.GAME_OVER,CMD.TANK_INIT,CMD.TANK_MOVE,CMD.TANK_STOP,CMD.TANK_SHOOT,CMD.TANK_HP,TimerEvent.TIMER];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var cmd:String = notification.getName();
			switch(cmd)
			{
				case CMD.TANK_INIT:
					var ivo:TankInitVO = notification.getBody() as TankInitVO;
					if(ivo)
					{
						createTankByInitVO(ivo);
					}
					break;
				
				case CMD.TANK_MOVE:
					var tmvo:TankMoveVO = notification.getBody() as TankMoveVO;
					moveTank(tmvo);
					break;
				
				case CMD.TANK_STOP:
					var tstvo:TankStopVO = notification.getBody() as TankStopVO;
					stopTank(tstvo);
					break;
				
				case CMD.TANK_SHOOT:
					var tsvo:TankShootVO = notification.getBody() as TankShootVO;
					onTankShoot(tsvo);
					break;
				
				case CMD.TANK_HP:
					var hpvo:TankHpVO = notification.getBody() as TankHpVO;
					onTankHP(hpvo);
					break;
				
				case TimerEvent.TIMER:
					checkMiniMap();
					break;
				
				case CMD.GAME_OVER:
					isGameOver = true;
					GM.fun.layer.stage.removeEventListener(KeyboardEvent.KEY_DOWN,_onKeyDown);
					GM.fun.layer.stage.removeEventListener(KeyboardEvent.KEY_UP,_onKeyUp);
					GM.fun.layer.stage.removeEventListener(Event.ENTER_FRAME,_update);
					GM.fun.layer.stage.removeEventListener(MouseEvent.CLICK,_shoot);
					break;
			}
		}
		
		private var isGameOver:Boolean;
		private function onTankHP(vo:TankHpVO):void
		{
			var u:User = vo.user;
			var hp:int = vo.hp;
			var tank:mcTank = getTankByUserId(u.id);
			if(tank)
			{
				if(hp <= 0 && u == GM.fun.sfs.mySelf)//如果自己死了，就重生。
				{
//					FxFilter.gray(tank);
					facade.sendNotification(CMD.NET_SEND_INIT);
				}
				var mc:mcNick = tank.getChildByName("mc_nick") as mcNick;
				mc.txt_nick.text = ""+mc.nick+"("+vo.hp+"%)";
			}
		}		
		
		private function createTankByInitVO(vo:TankInitVO):void
		{
			var mp:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			var tvo:TankVO = new TankVO();
			var p:Point = mp.getPos(vo.ix,vo.iy);
			tvo.x = p.x;
			tvo.y = p.y
			tvo.name = vo.nick;
			tvo.id = vo.user.id;
			createTank(tvo);
		}
		
		private function stopTank(vo:TankStopVO):void
		{
			var tk:mcTank = getTankByUserId(vo.user.id);
			if(tk)
			{
				TweenMax.killTweensOf(tk);
				tk.x = vo.ix;
				tk.y = vo.iy;
				_showTankStop(tk);
			}
			
		}
		
		private function moveTank(vo:TankMoveVO):void
		{
//			var mp:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			var tk:mcTank = getTankByUserId(vo.user.id);
			var p:Point = new Point(vo.ix,vo.iy);
			
			var dx:Number = p.x - tk.x;
			var dy:Number = p.y - tk.y;
			
			var degree:Number = Math.atan2(dy, dx);	/** 正切函数 tanθ=y/x */
			var radius:Number =  degree * 180 / Math.PI + 90;
//			tk.mcBottom.rotation = tk.mcHit.rotation = tk.mcTracks.rotation = radius+90;
			var tr:Number = tk.mcBottom.rotation;
			if(tr < 0)
			{
				tr = 360 + tr;
			}
			var dr:Number = radius - tr;
			if(Math.abs(dr) > 180) //如果旋转大于180度 就反过来转
			{
				dr = -dr*(360 - Math.abs(dr))/Math.abs(dr);
			}
			
			var rt:Number = 0;
			if(dr%180 != 0 )
			{
				rt = Math.abs(dr/360)*2;
				TweenMax.to(tk.mcBottom,rt,{rotation:""+dr});
				TweenMax.to(tk.mcHit,rt,{rotation:""+dr});
				TweenMax.to(tk.mcTracks,rt,{rotation:""+dr});
			}
			
			TweenMax.killTweensOf(tk);
			TweenMax.to(tk,vo.t,{delay:rt,x:p.x,y:p.y,ease:Linear.easeNone});
			
			_showTankMove(tk);
		}
		
		private var isMoveing:Boolean;
//		private function moveOver(user:User):void
//		{
//			if(user.isItMe)
//			{
//				isMoveing = false;
//			}
//			
//			var tk:mcTank = getTankByUserId(user.id);
//			_showTankStop(tk);
//		}
		
		[Embed(source = "game/assets/image/map1.jpg")]
		private var mapClass:Class;	
		private function drawMap():void
		{
			var mp:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			if(mp)
			{
				var map:Bitmap = mp.getMap(mapClass); //new mapClass();
				//开始平铺一个2400×1200的大地图底图
				var w:int = 20;
				var h:int = 40;
				
				
//				var tBMD:BitmapData = new BitmapData(w*mp.size,h*mp.size,false,0xff0000);
//				var arr:Array = mp.getMapData(w,h);
//				var i:int = arr.length;
//				var t:TileVO;
//				while(i--)
//				{
//					t = arr[i];
//					renderTile(tBMD,t);
//				}
				
//				_bg = new Bitmap(tBMD);
				_bg = map;
//				GM.fun.bLayer.groundLayer.addChild(_bg);
				_render = new Bitmap(new BitmapData(GM.fun.layer.stage.stageWidth,GM.fun.layer.stage.stageHeight,false,0x000000));
				GM.fun.bLayer.groundLayer.addChild(_render);
			}

		}
		
		private function renderTile(tBMD:BitmapData, t:TileVO):void
		{
			var bm:Bitmap;
			switch(t.type)
			{
				case 0:
					bm = new t_grass1_class();
					break;
				
				case 1:
					bm = new t_grass2_class();
					break;
				
				case 2:
					bm = new t_house_class();
					break;
				
				case 3:
					bm = new t_tree_class();
					break;
			}
			
			if(bm)
			{
				tBMD.copyPixels(bm.bitmapData,new Rectangle(0,0,t.size,t.size),new Point(t.px,t.py));
			}
			
		}
		
		public function show():void
		{
			isGameOver = false;
			drawMap();
			
			GM.fun.sound.playMusic(GM.fun.url.getMusic("music_battle"),true);
		}
		
		private function _shoot(e:MouseEvent):void
		{
			if(quakeSeed == null)
			{
				sendGunFire();
//				setTimeout(sendGunFire,100);
//				setTimeout(sendGunFire,200);
			}
		}
		
		private var mistake:Number = 0;//误差
		private var shootDis:Number = 0;//射程
		private function sendGunFire():void
		{
			if(!GM.fun.sfs.mySelf)
			{
				return;
			}
			var tk:mcTank = getTankByUserId(GM.fun.sfs.mySelf.id);
//			var mistake:Number = 60; //误差
			var mis:Number = mistake*Math.sin(Math.random()*360);
//			var shootDis:Number = 600;//射程
			
			var sp:Point = new Point(tk.mcGun.mcFire.x,tk.mcGun.mcFire.y);
			sp = tk.mcGun.localToGlobal(sp);
			sp = scene.globalToLocal(sp);
			
			sp.x = int(sp.x);
			sp.y = int(sp.y);
			
			var ep:Point = new Point(scene.mouseX,scene.mouseY);
			shootDis = Point.distance(sp,ep);
			ep = new Point(Math.random()*mis,-shootDis+Math.random()*mis);
			ep = tk.mcGun.localToGlobal(ep);
			
			ep = scene.globalToLocal(ep);
			
			ep.x = int(ep.x);
			ep.y = int(ep.y);
			
			var dis:Number = Point.distance(ep,new Point(tk.x,tk.y));
			var t:Number = dis/1500;
			
			var vo:SendShootVO = new SendShootVO();
			vo.ep = ep;
			vo.sp = sp;
			vo.t = t;
			facade.sendNotification(CMD.NET_SEND_SHOOT,vo);
		}
		
		private function onTankShoot(vo:TankShootVO):void
		{
//			var sp:Point = vo.sp;
			var ep:Point = vo.ep;
			var t:Number = vo.t;
			var user:User = vo.user;
			
			var tk:mcTank = getTankByUserId(user.id);
			
			var dx:Number = ep.x - tk.x;
			var dy:Number = ep.y - tk.y;
			
			var radians:Number = Math.atan2(dy,dx);
			var rotation:Number = radians*180/Math.PI;
			tk.mcGun.mcFire.play();//开炮动画
			tk.mcGun.rotation = rotation+90;//加90度的 偏移量
			
			if(GM.fun.sfs.mySelf == user)
			{
				var dis:Number = Point.distance(ep,new Point(tk.x,tk.y));
				quakeSeed = {};
				quakeSeed.dx = -30*dx/dis;
				quakeSeed.dy = -30*dy/dis;
				screenQuake();//屏幕震动
			}
			
//			sparkFire(tk.mcGun,tk.mcGun.mcFire.x,tk.mcGun.mcFire.y);//开炮特效
			
			GM.fun.sound.playSfx(GM.fun.url.getMusic("sfx_shoot"));//开炮音效
			
			setTimeout(showBoom,t*1000,ep,user);//炸点
			
			var sp:Point = new Point(tk.mcGun.mcFire.x,tk.mcGun.mcFire.y);
			sp = tk.mcGun.localToGlobal(sp);
			sp = scene.globalToLocal(sp);
			
			sp.x = int(sp.x);
			sp.y = int(sp.y);
			flyBullet(t,sp,ep);//炮弹飞行
		}
		
		private function sparkFire(gun:MovieClip,x:Number,y:Number):void
		{
			var i:int = 30;
			var s:Shape;
			while(i--)
			{
				s = new Shape();
				s.graphics.beginFill(0xffffff);
				s.graphics.drawCircle(0,0,0.5+Math.random());
				s.graphics.endFill();
				s.x = x -3+Math.random()*3;
				s.y = y+Math.random();
				gun.addChild(s);
				TweenMax.to(s,Math.random()*0.5+0.3,{y:"-"+(50+50*Math.random()),x:""+Math.sin(Math.random()*360)*10,scaleX:3,scaleY:3,alpha:0,onComplete:onSparkOver,onCompleteParams:[s]});
			}
		}
		
		private function flyBullet(t:Number,sp:Point,ep:Point):void
		{
			var dx:Number = sp.x - ep.x;
			var dy:Number = sp.y - ep.y;
			
			var radians:Number = Math.atan2(dy,dx);
			var rotation:Number = radians*180/Math.PI;
			
			var b:Shape = new Shape();
			b.graphics.lineStyle(2,0xffffff);
			b.graphics.moveTo(0,0)
			b.graphics.lineTo(30+Math.random()*30,0);
			scene.addChild(b);
			b.x = sp.x;
			b.y = sp.y;
			b.rotation = rotation;
			
			TweenMax.to(b,t,{x:ep.x,y:ep.y,ease:Linear.easeNone,onComplete:flyOver,onCompleteParams:[b]});
		}
		
		private function flyOver(b:Shape):void
		{
			b.parent.removeChild(b);
		}
		
		private function onSparkOver(s:Shape):void
		{
			s.parent.removeChild(s);
		}
		
		private function showBoom(p:Point,u:User):void
		{
			var b:MovieClip;
			b = new bomb2();

			b.x = p.x;
			b.y = p.y;
			
			_spark(b.x,b.y,30,80);//模拟碎片飞溅效果2
			GM.fun.bLayer.effectLayer.addChild(b);//爆炸动画
			
			GM.fun.sound.playSfx(GM.fun.url.getMusic("sfx_boom"));
			
			checkHitMe(p,u);
		}
		
		private function checkHitMe(p:Point,u:User):void
		{
			if(GM.fun.sfs.mySelf)
			{
				var tk:mcTank = getTankByUserId(GM.fun.sfs.mySelf.id);	
				if(tk)
				{
					p = GM.fun.bLayer.effectLayer.localToGlobal(p);
					var b:Boolean = tk.mcHit.hitTestPoint(p.x,p.y); GM.fun.console.echo("pt-> ",p.x,p.y,b);
					if(b)
					{
						var svo:SendHpVO = new SendHpVO();
						var hp:int = GM.fun.sfs.mySelf.getVariable("hp").getIntValue();
						hp -= int(Math.random()*25+5);
						if(hp <= 0)
						{
							//死
							svo.hp = 0;
							facade.sendNotification(CMD.NET_SEND_HP,svo);
							
							var kvo:SendKilledVO = new SendKilledVO();
							kvo.uid = u.id;
							facade.sendNotification(CMD.NET_SEND_KILLED,kvo);
//							var mvo:SendMoveVO = new SendMoveVO();
//							mvo.ix = 10;
//							mvo.iy = 10;
//							facade.sendNotification(CMD.NET_SEND_MOVE,mvo);
						}else
						{
							svo.hp = hp;
							facade.sendNotification(CMD.NET_SEND_HP,svo);
						}
					}
				}
			}
			
		}
		
		private function _spark(x:Number,y:Number,r:Number,dr:Number):void
		{
			//把爆炸区域的位图数据取出来
			var fillBmd:BitmapData = new BitmapData(r,r);
			fillBmd.copyPixels(_bg.bitmapData,new Rectangle(x-r*.5,y-r*.5,r,r),new Point(0,0));
			
			//把痕迹绘制到底图
			_bg.bitmapData.copyPixels(_mark,_mark.rect,new Point(x-_mark.width*.5,y-_mark.height*.5));
			var i:int = 10;
			var s:Shape;
			var tx:Number;
			var ty:Number;
			
			var w:int;
			var h:int;
			var ro:int;
			var ang:Number;
			var tr:Number;
			
			var mtx:Matrix;
			
			while(i--)
			{
				ang = Math.random()*360*Math.PI/180;
				tr = r+dr*Math.random();
				tx = Math.sin(ang)*tr;
				ty = Math.cos(ang)*tr;
				s = new Shape();
				s.x = x;
				s.y = y;
				
				s.graphics.beginFill(0x000000,0.5);
				s.graphics.drawRect(-w*.5,-h*.5,w+1,h+1);
				s.graphics.endFill();
				
				mtx = new Matrix();
				mtx.translate(Math.sin(ang)*Math.random()*r*.5,Math.cos(ang)*Math.random()*r*.5);
				s.graphics.beginBitmapFill(fillBmd,mtx);
				w = 1+Math.random()*6;
				h = 1+Math.random()*6;
				s.graphics.drawRect(-w*.5,-h*.5,w,h);
				s.graphics.endFill();
				scene.addChild(s);
				
				ro = Math.sin(Math.random()*360*Math.PI/180)*720
				//ease:Bounce.easeOut
				TweenMax.to(s,.5+Math.random(),{x:""+tx,y:""+ty,rotation:""+r,ease:Expo.easeOut,onComplete:_over,onCompleteParams:[s],onUpdateParams:[s]});
//				TweenMax.to(s,.5+Math.random(),{x:""+tx,y:""+ty,rotation:""+r,ease:Bounce.easeOut,onComplete:_over,onCompleteParams:[s],onUpdateParams:[s]});
			}
			
			setTimeout(_disposeBmd,1600,fillBmd);
		}
		
		private function _disposeBmd(fillBmd:BitmapData):void
		{
			fillBmd.dispose();
		}
		
		private function _over(s:DisplayObject):void
		{
			var bmd:BitmapData = new BitmapData(s.width,s.height,true,0x00000000);
			var mtx:Matrix = new Matrix();
			
			mtx.rotate(s.rotation*Math.PI/180);
			mtx.translate(s.width*.5,s.height*.5);
			
			bmd.draw(s,mtx);
			_bg.bitmapData.copyPixels(bmd,bmd.rect,new Point(s.x - s.width*.40,s.y - s.height*.40));//0.5显示不对
			s.filters = [];
			s.parent.removeChild(s);
		}
		
		private function _update(event:Event):void
		{
			if(isGameOver)
			{
				return;
			}
			
			if(GM.fun.sfs.mySelf)
			{
				var tk:mcTank = getTankByUserId(GM.fun.sfs.mySelf.id);
				if(tk)
				{
					checkGun(tk);
					var p:Point = getFollowPt(tk);
					lookAt(p.x,p.y);
				}
				
				//check mini map
//				checkMiniMap();
			}
		}
		
		private function checkMiniMap():void
		{
			var layer:Sprite = GM.fun.bLayer.tankLayer;
			var i:int = layer.numChildren;
			var tk:mcTank;
			var arr:Array=[];
			while(i--)
			{
				tk = layer.getChildAt(i) as mcTank;
				if(tk)
				{
					arr.push(tk);
				}
			}
			
			facade.sendNotification(CMD.UPDATE_MINI_MAP,arr);
		}
		
		private var quakeSeed:Object;
		private function screenQuake():void
		{
			TweenMax.killTweensOf(quakeSeed);
			TweenMax.to(quakeSeed,0.5,{dx:0,dy:0,ease:Elastic.easeOut,onComplete:quakeOver});
//			TweenMax.to(quakeSeed,1,{dx:0,dy:0,ease:Elastic.easeOut,onComplete:quakeOver});
		}
		
		private function quakeOver():void
		{
			quakeSeed = null;
		}
		
		private var tempRotation:Number;
		
		private var gunRotation:Number=0;
		private var mouseRotation:Number=0;
		private var stepRotation:Number=0;
		private var aim:mcAim;
		private function checkGun(tk:mcTank):void
		{
			TweenMax.killTweensOf(tk.mcGun);
			
			var dx:Number = scene.mouseX - tk.x;
			var dy:Number = scene.mouseY - tk.y;
			
			var degree:Number = Math.atan2(dy, dx);	/** 正切函数 tanθ=y/x */
			var radius:Number =  degree * 180 / Math.PI;
			
			if(radius<0)
			{
				radius+=360;
			}
			mouseRotation = radius;
			if(mouseRotation>0&&mouseRotation<90)
			{
				if(gunRotation>270)
				{
					gunRotation-=360;
				}
			}else if(mouseRotation>270&&mouseRotation<360)
			{
				if(gunRotation<90)
				{
					gunRotation+=360;
				}
			}
			stepRotation = (mouseRotation-gunRotation)*0.05;
			gunRotation+=stepRotation;
			
			tk.mcGun.rotation = gunRotation+90;
			if(aim == null)
			{
				aim = new mcAim();
				aim.mouseChildren = false;
				aim.mouseEnabled = false;
			}
			Mouse.hide();
			aim.x = GM.fun.bLayer.skyLayer.mouseX;
			aim.y = GM.fun.bLayer.skyLayer.mouseY;
			GM.fun.bLayer.skyLayer.addChild(aim);
		}
		
		[Embed(source = "game/assets/sound/sfxTankMove.mp3")]
		private var sfxMoveClass:Class;
		private var scSfxMove:SoundChannel;
		private function _showTankMove(tk:mcTank):void
		{
			tk.mcTracks.play();
			if(scSfxMove == null)
			{
				var s:Sound = new sfxMoveClass();
				scSfxMove = s.play(0,99999);
			}
			
			var st:SoundTransform = scSfxMove.soundTransform;
			st.volume = 1;
			scSfxMove.soundTransform = st;
//			GM.fun.sound.playSfx(GM.fun.url.getMusic("sfxTankMove"));
		}
		
		private function _showTankStop(tk:mcTank):void
		{
			tk.mcTracks.stop();
			if(scSfxMove)
			{
				var st:SoundTransform = scSfxMove.soundTransform;
				st.volume = 0;
				scSfxMove.soundTransform = st;
			}
		}
		
		private var keysDown:Dictionary = new Dictionary();
		protected function _onKeyUp(event:KeyboardEvent):void
		{
			keysDown[event.keyCode] = false;
			
			if(!keysDown[Keyboard.W] && !keysDown[Keyboard.A] && !keysDown[Keyboard.S] && !keysDown[Keyboard.D])
			{
				if(isMoveing)
				{
					var tk:mcTank = getTankByUserId(GM.fun.sfs.mySelf.id);
					if(tk)
					{
						dirKey = 0;
						var vo:TankStopVO = new TankStopVO();
						vo.ix = tk.x;
						vo.iy = tk.y;
						vo.user = GM.fun.sfs.mySelf;
						stopTank(vo);
						
						var svo:SendPosVO = new SendPosVO();
						svo.ix = tk.x;
						svo.iy = tk.y;
						facade.sendNotification(CMD.NET_SEND_STOP,svo);	
					}
					isMoveing = false;
				}
			}else
			{
				var i:int = keyArr.length;
				var key:int;
				var arr:Array = [];
				while(i--)
				{
					key = keyArr[i];
					if(key != event.keyCode)
					{
						arr.push(key);
					}
				}
				
				arr.unshift(event.keyCode);
				
				keyArr = arr;
				checkTankMove();
			}
			
		}
		
		protected function _onKeyDown(event:KeyboardEvent):void
		{
			keysDown[event.keyCode] = true;	
			
			var i:int = keyArr.length;
			var key:int;
			var arr:Array = [];
			while(i--)
			{
				key = keyArr[i];
				if(key != event.keyCode)
				{
					arr.push(key);
				}
			}
			
			arr.push(event.keyCode);
			
			keyArr = arr;
			
			checkTankMove();
		}
		
		private var keyArr:Array = [Keyboard.W,Keyboard.A,Keyboard.S,Keyboard.D];
		private var dirKey:int;
		private function checkTankMove():void
		{
			if(GM.fun.sfs.mySelf)
			{
				var tk:mcTank = getTankByUserId(GM.fun.sfs.mySelf.id);
				if(tk == null)
				{
					return;
				}
				var ix:int = tk.x;
				var iy:int = tk.y;
				if(keysDown[Keyboard.W] || keysDown[Keyboard.A] || keysDown[Keyboard.S] || keysDown[Keyboard.D])
				{	
					var dis:int = 10000;
					var dir:int = 0;
					
					var i:int = keyArr.length;
					var key:int;
					while(i--)
					{
						key = keyArr[i];
						dir = key;
						if(keysDown[key])
						{
							switch(key)
							{
								case Keyboard.W:
									iy-=dis;
								break;
								
								case Keyboard.A:
									ix-=dis;
								break;
								
								case Keyboard.S:
									iy+=dis;
								break;
								
								case Keyboard.D:
									ix+=dis;
								break;
							}
							
							break;
						}
					}
					
					
					if(dirKey == dir)
					{
						return;
					}
					
					dirKey = dir;
					
					isMoveing = true;
					var vo:SendPosVO = new SendPosVO();
					vo.ix = ix;
					vo.iy = iy;
					vo.t = dis/200;
					facade.sendNotification(CMD.NET_SEND_MOVE,vo);	
				}
			}
			
		}
		
		override public function onRemove():void
		{
			scene.x = 0;
			scene.y = 0;
			GM.fun.bLayer.disposeBattleLayer();
		}
		
		private var tanks:Vector.<mcTank> = new Vector.<mcTank>;
		private function createTank(vo:TankVO):void
		{
			
			var tank:mcTank = getTankByUserId(vo.id);
			if(tank == null)
			{
				tank =new mcTank();
				tank.name = vo.id+"";
				tank.kills = 0;
				
				var nick:mcNick = new mcNick();
				nick.txt_nick.text = ""+vo.name;
				nick.name = "mc_nick";
				nick.nick = ""+vo.name;
				tank.addChild(nick);
				nick.visible = false;
			}
			
			
			tank.x = vo.x;
			tank.y = vo.y;
			tank.mcHit.alpha = 0;
			_showTankStop(tank);
			GM.fun.bLayer.tankLayer.addChild(tank);
			
		}
		
		private function getTankByUserId(id:int):mcTank
		{
			var t:mcTank = GM.fun.bLayer.tankLayer.getChildByName(id+"") as mcTank;
			
			return t;
		}
		
		private function lookAt(x:Number,y:Number):void
		{
			var p:Point = new Point(x,y);
			p = scene.localToGlobal(p);
			var pc:Point = new Point((GM.fun.db.battleWidth>>1),(GM.fun.db.battleHeight>>1));
			var dx:Number = pc.x - p.x;
			var dy:Number = pc.y - p.y;
			var dis:Number = Point.distance(p,pc);
			if(quakeSeed)
			{
				dx += quakeSeed.dx;	
				dy += quakeSeed.dy;
			}
			scene.x += dx;
			scene.y += dy;
			
			if(scene.x < (-_bg.width + GM.fun.db.battleWidth))
			{
				scene.x = (-_bg.width + GM.fun.db.battleWidth);
			}else if(scene.x > 0)
			{
				scene.x = 0;
			}
			
			if(scene.y < (-_bg.height + GM.fun.db.battleHeight))
			{
				scene.y = (-_bg.height + GM.fun.db.battleHeight)
			}else if(scene.y > 0)
			{
				scene.y = 0;
			}
			
			p = GM.fun.bLayer.groundLayer.globalToLocal(new Point());
			
			_render.x = p.x;
			_render.y = p.y;
			var w:int = GM.fun.layer.stage.stageWidth;
			var h:int = GM.fun.layer.stage.stageHeight;
			var rec:Rectangle = new Rectangle(p.x,p.y,w,h);
			_render.bitmapData.copyPixels(_bg.bitmapData,rec,new Point());
			
		}
		
		private function getFollowPt(tk:mcTank):Point
		{
			var p:Point = getSceneMousePoint();
			
			p.x = tk.x;//+ ((p.x-tk.x)>>1);
			p.y = tk.y;// + ((p.y-tk.y)>>1);
			
//			p.x = tk.x + ((p.x-tk.x)>>1);
//			p.y = tk.y + ((p.y-tk.y)>>1);
			
			return p;
		}
		
		private function getSceneMousePoint():Point
		{
			var p:Point = new Point(GM.fun.layer.stage.mouseX,GM.fun.layer.stage.mouseY);
			if(p.x > GM.fun.db.battleWidth)
			{
				p.x = GM.fun.db.battleWidth;
			}
			
			p = scene.globalToLocal(p);
			
			
			
			return p;
		}
	}
}