package rpg
{
	import rpg.vo.Talent;

	public final class HeroData
	{
		private static var _instance:HeroData;
		public function HeroData()
		{
		}
		
		public static function getInstance():HeroData{
			if (!_instance) {
				
				_instance=new HeroData();
			}
			return _instance;
		}
		/**
		 *天赋学习数据集 
		 * @param id
		 * @return 
		 * 
		 */
		public function getLearning(id:int):Talent{
			var tt:Talent=new Talent;
			
			return tt;
			
		}
	}
}