package rpg.model
{
	import avmplus.USE_ITRAITS;
	
	import com.adobe.utils.ArrayUtil;
	
	import mx.logging.LogLogger;
	
	import rpg.vo.BaseItem;
	import rpg.vo.Damage;
	import rpg.vo.Effect;
	import rpg.vo.Item;
	import rpg.vo.Skill;
	import rpg.vo.UsableItem;

	public class BattleFormula
	{
		public function BattleFormula()
		{
		}
		
		/**
		 * ACE名称为item_hit()
		 *  计算最後命中率
		 *  @param user 使用者 @param target 目标
		 *  @param obj 使用的技能或物品(普通攻击时为nil)
		 */
		private function calc_hit(user:Battler, obj : UsableItem = null):Number{
			var rate:Number= obj.success_rate * 0.01;        // 获取成功几率
			 if (obj.isPhysical ) rate *= user.hit  ; 
				
//			 trace(user.battler_name+"  获取命中率"+user.hit)                    // 获取命中率
   			 return rate;
		}
   
   
   		/**
		 * ACE 中 item_eva()
		 *  计算最後闪躲率
		 *  @param user 使用者 @param target 目标
		 *  @param obj 使用的技能或物品(普通攻击时为nil)
		 */
   		private function calc_eva(user:Battler, target:Battler,obj : UsableItem = null):Number{
			var eva:Number;
			//# 是物理攻击则返回闪避几率
			if (obj.isPhysical ) return target.eva  ; 
			//# 是魔法攻击则返回闪避魔法几率
			if (obj.isMagical ) return target.mev  ; 
			return 0
			   //  无法闪躲的场合, 闪躲率为 0%
//			   if ( target.parriable){
//			    	 eva = 0  ;
//			   }                      
		}
		
		//计算技能／物品的必杀几率
		private function  item_cri(user:Battler, target:Battler,obj : UsableItem = null):Number{
			return obj.damage.critical ? user.cri * (1 - target.cev) : 0
		}
   
		private  function make_attack_damage_value(attacker:Battler, target : Battler):void{
			var damage:Number = attacker.atk * 4 - target.def * 2        //基础计算
		   	damage < 0 ? damage=0:null;                        // 设负数伤害为 0
			// 属性校正
		  // damage *= elements_max_rate(attacker.element_set)   
		   //damage /= 100;
		    // 若伤害为 0 一半机率伤害为1
		    if (damage == 0 ){
		    	damage =Math.random()*2;
		    }else if(damage>0){
		    //	target.critical = (rand(100) < attacker.cri)        # 会心一击判断
		    // target.critical = false if prevent_critical         # 防止会心一击判断
		     // damage *= 3 if @critical                  
		    }                               
		   
		   // damage = apply_variance(damage, 20)             # 分散度
			// 防御校正
		    damage = target.apply_guard(damage)                   
		    target.result.hp_damage = damage       ;                     // 体力伤害
		}
		
		
		
		

		/**
		 *  計算式の評価を行います。
		 * RPGMAKE 中在RPG::UsableItem::Damage
				回復の場合は負の値を返します。
		 * @param damage
		 * @param aに行動者
		 * @param b に対象
		 * @param v にゲーム内変数の配列 ($game_variables) を指定します 
		 * 本游戏自定义 可能是obj类 v[n]获得n号变量的数值。
		 * @return 
		 * 
		 */
		public function eval(damage:Damage,a:Battler, b:Battler, v:Number):Number{
			//		[Kernel.eval(@formula), 0].max * sign rescue 0
				
				var value:Number;
			//	0 : なし  1 : HP ダメージ 2 : MP ダメージ 	3 : HP 回復  4 : MP 回復  5 : HP 吸収 	6 : MP 吸収 
					switch(damage.type){
						case 0 :
							value=0;
							break;
						case 1 :
							value=	a.atk * 4 - b.def * 2
							break;
						case 2 :
							value= 10 + a.mat * 2 - b.mdf * 2
							break;
						case 3 :
							value= 25 + a.mat ;
							break;
						case 4 :
							value= b.mmp * 0.5;
							break;
						case 5 :
							value= 25 + a.mat ;
							break;
						case 6 :
							value= b.mmp 
							break;
					}
					var sign:int=damage.isRecover?-1:1;
					value=Math.max(value,0) * sign;
			return value;
		}
		private function make_damage_value(user:Battler,target:Battler, item : UsableItem) : void {
			var value:Number = eval(item.damage,user, target, 0)
			value=value*item.repeats;
				
			value *= item_element_rate(user, target,item)
			if (item.isPhysical) value *= target.pdr ;
			if (item.isMagical) value *= target.mdr 
			 if (item.damage.isRecover) value *= target.rec
			 if (target.result.critical) value = apply_critical(value)
			value = apply_variance(value, item.damage.variance)
			value = apply_guard(target,value)
			target.result.make_damage(int(value), item)
		                             
		 
		}
		private function apply_critical(damage:Number):Number{
			return damage*3;
		}
		
		private function apply_variance(damage, variance):Number{
		//	amp = [damage.abs * variance / 100, 0].max.to_i
		//	var = rand(amp + 1) + rand(amp + 1) - amp
			damage=damage >= 0 ? damage + 5 : damage - 5
			return damage;
		}
		private function apply_guard(target:Battler,damage:Number):Number{
			if (damage>0 && target.isGuarding){
				damage=damage/2*target.grd;
			}
			return damage;
		}
		/**
		 *  获取技能／物品的属性修正值
		 */
		private function  item_element_rate(user:Battler, target:Battler,item:UsableItem):Number{
			var rate:Number=1;
			if (item.damage.element_id < 0){
				rate=user.atk_elements.length==0 ? 1.0 : elements_max_rate(user.atk_elements,target)
				
			}else{
				rate=target.element_rate(item.damage.element_id)
			}
			return rate;
		}
		
		
		private function elements_max_rate(element_set:Array,target:Battler):int
		{
			if (element_set==null||element_set.length==0){
				return 1;
			}
			var rateMax:int=-1000;
			for (var i:int=0; i<element_set.length;i++){
				var elementId:int=element_set[i];
			//	trace("属性有效度:"+rateMax)
				var rate:int=target.element_rate(elementId);
				if (rateMax<rate){
					rateMax=rate;
				}
			}
			trace("最大属性有效度:"+rateMax)
			return rateMax;
		}		
		
		
		
		private function execute_damage(user:Battler,target:Battler):void{
			//trace("受到伤害："+target.actResult.hp_damage)
			if (target.result.hp_damage > 0  ){
				//攻击移除状态

			}        
		     
		   
		    target.hp -= target.result.hp_damage;
		    target.mp -= target.result.mp_damage;
		    if (target.result.absorbed ){            // 若吸收
		      user.hp += target.result.hp_damage
		      user.mp += target.result.mp_damage
		    }
		}
    
		/**
		 * 计算攻击效果
		 * @param attacker 攻击者 @param target 攻击目标
		 */
		public  function attackEffect(attacker : Battler, target : Battler):void{
			target.clear_action_results();
			 //unless attack_effective?(attacker)
		     // @skipped = true
		     // return
		   
		    if (Math.random()*100 >= calc_hit(attacker) ){
		    	// 计算命中率
		    	trace("MISS命中率"+calc_hit(attacker))
		    	 target.result.missed = true;
		     	 return;
		    }           
		     	    
		    if (Math.random()*100 < calc_eva(attacker,target) ){//            # 计算闪躲率
		      target.result.evaded = true;
		      trace("避开了"+calc_eva(attacker,target))
		      return;
		    }
		    make_attack_damage_value(attacker, target)    ;        ///# 计算伤害
		    execute_damage(attacker,target);                      ///# 伤害效果
		    if (target.result.hp_damage == 0 ){
		    	 return ;
		    }                           //# 判断是否有物理伤害
		                                        
		   
//		    apply_state_changes(attacker)                // 增减状态
		 
		
		}
	public function item_apply(user: Battler,target : Battler, item:UsableItem):void{
		target.clear_action_results();
		target.result.used = item_test(user, item)
		if (Math.random() >= calc_hit(user,item) ){
			// 计算命中率
			target.result.missed = true;
			return;
		}         
		
		if (Math.random()*100 < calc_eva(user,target,item) ){//            # 计算闪躲率
			target.result.evaded = true;
			
			return;
		}
		//	@result.missed = (@result.used && rand >= item_hit(user, item))
		//	@result.evaded = (!@result.missed && rand < item_eva(user, item))
		if (target.result.beHit){
		 	if (!item.damage.none){
				target.result.critical = (Math.random() < item_cri(user,target, item))
				make_damage_value(user, target,item)    ;        ///# 计算伤害
				execute_damage(user,target);                      ///# 伤害效果
				
			}
			
			for each (var effect:Effect in item.effects){
				target.effector.item_effect_apply(user,target,item,effect);
			}
			//item_user_effect(user, item)
		}
		
	}
	
	private function item_test(user:Battler, item:UsableItem):Boolean
	{
		// TODO Auto Generated method stub
		return true;
	}		
   
   		
		
	
		
		//状态变化
		public function apply_state_changes(target:Battler,obj:UsableItem=null):void{
			var plus:Array=obj.plus_state_set 
			var minus:Array=obj.minus_state_set 
			
				var added_arr:Array=target.addedStateId_arr;
				var removed_arr:Array=target.removedStateId_arr;
			for each (var i:int in plus){
				if (target.hasState(i)){
					target.remainedStateId_arr.push(i)         //记录为变更状态
					continue;
				}
				if (Math.random()*100 < 101) 
		       		target.add_state(i)                     
		        	added_arr.push(i)  
				}
			
			for each (var j:int in minus){
				if (target.hasState(j)){
					continue;
				}else{
					target.remove_state(i)                   // 移除状态
					removed_arr.push(i)  
				}
			}
			
			//保存附加和移除数组的交集
			var intersection:Array=[];
			
			if (added_arr.length>removed_arr.length){
				for each (var k:int in added_arr){
					if (ArrayUtil.arrayContainsValue(removed_arr,k)){
						intersection.push(k);
					}
				}
			}else{
				for each (var kk:int in removed_arr){
					if (ArrayUtil.arrayContainsValue(added_arr,kk)){
						intersection.push(kk);
					}
				}
			}
			
			//删除同时存在附加和移除中的状态ID
			for each (var ii:int in intersection){
				if (ArrayUtil.arrayContainsValue(added_arr,ii)&&ArrayUtil.arrayContainsValue(removed_arr,ii)){
					ArrayUtil.removeValueFromArray(added_arr,ii);
					ArrayUtil.removeValueFromArray(removed_arr,ii);
				}
			}
			
		}
	}
}