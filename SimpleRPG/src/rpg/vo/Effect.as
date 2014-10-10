package rpg.vo {

	/**
	 * //技能 物品使用效果 VO
	 */
	public class Effect {
		public var code:uint;
		public var data_id:uint;
		public var value1:Number;
		public var value2:Number;
		public function Effect(code:uint=0,data_id:uint=0,value1:Number=0,value2:Number=0):void {
			this.code =code
			this.data_id = data_id
			this.value1 = value1
			this.value2 = value2;
		}
		
	}
}
