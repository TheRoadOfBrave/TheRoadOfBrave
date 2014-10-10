package rpg.model
{
	/**
	 * 
	 * @author maikid
	 *该游戏特定数据 单例
	 * 在各脚本中共用的数据，尽量只在脚本中使用
	 * 
	 *  
	 */
	public class GameData
	{
		private static var _instance:GameData;
		
		public var floor:uint=0;
		public var maxFloor:uint=30;
		[Bindable]
		public var day:uint=2;
		public function GameData()
		{
		}
		
		public static function getInstance():GameData{
			if (!_instance) {
				
				_instance=new GameData();
			}
			return _instance;
		}
	}
}