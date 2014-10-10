package rpg.vo
{
	import rpg.DataBase;
	import rpg.model.Battler;

	public class ActionResult
	{	
		
		private var battler:Battler;
		public var skipped:Boolean                
		public var used:Boolean                
	 	public var missed  :Boolean;
	 	public var evaded  :Boolean;
	 	public var critical:Boolean                
	 	 public var absorbed   :Boolean;             
	 	 public var hp_damage:Number    
	 	 public var mp_damage:Number 
	 	 public var tp_damage:Number 
		 //HP 吸收
		 public var hp_drain:Number    
		 public var mp_drain:Number 
	 	 //附加状态，移除状态，剩余状态的状 态ID列表 
	 	 public var  added_states:Array;  
	 	 public var  removed_states :Array;  
	 	 public var  remained_states:Array;  
	 	 public var added_buffs:Array;  
	 	 public var added_debuffs:Array;  
	 	 public var removed_buffs:Array;  
	 	 public var success:Boolean;
	 	
		 private var db:DataBase=DataBase.getInstance();
		public function ActionResult(battler:Battler)
		{
			this.battler=battler;
			clear();
		}
		
		

		public function clear():void{
			//skipped = false;
		    hp_damage = 0;
		    mp_damage = 0;
			clear_hit_flags();
			clear_damage_values();
			clear_status_effects();
		}
		
		public function clear_hit_flags():void{
			used = false
			missed = false
			evaded = false
			critical = false
			success = false
		}

		/**
		● 清除伤害值
		 * 
		 * 
		 */
		public function clear_damage_values():void{
			hp_damage = 0
			mp_damage = 0
			tp_damage = 0
			hp_drain = 0
			mp_drain = 0
			
		}
		public function clear_status_effects():void{
			added_states = []
			removed_states = []
			added_buffs = []
			added_debuffs = []
			removed_buffs = []
		}
		
		/**
		 *判定最后是否命中 
		 * @return 
		 * 
		 */
		public function get beHit():Boolean
		{
			return used && !missed && !evaded
		}
		
		
		//数组项操作，把状态ID 返回为状态实例
		private function collect(element:uint, index:int, arr:Array):RpgState {
			return db.getState(element);
		}
		
		/**
		● 获取被附加的状态的实例数组
		 * 
		 * @return 
		 * 
		 */
		public function get added_state_objects():Array{
			var arr:Array=added_states.map(collect);
			return arr;
		}

		/**
			# ● 获取被解除的状态的实例数组
		 * 
		 * @return 
		 * 
		 */
		public function get removed_state_objects():Array{
			var arr:Array=removed_states.map(collect);
			return arr;
		}

		
		/**
			# ● 判定是否受到任何状态的影响
			 * 
			 */
			public  function get isStatusAffected():Boolean{
				return !(added_states.length==0 && removed_states.length==0 &&
							added_buffs.length==0 && added_debuffs.length==0 && removed_buffs.length==0);
			}
		
		public function make_damage(value:int,item:UsableItem):void{
			if (value == 0)critical = false;
			if (item.damage.to_hp)hp_damage = value 
			if( item.damage.to_mp)mp_damage = value
			mp_damage = Math.min(battler.mp, mp_damage);
			if( item.damage.isDrain) hp_drain = hp_damage
			if( item.damage.isDrain)mp_drain = mp_damage
			hp_drain =Math.min(battler.hp, hp_drain); 
			if(( item.damage.to_hp) || mp_damage != 0)success = true
		}
		
	}
}