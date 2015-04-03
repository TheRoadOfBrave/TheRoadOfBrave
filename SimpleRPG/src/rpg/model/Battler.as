package rpg.model
{
	
	import rpg.vo.ActionResult;
	import rpg.vo.Item;
	import rpg.vo.RpgState;
	import rpg.vo.Skill;
	import rpg.vo.UsableItem;
	
	public class Battler extends BattlerBase
	{
		public var friendTroop:Troop,opponentTroop:Troop;
		
		public var battler_name:String;             
		public var battler_hue  :uint;           
		public var index:int ;
		
		  public var animation_id:uint ;           //动画 ID
		  public var gold:uint;
		  // 动画纵向翻转标志 // 白色屏幕闪烁标志 //闪烁标志//倒下标志
		  public var animation_mirror :Boolean,white_flash:Boolean,blink :Boolean                 
		  public var collapse:Boolean;          
		         //行动结果：跳过标志 落空标志 闪躲标志 会心一击标志 吸收标志 体力伤害标志 魔力伤害标志
		
		  
		  public var effector:Effector;
		  //行动结果
		  public var result:ActionResult;
		  public var action : BattleAction;    
		 public var last_target_index:int;
		  
		  
		  
		  protected var skillIdList:Array;
		 
					
					
		public var 	maxhp_plus :Number,maxmp_plus:Number,
					atk_plus :Number,def_plus:Number,spi_plus:Number,agi_plus:Number;   
		  
		
					
		
		
		
		public var attack_skill_id:int=1;
		public var guard_skill_id:int=2;
		/**
		 *行动速度 
		 */
		public var speed:int;
		
		
		/**
		 *是否追加行动，行动结束后 会再生成行动 
		 */
		public var isAddAction:Boolean=false;
		
		[Bindable]
		public function Battler(){
			init();
		
			
		}
		
		protected function init():void{
			battler_name = ""
			stateIdArr=[]
			
			immortal = false;
			
			
			animation_id = 0;
			//	    skinId=1;
			//	    animation_hit = false;
			reset();
		
		}
		
		//删除数组中与参数相同的ID项

		public function reset():void{
			result=new ActionResult(this);
			action = new BattleAction(this);
			effector=new Effector();
			clear_extra_values();
			clear_sprite_effects();
			clear_action_results();
		}
		
	
	

		

		private function deleteIdFromArray(arr:Array,id:int):void{
			var index:int=arr.indexOf(id);
			if (index>0){
				arr.splice(index,1);
			}	
		}
	
		public function get id():int{
			
			return -1;
		}
	
	//判断是否为玩家操控的角色	
		override public function get isActor():Boolean{
			if (friendTroop is Party){
				return true;
			}
			return false;
		}
		
//=============================================================================================
		
		public function get exp():int
		{
			return 0;
		}
		
		public function set exp(value:int):void
		{
			
		}
		
//==================真实数值=========================================
		public function get maxhp():int{
			return 0;
		}
		
		/*用mhp取代了
		public function get maxmp():int{
			return 0;
		}
		
		
		//-----------------------------------------------
		public function set maxhp(value:int):void{
			maxhp_plus += value - maxhp
		//	maxhp_plus = Math.min(maxhp_plus, 9999);
			_hp = Math.min(_hp, maxhp);
		}*/
		
		public function set maxmp(value:int):void{
		}
		
	
		
		
		
//=====================================================================	
		
		
		
		
	
		
		
		/**
		 *可以使用技能的判定 
		 * @param skill
		 * @return 
		 * 
		 */		
		public function canUseSkill(skill:Skill):Boolean{
			//	return false unless skill.is_a?(RPG::Skill)
    		
			
			if (!movable) return false;
			
			
			if (isSilent){
				return false 
			}
			
			if (skill.mp_cost>mp){
				return false;
			}
			//	return false if calc_mp_cost(skill) > mp
			//			if ($game_temp.in_battle){
			//				return skill.battle_ok
			//			}else{
			//				return skill.menu_ok
			//			}
			
    		return true;
    	}
		
		public function get skills():Array{
			var result:Array=[];
			
			for each(var skillId:int in skillIdList){
				var skill:Skill=db.getSkill(skillId);
				result.push(skill);
			}
			
			return result;
		}
		
		public function get atk_animation_id():String{
			//two_swords_style
//			if (true){
//				if (weapons[0]!= null){
//					return weapons[0].animation_id 
//				}
//			}
			
			
			return "1";
			
		}
		
		
		
	
//		
		//获取先前行动所附加的状态
		public function get added_states():Array{
			var  result:Array = [];
			
			for each(var i:int in addedStateId_arr){
				result.push(db.getState(i));
			}
			
    		return result;
		}
		
		//获取先前行动所移除的状态
		public function get removed_states():Array{
			var  result:Array = [];
			for each(var i:int in removedStateId_arr){
				result.push(db.getState(i));
			}
    		return result;
		}
		
		//获取先前行动後所剩馀的状态  ，已用过的，例如：尝试把以睡着的角色附加睡眠状态
		public function get remained_states():Array{
			var  result:Array = [];
			for each(var i:int in remainedStateId_arr){
				result.push(db.getState(i));
			}
    		return result;
		}
		
		//判断先前行动是否对状态有效果
		public function get statesActive():Boolean{
			if (result.added_states.length>0||
				result.removed_states.length>0||
				result.remained_states.length>0){
				return true
			}
    		return false
		}
   
		

	

		
		
	
		
		//是否具有自动回复HP能力
		public function get isAutoHpRecover():Boolean{	
			return false;
		}
		

		public function usable(itemObj:UsableItem):Boolean
		{
			if (itemObj is Skill){
			//	return skill_conditions_met?(item) if item.is_a?(RPG::Skill)
				return true;
			}else if (itemObj is Item){
			//	return item_conditions_met?(item)  if item.is_a?(RPG::Item)
				return true;
			}
			return false;
		}
		//获取攻击属性id集合（一个武器可包含多种攻击属性）
		public function get element_set():Array{
			return [];
		}
		//获取属性修正值
		public function getElementRate(element_id:int):int{
			
			return 100;
		}
		
		/**
		 * 最重要的状态存在讯息
		 * @return 
		 * 
		 */		
		public function get mostImportantStateText():String{
			for each (var state:RpgState in states){
				if (state.message3)
					return state.message3;
			}
			return ""
		}
		
		
   
		
		
		public function state_probability(state_id:int):int{
			 return 0
		}
   		
		
		
		
		
	
		
//--------------------------------------------------------------------------
		
		
		public function setTroopStandpoint(friendTroop:Troop,oppTroop:Troop):void{
			this.friendTroop=friendTroop;
			this.opponentTroop=oppTroop;
		}
		
		
		/**
		 * 清除能力值变量
		 */
		public function clear_extra_values():void{
			maxhp_plus = 0;
		    maxmp_plus = 0;
		    atk_plus = 0;
		    def_plus = 0;
		    spi_plus = 0;
		    agi_plus = 0;
		}
		
		public function clear_sprite_effects():void{
			animation_id = 0;
		    animation_mirror = false;
		    white_flash = false;
		    blink = false;
		    collapse = false;
		}
		
		public function clear_actions():void{
		//	action.clear();
			action=null;
		}
		
		
		//清空行动结果，初始化时应调用一次
		public function clear_action_results():void{
			result.clear();
		    //剩馀状态（ID数组）	 
			addedStateId_arr=[] 
		     removedStateId_arr=[]
			remainedStateId_arr =[]
		         	
		}
		public function make_speed():void
		{
			if (action)
				speed=action.speed;
			else
				speed=0;
		}
		
		//生成战斗行动
		public function makeAction():void {
			clear_actions();
			if (movable){
				//可以行动 生成空行动对象 
				//actions = Array.new(make_action_times) { Game_Action.new(self) }
				action =new BattleAction(this);
				
			}
		}
		
		
		/**
		 *附加状态 
		 * @param state_id 状态 ID
		 * 
		 */		
		public function add_state(state_id:int):void{
			if (state_addable(state_id)){
				if (!hasState(state_id)){
					add_new_state(state_id)
				}
					reset_state_counts(state_id)
					if (result.added_states.indexOf(state_id)==-1)
					result.added_states.push(state_id);
				
			}
		}
		
		/**
		 *判定状态是否可以附加 
		 * @return 
		 * 
		 */		
		public function state_addable(state_id:uint):Boolean{
//			alive? && $data_states[state_id] && !state_resist?(state_id) &&
//				!state_removed?(state_id) && !state_restrict?(state_id)
//			end
			
			return true;
		}
		private function add_new_state(state_id:uint):void{
			if (state_id==death_state_id){  die();	}
			stateIdArr.push(state_id);
			if (restriction>0){
				on_restrict();
			}
			sort_states();
			refresh();
		}
		
		/**
		 *行动受到限制时的处理 
		 * 
		 */		
		public function  on_restrict():void{
			clear_actions();
			for each (var state:RpgState in states){
				if (state.remove_by_restriction)
					remove_state(state.id)
			}
		}
		/**
		 * 重置状态计数（回数或步数）
		 * @param state_id
		 */
		public function  reset_state_counts(state_id:int):void{
			var state:RpgState = db.getState(state_id); 
			if (state == null) {
				return;
			}
			var variance:uint = 1 + Math.max((state.max_turns - state.min_turns), 0);
				state_turns[state_id] = state.min_turns + Random.integet(variance);
				state_steps[state_id] = state.steps_to_remove;
		}
		
		
	
		
		public function remove_state(state_id:int):void{
			if (hasState(state_id)){
				if (state_id == death_state_id )  {    
					revive();                        
				}
				erase_state(state_id);
				refresh();
				if (result.removed_states.indexOf(state_id)==-1)
					result.removed_states.push(state_id);
			}
		     
		}
		
		/**
		 * 状态自然解除 (回合改变时调用)
		 */		
		
		public function remove_states_auto(timing:uint):void{
			for each (var state:RpgState in states){
				if (state_turns[state.id] == 0 && state.auto_removal_timing == timing){
					remove_state(state.id)
				}
			}
		} 
			
		/**
		 * 
		# ● 强化／弱化的自动解除
		 */
			public function remove_buffs_auto():void{
				for (var i:int = 0; i < buffs.length; i++) 
				{
					var buff:int=buffs[i]
					if (buff==0|| buff_turns[i]>0){
						if  (buff_turns[i]>0)
						trace(i+"持续时间："+buff_turns[i])
						continue;
					}
						
					remove_buff(i);
				}
				
				
//			@buffs.size.times do |param_id|
//				next if @buffs[param_id] == 0 || @buff_turns[param_id] > 0
//				remove_buff(param_id)
//				end
				
			}
					
			/**
			 *  ● 受到伤害时解除状态
			 */
			public function remove_states_by_damage():void{
				for each (var state:RpgState in states){
					if (state.remove_by_damage && Math.random()< state.chance_by_damage)
						remove_state(state.id)
				}
				
			}
		
		
			public function 	update_state_turns():void{
				for each (var state:RpgState in states){
					if (state_turns[state.id] > 0){
						state_turns[state.id] -= 1
					}
				}
			}
			public function update_buff_turns():void{
			//	@buff_turns.keys.each do |param_id|
			//		@buff_turns[param_id] -= 1 if @buff_turns[param_id] > 0
					for (var key:String in buff_turns) 
					{ 
						if (buff_turns[key] > 0){
							buff_turns[key] -= 1
						}
					} 
			}
			/**
			 * 
			# ● 强化能力
			 */
			public function add_buff(param_id:uint, turns:uint):void{
				if (!isAlive) return;
				if (!isBuffMax(param_id)){
					buffs[param_id]+=1
				}
				//消除相应的弱化BUFF
				if (hasDebuff(param_id)){
					erase_buff(param_id) 
				}
					overwrite_buff_turns(param_id, turns);
					if (result.added_buffs.indexOf(param_id)==-1)
						result.added_buffs.push(param_id);
					refresh();
			}

				/**
				 * 
			# ● 弱化能力
				 */
				public function add_debuff(param_id:uint, turns:int):void{
					if (!isAlive) return;
					if (!isDebuffMax(param_id)){
						buffs[param_id]-=1;
					}
					if (hasBuff(param_id)){
						erase_buff(param_id)
					}
					overwrite_buff_turns(param_id, turns)
					if (result.added_debuffs.indexOf(param_id)==-1)
						result.added_debuffs.push(param_id)
				refresh();
				}

				
				/**
				 * 
				# ● 解除能力强化／弱化状态
				 * @param param_id
				 * 
				 */
				public function remove_buff(param_id:uint):void{
					if (!isAlive) return;
					if (buffs[param_id] == 0) return;
					erase_buff(param_id);
					delete buff_turns[param_id];
					if (result.removed_buffs.indexOf(param_id)==-1)
						result.removed_buffs.push(param_id);
						refresh();
					
				}

			
			/**
				 * 
				# ● 消除能力强化／弱化
				 * @param param_id
				 * @return 
				 * 
				 */
				public function erase_buff(param_id:uint):void{
					buffs[param_id] = 0
					buff_turns[param_id] = 0
					
				}

				/**
				# ● 判定能力强化状态
				 * 
				 * @return 
				 * 
				 */
				public function hasBuff(param_id:uint):void{
					buffs[param_id] > 0
				}

				/**
				# ● 判定能力弱化状态
				 * 
				 * @return 
				 * 
				 */
				public function hasDebuff(param_id:uint):void{
					buffs[param_id] < 0;
				}

				/**
				 * 
				# ● 判定能力强化是否为最大程度
				 * @return 
				 * 
				 */
				public function isBuffMax(param_id:uint):Boolean{
					return buffs[param_id] == 2
				}

				/**
				 *  ● 判定能力弱化是否为最大程度
				 * @param param_id
				 * @return 
				 * 
				 */
				public function isDebuffMax(param_id:uint):Boolean{
					return buffs[param_id] == -2
				}

				/**
				 * ● 重新设置能力强化／弱化的回合数
			#    如果新的回合数比较短，保持原值。
				 * @param param_id
				 * @param turns
				 * @return 
				 * 
				 */
				public function overwrite_buff_turns(param_id:uint, turns:int):void{
					 trace("BUFF次数："+(buff_turns[param_id] < turns) +"==="+buff_turns[param_id] +"==="+turns)
					
					
					if (int(buff_turns[param_id]) < turns){
						buff_turns[param_id] = turns
					}
				}
			
			
			
		
		public function die():void{
			_hp=0;
			clear_states();
			clear_buffs();
		}

		/** * ● 复活  HP为1*/
			public function revive():void{
				if (_hp==0)_hp=1;
				
			}

			
		
		
		
		
		
		//执行倒下
		public function performCollapse():void{
			if (isDead){
				
				collapse = true
				trace("倒下"+collapse)
				//Sound.play_enemy_collapse
			}
		
		}
		
		
		
		/**
		 * #--------------------------------------------------------------------------
			# ● 计算分散度
			#     damage   : 伤害
		#     variance : 分散度
		 */
		public function apply_variance(damage:Number, variance:int):int{
			if (damage != 0){
			//	amp = [damage.abs * variance / 100, 0].max    # 计算极差
			//	damage += rand(amp+1) + rand(amp+1) - amp     # 执行分散度
			}                              
			return damage
		}
		
		
		public function apply_guard(damage:Number):Number
		{
				if (damage > 0 &&isGuarding) {
					damage /= 2      
				}
				return damage
				
		}
		
		
		override public function refresh():void{
			super.refresh();
			_hp == 0 ? add_state(death_state_id) : remove_state(death_state_id)
		}

		/**
		 * 
		# ● 获取幸运影响程度
		 * @param user
		 * @return 
		 * 
		 */
		public function  luk_effect_rate(user:Battler):Number{
			return Math.max(1.0 + (user.luk - luk) * 0.001, 0);
		}
			/**
			 * 
			# ● 判定是否敌对关系
			 * @return 
			 * 
			 */
			public function  isOpposite(battler:Battler):Boolean{
			 return isActor != battler.isActor
				
			}

			/**
			 * 
			# ● 在地图上受到伤害时的效果
			 * 
			 */
			public function perform_map_damage_effect():void{
				
			}

			/**
			 * 
			# ● 初始化目标 TP 
			 * 
			 */
			public function init_tp():void{
				tp = Math.random()* 25
			}

			/**
			 * 
			# ● 清除 TP 
			 * 
			 */
			public function clear_tp():void{
				tp = 0
			}

			/**
			# ● 受到伤害时增加的 TP
			 * 
			 * @param damage_rate
			 * @return 
			 * 
			 */
			public function charge_tp_by_damage(damage_rate:Number):void{
						tp += 50 * damage_rate * tcr;
				
			}
		
			/**
			 *  ● HP 自动恢复
			 */
				public function regenerate_hp():void{
					var damage:int = -int(mhp * hrg)
						//在地图上受到伤害时的效果
						//perform_map_damage_effect if $game_party.in_battle && damage > 0
						result.hp_damage = Math.min(damage, max_slip_damage);
						hp -= result.hp_damage;
						//hp=10
				}

				/**
			 *  ● 获取连续伤害最大值 能够致命
			 */
			public function get max_slip_damage():int{
			//$data_system.opt_slip_death ? hp : [hp - 1, 0].max
				return hp;
			}

			/**
			 * ● MP 自动恢复
			 */
			public function regenerate_mp():void{
				result.mp_damage = -int(mmp * mrg);
				mp -= result.mp_damage;
			}
			/**
			 * ● TP 自动恢复
			 */
			public function regenerate_tp():void{
					//tp += 100 * trg
				
			}
			/**
			 *  ● 全部自动恢复
			 */
			public function regenerate_all():void{
				if (isAlive){
					regenerate_hp();
					regenerate_mp();
					regenerate_tp();
				}
			}
		
		
		
		/**
		 * ● 战斗行动结束时的处理
		 */
			public function on_action_end():void{
				result.clear();
				remove_states_auto(1)
				remove_buffs_auto();
			}

			/**
		 * ● 回合结束处理
		 */
			public function on_turn_end():void{
				result.clear();
				regenerate_all();
				update_state_turns();
				update_buff_turns();
				remove_states_auto(2)
			}
			
			
			/**
			 * ● 战斗开始处理
			 * 
			 */
			public function on_battle_start():void{
				//TP恢复
				//init_tp unless preserve_tp?
			}
		/**
		 * ● 战斗结束处理
		 */
			public function on_battle_end():void{
//				@result.clear
//				remove_battle_states
//				remove_all_buffs
				clear_actions();
//				clear_tp unless preserve_tp?
//					appear
			}

			
			
			/**
			 * 计算技能／物品的反击几率
			 * @param activeBattler
			 * @param item
			 * @return 
			 * 
			 */
			public function item_cnt(activeBattler:Battler, item:UsableItem):Number
			{
				if (false==item.isPhysical) return 0; //# 攻击类型不是物理攻击
				if (false==isOpposite(activeBattler)) return 0; // 来自队友的行动无法反击
				return cnt                             //返回反击几率
			}
			
			
			
			
			/**
			 * ● 被伤害时的处理
			 */
			public function on_damage(value:int):void{
				remove_states_by_damage();
				charge_tp_by_damage(value / mhp)
			}
		
			/**
			 * 
			# ● 强制战斗行动
			 * @param skill_id
			 * @param target_index 目标 -2重复上一次目标 ,-1随机
			 * 
			 */
			public function  force_action(skill_id:int, target_index:int):void{
				clear_actions();
					action =new BattleAction(this,true);
					action.setSkill(skill_id);
				if (target_index == -2){
					action.target_index = last_target_index;
					
				}else if(target_index == -1){
					action.decideRandomTarget();
				}else{
					action.target_index = target_index
					
				}
			}
				
		
			
			
	}
}