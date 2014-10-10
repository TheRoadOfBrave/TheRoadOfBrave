package rpg.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		/**
		 *启用日志
		 */
		public static const SETUP_LOGGER:String="setup_logger";
		
		public var data:Object;
		public function GameEvent(type:String, data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
		
		override public function clone():Event
		{
			return super.clone();
		}
		
	}
}