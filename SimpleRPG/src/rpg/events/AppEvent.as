package rpg.events
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const STARTUP:String="startup"
		public static const STARTUP_COMPLETE:String="startup_complete"
		public static const SAVE:String="save_game"
		public static const LOAD:String="load_game"
		public static const DELETE:String="delete_game"
		public var data:Object;
		
		public function AppEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}