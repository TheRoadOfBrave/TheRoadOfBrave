package rpg.vo
{
	/**
	 * 
	 * @author maikid
	 *地图事件对象VO 
	 */
	public class EventVo
	{
		public var id:int; 
		
		public var name:String; 
		
		public var x:int; 
		public var y:int;		
		
		/**
		 *该关键点 可触发的事件页 
		 */
		public var pages:Array; 
		public var locale:uint;

		public function EventVo(id:int,name:String="")
		{
			this.id=id;
			this.name=name;
		}
	}
}