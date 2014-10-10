package rpg.vo
{
	
	public class GameClass extends BaseItem
	{
		public var exp_params :Array;
		/**
		 * 各レベルに対応する通常能力値を格納した二次元配列 (Table) です。
			params[param_id, level] という形をとり、
 * param_id は以下
		 *0 : 最大HP 
			1 : 最大MP 
			2 : 攻撃力 
			3 : 防御力 
			4 : 魔法力 
			5 : 魔法防御 
			6 : 敏捷性 
			7 : 運 
 
		 */
		public var params :Array
		public var learnings :Array;

		public function GameClass()
		{
			super();
			params=new Array(8);
			for (var i:int=0;i<8;i++){
				params[i]=new Array;
			}
		}
		
		public function exp_for_level(level:uint) :uint{
			return level*100
		}
		
		
	}
}