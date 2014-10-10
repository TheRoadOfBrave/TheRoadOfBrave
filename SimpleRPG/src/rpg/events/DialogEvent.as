package rpg.events
{
	import flash.events.Event;
	
	public class DialogEvent extends Event
	{
		public static const SHOW:String="show_dialog";
		public var text:String;
		public var params:Array;
		public function DialogEvent(type:String, text:String="",arr:Array=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.text=text;
			this.params=arr;
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone():Event
		{
			return super.clone();
		}
		
	}
}