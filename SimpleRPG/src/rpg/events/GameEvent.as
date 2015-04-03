package rpg.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		
		public static const START:String="game_start";
		public static const CONTINUE:String="game_continue";
		public static const DELETE:String="game_delete";
		/**
		 *启用日志
		 */
		public static const SETUP_LOGGER:String="setup_logger";
		public static const UPDATE_GOLD:String="update_gold";
		
		
		public static const START_JOURNEY:String="start_journey";
		public static const CHANGE_EQUIP:String="change_equip";
		
		public var data:Object;
		public function GameEvent(type:String, data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
		
		override public function clone():Event
		{
			var event:GameEvent=new GameEvent(type,data,bubbles,cancelable);
			return event;
		}
		
	}
}