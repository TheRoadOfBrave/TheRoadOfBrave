package rpg.events
{
	import flash.events.Event;
	
	import rpg.model.Battler;
	
	public class SceneEvent extends Event
	{
		public static const GOTO:String="goto_scene";
		
		public static const ACTION:String="scene_action";
		public static const GO_FORWARD:String="go_forward";
		public static const BACK_HOME:String="back_home";
		public static const FINISH_BATTLE:String = "finish_battle";
		public var scene:String;
		public var action:int;
		public function SceneEvent(type:String, scene:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.scene=scene;
		}
	}
}