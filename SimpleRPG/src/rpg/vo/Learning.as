package rpg.vo
{

	public class Learning
	{
		
		public var talentList:Array;
		public var names:Array;
		public function Learning()
		{
			talentList=[];
		}
		
		
		public function addTalent(talent:Talent):void{
			
			talentList.push(talent);
		}
		
		
		
	}
}