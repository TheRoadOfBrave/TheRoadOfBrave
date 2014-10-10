package rpg.vo
{
	public class RpgState extends UsableItem
	{
		
		/**
		 * 限制行动（0：无、1：不能使用魔法、2：普通攻击敌人、3：普通攻击同伴、4：不能行动、5：无法行动或回避。）
		 */		
	    public var restriction:int
		/** *状态显示优先级（0～10）  */		
	    public var priority:int=50;
		//戦闘終了時に解除 (true / false) 。
		public var remove_at_battle_end:Boolean; 
		//行動制約によって解除 (true / false) 。
		public var remove_by_restriction :Boolean; 
		
		/**
		 *自動解除のタイミング。
		0 : なし 
		1 : 行動終了時 
		2 : ターン終了時 
		 */		
		public var auto_removal_timing :uint=0;

		//継続ターン数の最小値と最大値。
		public var min_turns :uint=1;
		public var max_turns :uint=1;
		
		//ダメージで解除 (true / false) 。
		public var remove_by_damage :Boolean;
		
		/**
		 * ダメージで解除される確率 (%) 。
		 *hold_turn 回合经过后有 auto_release_prob % 的概率解除 
		 */		
		public var chance_by_damage :uint=100;
		
		
		//歩数で解除 (true / false) 。
		public var remove_by_walking:Boolean; 
		
		//解除されるまでの歩数。
		public var steps_to_remove :uint=100;
	    public var message1:String;
	    public var message2:String;
	    public var message3:String;
	    public var message4:String;
	    public var state_set:Array;

		public function RpgState(state_xml:XML)
		{
			init(state_xml);
		}
		
		private function init(data:XML):void{
			 id = int(data.id);
		     name = data.name
		     icon_index = data.icon_index
		     restriction = data.restriction
		     priority = data.priority
		      message1 = data.message[0]
		      message2 = data.message[1]
		      message3 = data.message[2]
		      message4 = data.message[3]
		      element_set = []
		      state_set = []
		      note = data.note
				  
			 auto_removal_timing=data.auto_removal_timing;
			  remove_at_battle_end=toBoolean(data.remove_at_battle_end);
			  remove_by_restriction=toBoolean(data.remove_by_restriction);
			var turns:Array=data.hold_turn.split('-');
			min_turns=uint(turns[0]);
			max_turns=uint(turns[1]);
			  addFeatures(data.features.feature);
		}
		
		private function toBoolean(str:String):Boolean{
			return Boolean(int(str));
		}
		
		private function addFeatures(data:XMLList):void{
			for (var i:int=0;i<data.length();i++){
				var str:String=data[i]
				var arr:Array=str.split(',');
				var feature:Feature=new Feature(arr[0],arr[1],arr[2]);
				features.push(feature);
			}
		}
		
		
		override public function toString():String{
			return name;
		}
	}
}