package rpg.script
{
	
	import rpg.map.ZoneModel;
	import rpg.model.EventPage;
	
	public class RpgScript extends EventPage
	{
		public var bg:int=1;
		public var end:Boolean=false;
		public var zone:ZoneModel
		public function RpgScript(zone:ZoneModel=null)
		{
			super();
		}
	}
}