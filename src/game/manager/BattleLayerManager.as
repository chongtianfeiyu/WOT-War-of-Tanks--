package game.manager
{
	import flash.display.Sprite;

	public class BattleLayerManager
	{
		public function BattleLayerManager()
		{
		}
		
		public var groundLayer:Sprite;
		public var tankLayer:Sprite;
		public var effectLayer:Sprite;
		public var skyLayer:Sprite;
		
		public function setup():void
		{

		}
		
		public function setBattleLayer():void
		{
			var scene:Sprite = GM.fun.layer.sceneLayer;
			
			groundLayer = new Sprite();
			tankLayer = new Sprite();
			effectLayer = new Sprite();
			skyLayer = new Sprite();
			
			scene.addChild(groundLayer);
			scene.addChild(tankLayer);
			scene.addChild(effectLayer);
			scene.addChild(skyLayer);
		}
		
		public function disposeBattleLayer():void
		{
			var scene:Sprite = GM.fun.layer.sceneLayer;
			scene.removeChildren();
			groundLayer = null;
			tankLayer = null;
			effectLayer = null;
			skyLayer = null;
		}
	}
}