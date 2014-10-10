package rpg.vo {

	/**
	 * //特征 VO
	 */
	public class Feature {
		public var code:uint;
		public var data_id:uint;
		public var value:Number;
		public function Feature(code:uint = 0, data_id:uint  = 0, value:Number  = 0):void {
			this.code =code
			this.data_id = data_id
			this.value = value 
			
			
		}
		
	}
}
