package rpg.events
{
	import flash.events.Event;
	
	public class WindowEvent extends Event
	{
		public static const OPEN:String="open_game_window";
		public static const CLOSE:String="close_game_window";
		public var window:String;
		public var index:int;
		public function WindowEvent(type:String, window:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.window=window;	
		}
	}
}