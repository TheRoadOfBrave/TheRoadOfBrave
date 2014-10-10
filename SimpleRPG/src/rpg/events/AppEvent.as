package rpg.events
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const STARTUP:String="startup"
		public static const STARTUP_COMPLETE:String="startup_complete"
		public var data:Object;
		
		public function AppEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}