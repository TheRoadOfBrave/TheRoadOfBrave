package rpg.model
{
	import flash.utils.Dictionary;
	
	import rpg.vo.Effect;
	import rpg.vo.UsableItem;

	public class Effector
	{
		// # 恢复 HP
		public static const EFFECT_RECOVER_HP:uint = 11  
		//  # 恢复 MP
		public static const EFFECT_RECOVER_MP:uint = 12        
			// # 增加 TP
		public static const EFFECT_GAIN_TP   :uint = 13
		//  # 附加状态	
		public static const EFFECT_ADD_STATE :uint = 21
			//  # 解除状态
		public static const EFFECT_REMOVE_STATE:uint = 22
		//	# 强化能力
		public static const EFFECT_ADD_BUFF  :uint = 31 
		// # 弱化能力
		public static const EFFECT_ADD_DEBUFF:uint = 32  
		// # 解除能力强化
		public static const EFFECT_REMOVE_BUFF:uint =33 
		//  # 解除能力弱化
		public static const EFFECT_REMOVE_DEBUFF:uint = 34      
		// # 特殊效果
		public static const EFFECT_SPECIAL   :uint = 41   
		//  # 能力提升
		public static const EFFECT_GROW      :uint = 42         
		// # 学会技能
		public static const EFFECT_LEARN_SKILL:uint = 43         
		//# 公共事件
		public static const EFFECT_COMMON_EVENT:uint = 44              
		/**
		 * ● 常量（特殊效果）   # 撤退
		 */
		public static const 	SPECIAL_EFFECT_ESCAPE:uint =0 ;     
		
		private var method_table:Dictionary=new Dictionary;
		public function Effector()
		{
			
		}
		
		public function item_effect_apply(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			method_table[EFFECT_RECOVER_HP]=item_effect_recover_hp
			method_table[EFFECT_RECOVER_MP ]=item_effect_recover_mp;
			method_table[EFFECT_GAIN_TP]=item_effect_gain_tp;
			method_table[EFFECT_ADD_STATE]=item_effect_add_state;
			method_table[EFFECT_REMOVE_STATE]=item_effect_remove_state;
			method_table[EFFECT_ADD_BUFF]=item_effect_add_buff;
			method_table[EFFECT_ADD_DEBUFF]=item_effect_add_debuff;
			method_table[EFFECT_REMOVE_BUFF]=item_effect_remove_buff;
			method_table[EFFECT_REMOVE_DEBUFF]=item_effect_remove_debuff;
			method_table[EFFECT_SPECIAL]=item_effect_special;
			method_table[EFFECT_GROW]=item_effect_grow;
			method_table[EFFECT_LEARN_SKILL]=item_effect_learn_skill;
			method_table[EFFECT_COMMON_EVENT]=item_effect_common_event;
			
			var method:Function= method_table[effect.code]
			method(user,target,item,effect)
			
		}
		public function item_effect_recover_hp(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			var value:Number = (target.mhp * effect.value1 + effect.value2) *target.rec;
		//	value *= user.pha if item.is_a?(RPG::Item)
		//	value = value.to_i
			target.result.hp_damage -= value
			target.result.success = true
			target.hp += value
		}
		
		public function item_effect_recover_mp(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			
		}
		
		public function item_effect_gain_tp(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			
		}
		/**
		 *应用“附加状态”效果 
		 * @param user
		 * @param target
		 * @param item
		 * @param effect
		 * 
		 */		
		public function item_effect_add_state(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			if (effect.data_id == 0){
				item_effect_add_state_attack(user, target,item, effect)
			}else{
				item_effect_add_state_normal(user, target,item, effect)
			}
		}
		
		//应用“状态附加”效果：普通攻击
		private function item_effect_add_state_attack(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
				for each (var state_id:uint in user.atk_states){
					var chance:Number = effect.value1
					chance *= user.state_rate(state_id)
					chance *= user.atk_states_rate(state_id)
					//chance *= luk_effect_rate(user)
					if (Math.random() < chance){
						target.add_state(state_id)
						target.result.success = true
						
					}
				}
				
		}
		//应用“状态附加”效果：普通
		private function item_effect_add_state_normal(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			var chance:Number = effect.value1
			if (target.isOpposite(user)){
				chance *= target.state_rate(effect.data_id) 
				//chance *= luk_effect_rate(user)     
			}
			
			if (Math.random() < chance){
				target.add_state(effect.data_id)
				target.result.success = true
			}
		}
		
		
		public function item_effect_remove_state(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			var chance:Number = effect.value1
			if (Math.random() < chance){
					target.remove_state(effect.data_id)
					target.result.success = true
				
			}
		}
		
		public function item_effect_add_buff(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			target.add_buff(effect.data_id, effect.value1)
			target.result.success = true
		}
		
		public function item_effect_add_debuff(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			var chance:Number = target.debuff_rate(effect.data_id) * target.luk_effect_rate(user)
			if (Math.random() < chance){
				target.add_debuff(effect.data_id, effect.value1)
				target.result.success = true
				
			}
		}
		
		public function item_effect_remove_buff(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			 if (target.buffs[effect.data_id] > 0){
				 target.remove_buff(effect.data_id)
			}
			 target.result.success = true;
		}
		
		public function item_effect_remove_debuff(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			if (target.buffs[effect.data_id] < 0){
				target.remove_buff(effect.data_id)
			}
			target.result.success = true;
		}
		
		public function item_effect_special(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			
		}
		
		public function item_effect_grow(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			
		}
		
		public function item_effect_learn_skill(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			
		}
		
		public function item_effect_common_event(user:Battler, target:Battler,item:UsableItem, effect:Effect):void{
			
		}
		
		
	}
}