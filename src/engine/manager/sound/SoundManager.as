package engine.manager.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	/**
	 * 简单写的 先用
	 */
	public class SoundManager
	{
		public function SoundManager()
		{
		}
		
		public function setup():void
		{
			
		}
		
		//---------------------------------------------------------------
		public function playMusic(url:String,loop:Boolean=true):void
		{
			if(music)
			{
				music.stop();
			}
			var s:Sound = new Sound();
			
			s.addEventListener(Event.COMPLETE,musicCompleteHandler);
			s.load(new URLRequest(url));
		}
		
		protected function musicCompleteHandler(event:Event):void
		{
			var s:Sound = event.currentTarget as Sound;
			music = s.play(0,9999);
		}
		
		private var music:SoundChannel;
		
		//---------------------------------------------------------------
		public function playSfx(url:String):void
		{
			var s:Sound = new Sound();
			
			s.addEventListener(Event.COMPLETE,sfxCompleteHandler);
			s.load(new URLRequest(url));
		}
		
		protected function sfxCompleteHandler(event:Event):void
		{
			var s:Sound = event.currentTarget as Sound;
			s.play();
		}
	}
}