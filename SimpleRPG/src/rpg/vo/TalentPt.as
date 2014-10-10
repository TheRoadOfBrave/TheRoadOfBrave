package rpg.vo
{
	/**
	 * 天赋点数据
	 * @author maikid
	 * 
	 */
	[Bindable]
	public class TalentPt
	{
		public var name:String;
		public var skill_id:int;
		public var lv:int;
		public var cost:int=1;
		public var learned:Boolean=false;
		public var value:int;
		public var speed:int;
		public var param_id:uint;
		public function TalentPt()
		{
		}
	}
}