package rpg.vo {
	import rpg.vo.BaseItem;
	
	/**
	 * @author GUNDAM
	 */
	public class UsableItem extends BaseItem {
		
		/**
		 * 效果的范围
		 * 0：无 1：敌单体 	2：敌全体 3：敌单体 连续 	4：敌二体 随机 5：敌三体 随机 6：敌四体 随机 
			7：己方单体 8：己方全体 9：我方单体（不能战斗）10：我方全体（不能战斗）	11：使用者 
		 */		
		public var scope :int
		/**
		 *使用场合
		 */		
		public var occasion:int;
		public var speed :Number;
		public var success_rate:Number;
		public var repeats   :int
		public var tp_gain  :int;
		/**
		 *0 : 必中 ,1 : 物理攻撃 ,2 : 魔法攻撃 
		 */		
		public var hit_type   :int;
		
		public var animation_id  :String;
		public var common_event_id:int;
		public var damage:Damage;
		public var effects:Array;
		public var element_set :Array;
		public var plus_state_set :Array;
		public var minus_state_set  :Array;

		public function UsableItem() {
			super();
			scope = 0;
		    occasion = 0;
		    speed = 0;
		    animation_id = "0";
		    common_event_id = 0;
			  damage=new Damage();
			effects=[];
			
			
		    element_set = [];
		    plus_state_set = [];
		    minus_state_set = [];
			
		}
		
		public function get isForOpponent():Boolean{
			var values:Array=[1, 2, 3, 4, 5, 6];
			 return values.indexOf(scope)>-1? true:false;
		}
     	
     	public function get isForFriend():Boolean{
			var values:Array=[7, 8, 9, 10, 11];
			 return values.indexOf(scope)>-1? true:false;
		}
     	
     	public function get isForDeadFriend():Boolean{
			var values:Array=[9, 10];
			 return values.indexOf(scope)>-1? true:false;
		}
   		
   		public function get isForUser():Boolean{
			 return scope==11? true:false;
		}
		
		public function get isForOne():Boolean{
			var values:Array=[1, 3, 4, 7, 9,11];
			 return values.indexOf(scope)>-1? true:false;
		}
		public function get isForTwo():Boolean{
			return scope==5? true:false;
		}
		public function get isForThree():Boolean{
			return scope==6? true:false;
		}
		
		public function get isForRandom():Boolean{
			var values:Array=[4, 5, 6];
			 return values.indexOf(scope)>-1? true:false;
		}
		
		public function get isForAll():Boolean{
			var values:Array=[2, 8, 10];
			 return values.indexOf(scope)>-1? true:false;
		}
		
		public function get isDual():Boolean{
			return scope==3? true:false;
		}
		
		public function get isNeedSelection():Boolean{
			var values:Array=[1, 3, 7,9];
			 return values.indexOf(scope)>-1? true:false;
		}
		
		public function get isBattleOk():Boolean{
			var values:Array=[0, 1];
			 return values.indexOf(occasion)>-1? true:false;
		}
		
		public function get isMenuOk():Boolean{
			var values:Array=[0, 2];
			 return values.indexOf(occasion)>-1? true:false;
		}

		public function get  isCertain():Boolean{
			return hit_type == 0;
		}

		public function get isPhysical():Boolean
		{
			return hit_type == 1;
		}

		public function get isMagical():Boolean
		{
			return hit_type == 2;
		}


	}
}
