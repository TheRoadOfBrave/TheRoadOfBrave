package rpg.vo
{

	public class MapVo
	{
		public var id:int;
		public var name:String;
		public var local:int;
		/**
		 *地图上的事件点 事件物VO 
		 * 如宝箱 NPC 商店 等
		 */
		public var eventVoList:Array;
		public function MapVo(id:int)
		{
			this.id=id;
			eventVoList=[];
		}
	}
}