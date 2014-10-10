package rpg.vo
{
	[Bindable]
	public class Item extends UsableItem implements IPackItem
	{
		private var _price:Number;
		public var consumable:Boolean;
		public var hp_recovery_rate :Number;
		public var hp_recovery:Number;
		public var mp_recovery_rate:Number
		public var mp_recovery:Number;
		public var parameter_type:int
		public var parameter_points:int;
		
		private var _num:int;
		
		public function Item()
		{
			super();
			init()
		}
		
		private function init():void{
			
			occasion = 0
			speed = 0
			common_event_id = 0
			damage.variance = 20
			element_set = []
			plus_state_set = [];
			minus_state_set = []
			
			
			
			
		}
		
		public function set price(value:int):void
		{
			_price=value;
			
		}
		
		public function get price():int
		{
			return _price;
		}
		
		
		public function set key(n:int):void
		{
			id=n;
			
		}
		
		public function get key():int
		{
			return id;
		}

		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = value;
		}
		
		
	}
}