package rpg.events
{
	import flash.events.Event;
	
	import rpg.pub.Pub;
	import rpg.vo.IPackItem;
	
	public class ItemEvent extends Event
	{
		public static const BUY:String="buy_item";
		public static const SELL:String="sell_item";
		public static const CLICK:String="click_item";
		public static const USE:String="use_item";
		
		
		public var item:IPackItem;
		/**
		 *代表多个物品 或物品使用对象 
		 */
		public var arr:Array;
		public function ItemEvent(type:String, item:IPackItem,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.item=item;
		}
		
		override public function clone():Event
		{
			var event:ItemEvent=new ItemEvent(type,item,bubbles,cancelable);
			event.arr=arr;
			return event;
		}
		
		
	}
}