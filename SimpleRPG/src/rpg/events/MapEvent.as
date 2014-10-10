package rpg.events
{
	import flash.events.Event;
	
	public class MapEvent extends Event
	{
		/**
		 *场所转换 切换地图 
		 */
		public static const TRANSFER:String="transfer";
		/**
		 *到达一个路点 
		 */
		public static const ARRIVED:String="arrived";
		
		public var data:Array;
		public function MapEvent(type:String, data:Array=null,bubbles:Boolean=false, cancelable:Boolean=false)
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