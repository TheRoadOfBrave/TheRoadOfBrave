package rpg.vo
{
	public class ActionVo
	{
//		戦闘行動として採用するスキルの ID。
		public var skill_id:int 
		
		/**
//		行動条件のタイプ。
		 * 0 : 常時 
		1 : ターン数 
		2 : HP 
		3 : MP 
		4 : ステート 
		5 : パーティレベル 
		6 : スイッチ 
		 */
		public var condition_type:int; 
		
		/**
		 *行動条件のパラメータ。全タイプで共用となります。
		たとえば条件が [HP] の場合は、condition_param1 に下限、 condition_param2 に上限の値が入ります。
		 */		
		public var condition_param1 :Number;
		public var condition_param2 :Number;
		
		//優先度 (1..10) 。
		public var rating :uint=5;
		

		public function ActionVo(skill:int,rating:uint=5):void
		{
			skill_id=skill;
			this.rating=rating;
		}
	}
}