package rpg.model {
	
	import rpg.DataBase;
	import rpg.vo.ActionVo;
	import rpg.vo.BaseItem;
	import rpg.vo.Item;
	import rpg.vo.Skill;
	import rpg.vo.UsableItem;
	
	/**
	 * @author GUNDAM
	 * // 速度//种类 (基本 / 特技 / 物品)# 基本 (攻击 / 防御 / 逃跑)
	 * # 特技 ID# 物品 ID # 对像索引 # 強强制标志
	 */
	public class BattleAction {
		private var battler:Battler;
		public var speed : Number;                   
		public var itemObj:UsableItem;
		public var target_index : int ; 
		public var actTargets:Array;           		
		public var forcing : Boolean                 
		private var db:DataBase
		//评价值（自动战斗用）
		private var value:int;
		public function BattleAction(battler:Battler, forcing:Boolean = false){
			this.battler=battler;
			this.forcing=forcing;
			db=DataBase.getInstance();
			init();
		}
		
		
		public function get isAttack():Boolean{
			if (itemObj is Skill && itemObj.id==battler.attack_skill_id)
				return true;
			
			return false;
		}
		

		
		public function get skill():Skill{
			return itemObj as Skill;

		}
		public function setSkill(id:int):void{
			itemObj=db.getSkill(id)
		}
		
		
		public function setItem(id:int):void{
				itemObj=db.getItem(id)
			
		}
		
		public function get item():UsableItem{
			return itemObj as UsableItem;
		}
		
/**
		 * 判断行动有效度
     在事件命令并不造成强制性战斗行动时，因状态限制或缺少物品而导致
    无法行动，则返回 false.
  */
		public function get isValid():Boolean{
			
			if (forcing&&itemObj || battler.usable(itemObj)){
				return true 
			}
		
			return false;
		}
		
		
		private function init():void{
			clear();
		}
		
		public function clear():void{
			itemObj = null;
			value = 0
			target_index = -1
		    forcing = false;
			actTargets=null;
		}
		
		
		/**
		 * 获取队友单位
		 * @return 
		 * 
		 */
		public function get friends_unit():Troop{
			return battler.friendTroop;
		}
			/**
			 * 
			# ● 获取敌人单位
			 * @return 
			 * 
			 */
			public function get opponents_unit():Troop{
				return battler.opponentTroop
			}
			
			
			/**
			 * ● 设置敌人的战斗行动
				#     action : RPG::Enemy::Action
			 * @param action
			 * 
			 */
			public function set_enemy_action(action:ActionVo):void{
				if (action){
					setSkill(action.skill_id)
					
				}else{
					clear();
					
				}
			}
			
			
			
		public function setAttack():void{
			setSkill(battler.attack_skill_id)
		}
		
		public function setGuard():void{
			setSkill(battler.guard_skill_id)
		}
		//设置混乱行动
		public function setConfusion():void{
			setAttack()
		}
		//行动准备
		public function prepare():void{
			if (battler.isConfusion && !forcing){
				setConfusion();
			}
		}
		
		
		
		
		
	// 确认行动速度
		public function make_speed():void{
				
		    speed = battler.agi + Math.random()*(5 + battler.agi / 4);
			if (itemObj){
				speed+=itemObj.speed;
			}
		   // speed += 2000 if guard?
		    //speed += 1000 if attack? and battler.fast_attack
		}
   
		
		public function decideRandomTarget():void{
			var target:Battler;
			if (item.isForDeadFriend)
				target = friends_unit.randomDeadTarget();
			else if( item.isForFriend)
				target = friends_unit.randomTarget();
			else
				target = opponents_unit.randomTarget();
			if (target){
				target_index = target.index
				trace("随机选取敌人"+target.battler_name)
			}else{
				clear();
			}
		}
		
		
		/**
		 *生成攻击目标 
		 * @return 
		 * 
		 */
		public function  make_targets():Array{
			var targets:Array;
  		 
  		  //actTargets=targets;
      		
			if (!forcing && battler.isConfusion){
				targets=[confusion_target()]
				
			}else if (item.isForOpponent){
		
				targets=targets_for_opponents();
				
			}else if (item.isForFriend){
				targets=targets_for_friends();
				
			}else{
				targets=[]
			}
			
			return targets;
		}

		public function confusion_target():Battler{
			var target:Battler
			switch(battler.confusion_level){
				case 1:
					target=opponents_unit.randomTarget();
				case 2:
					if (Random.boolean){
						target=opponents_unit.randomTarget();
					}else{
						target=friends_unit.randomTarget();
					}
				default:
					target=friends_unit.randomTarget();
			}
			trace("BattleAction 混乱状态下选择目标"+target.battler_name)
			return target;
		}
		
		/**
		 * 
		# ● 目标为敌人
		 * @return 
		 * 
		 */
		public function  targets_for_opponents():Array{
			var targets:Array=[];
			if (item.isForRandom){
			//	Array.new(item.number_of_targets) { opponents_unit.random_target }
			}else if (item.isForOne){
				var num:uint = 1 + (isAttack ? int(battler.atk_times_add) : 0)
				if (target_index < 0){
				//[opponents_unit.random_target] * num
					targets.push(opponents_unit.randomTarget());
				}else{
					//[opponents_unit.smooth_target(@target_index)] * num
					targets.push(opponents_unit.smoothTarget(target_index));
				}
			}else{
				targets=opponents_unit.alive_members;
					
			}
			return targets;
		}

		/**
	 * 	# ● 目标为队友
	 */
	public function targets_for_friends():Array{
		var targets:Array=[];
		if (item.isForUser){
			return [battler];
		}else if (item.isForDeadFriend){
			if (item.isForOne){
			//	[friends_unit.smooth_dead_target(@target_index)]
				targets.push(friends_unit.smooth_dead_target(target_index));
			}else{
				return	friends_unit.dead_members;
				
			}
		}else if (item.isForFriend){
			if (item.isForOne){
				//[friends_unit.smooth_target(@target_index)]
				targets.push(friends_unit.smoothTarget(target_index));
			}else{
				return	friends_unit.alive_members
				
			}
		}
		
		return targets;
	}
	
    
   	
	}
}
