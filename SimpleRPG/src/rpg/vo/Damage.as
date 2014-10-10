package rpg.vo
{
	public final class Damage
	{
		/**
			0 : なし 
			1 : HP ダメージ 
			2 : MP ダメージ 
			3 : HP 回復 
			4 : MP 回復 
			5 : HP 吸収 
			6 : MP 吸収 
			>10 ：特殊公式
		 * 
		 */		
		public var type:uint=1; 
		/**	属性 ID。
		 * 
		 */		
		public var element_id :uint;
		
		/**
		 * 計算式
		 */
		public var formula:String;
		/**
		 * 	分散度。
		 */		
		public var variance:int;
		
		
		public var critical:Boolean; 

		public function Damage()
		{
			type=0;
			element_id=0;
			variance=20;
			critical=false;
		}
		
		public function get none():Boolean{
			return type==0;			
		}
		public function  get to_hp():Boolean{
			return 	[1,3,5].indexOf(type)>-1;	
		}
		public function  get to_mp():Boolean{
			return 	[2,4,6].indexOf(type)>-1;	
		}
		/**
		 *是否恢复判定 
		 * @return 
		 * 
		 */		
		public function get isRecover():Boolean{
			return 	[3,4].indexOf(type)>-1;	
		}
		/**
		 *是否吸收判定 
		 * @return 
		 * 
		 */		
		public function get isDrain():Boolean{
			return 	[5,6].indexOf(type)>-1;	
		}
		/**
		 *标识 回复返回-1 其余返回1 
		 * @return 
		 * 
		 */		
		public function get sign():int{
			return isRecover? -1 : 1
			
		}
		
/*		public function eval(a:*, b:*, v:*):Number{
	//		[Kernel.eval(@formula), 0].max * sign rescue 0
			return 0;
		}
*/
	}
}