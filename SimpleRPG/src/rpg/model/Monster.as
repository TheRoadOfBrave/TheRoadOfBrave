package rpg.model
{
	import rpg.DataBase;
	import rpg.vo.ActionVo;
	import rpg.vo.BaseItem;
	import rpg.vo.DropItem;
	import rpg.vo.MonsterVo;
	import rpg.vo.Skill;
	
	public class Monster extends Battler
	{
		private var vo:MonsterVo
		public var  monster_id:int ;
		public var original_name  :String,letter :String;
		public var monster:XML;
		public var plural:Boolean;
		public var screen_x :Number,screen_y:Number;
		public function Monster(index:int,id:int)
		{
			super();
			this.index = index;
    		monster_id = id;
    		
    		this.vo=db.getMonsterVo(monster_id);
    		trace("怪物名"+vo.name)
   			original_name =vo.name
    		letter = ""
    		plural = false
    		screen_x = 0
    		screen_y = 0
    		battler_name = vo.battler_name
    		battler_hue = vo.battler_hue
    		hp = mhp
    		mp = mmp
    		gold=vo.gold;
		}
		
		override protected function init():void{
			super.init();
				
			skillIdList=[1,2,4]
		}
		
		
		
		override public function get id():int{
			return monster_id;
		}
		
		override public  function param_base(param_id:uint):int
		{
			return vo.params[param_id];
		}
		
		override public function get feature_objects():Array{
			return super.feature_objects.concat(vo);
			
		}
		
	
		
		
		override public function getElementRate(element_id:int):int{
			var result:int = vo.getElementRate(element_id);
//			for state in states
//			result /= 2 if state.element_set.include?(element_id)
//			end
			return result
		}
		
		/**
		 * ● 判定行动条件是否符合
			#     action : RPG::Enemy::Action
		 * @param action
		 * @return 
		 * 
		 */
		private function  isConditionsMet(action:ActionVo):Boolean{
			var method_table:Object = {
				1  :conditions_met_turns,
				2  :conditions_met_hp,
				3  :conditions_met_mp,
				4 :conditions_met_state,
				5 :conditions_met_party_level,
				6  :conditions_met_switch
			}
			var method:Function= method_table[action.condition_type]
			
		if (method!=null)
			return method(action.condition_param1, action.condition_param2)
		else 
			return true;
		}
		
			/**
			 * ● 判定行动条件是否符合“回合数”
			 * @param param1
			 * @param param2
			 * 
			 */
			private function conditions_met_turns(param1:int, param2:int):Boolean{
				var n:uint = friendTroop.turn_count;
				if (param2 == 0)
					return n == param1
				else
					return n > 0 && n >= param1 && n % param2 == param1 % param2
				
			}
			/**
			 * # ● 判定行动条件是否符合“HP”
			 * @param param1
			 * @param param2
			 * 
			 */
			private function conditions_met_hp(param1:int, param2:int):Boolean{
				return hp_rate >= param1 && hp_rate <= param2
			}
		
			/**
			 * # ● 判定行动条件是否符合“MP”
			 * @return 
			 * 
			 */
			private function conditions_met_mp(param1:int, param2:int):Boolean{
				return mp_rate >= param1 && mp_rate <= param2
				
			}
			/**
			 * 
			# ● 判定行动条件是否符合“状态”
			 * @return 
			 * 
			 */
			private function conditions_met_state(param1:int, param2:int):Boolean{
				return hasState(param1)
			}
			/**
			 *  ● 判定行动条件是否符合“队伍等级”
			 * @return 
			 * 
			 */
			private function conditions_met_party_level(param1:int, param2:int):Boolean{
				//$game_party.highest_level >= param1
					return true;
			}
			/**
			 * ● 判定行动条件是否符合“开关”
			 * @return 
			 * 
			 */
			private function conditions_met_switch(param1:int, param2:int):Boolean{
			//	$game_switches[param1]
				return true;
			}
				
		
		
		private function isActionValid(action:ActionVo):Boolean{
			var skill:Skill=db.getSkill(action.skill_id);
			return 	isConditionsMet(action) && skill;
		}
		
		/**
		 * # ● 随机选择战斗行动
		 * @param action_list:Action 的数组
		 * @param rating_zero 作为零值的标准
		 * 
		 */
		private function select_enemy_action(action_list:Array, rating_zero:int):ActionVo{
			var sum:int;
			//sum = action_list.inject(0) {|r, a| r += a.rating - rating_zero }
			for each (var a:ActionVo in action_list){
				sum+=a.rating -rating_zero;
			}
			if (sum<=0) return null;
		var value:int = Random.integet(sum);
			for each (var action:ActionVo in action_list){
				if (value<action.rating - rating_zero)
					return action;
				else
					value-=action.rating-rating_zero;
			}
			return null;
		}
		
		
		//生成战斗行动
		override public function makeAction():void {
				super.makeAction();
			//	return if @actions.empty?
				if (action==null) return;
				var 	action_list:Array = vo.actions;
				action_list=action_list.filter(testActionValid);
				//= enemy.actions.select {|a| action_valid?(a) }
				 if (action_list.length==0) {
					//没有适合的行为  可能进行不下去
					 return;
				 }
				var	rating_max:int 
				var actionVo:ActionVo;
				for each (actionVo in action_list){
					if (actionVo.rating>rating_max)
						rating_max=actionVo.rating;
				}
			
				var rating_zero:int = rating_max - 3
				//action_list.reject! {|a| a.rating <= rating_zero }
				var temp_list:Array=[];
				for each (actionVo in action_list){
					if (actionVo.rating>rating_zero){
						rating_max=actionVo.rating;
						temp_list.push(actionVo);
					}
				}
				action_list=temp_list;
				action.set_enemy_action(select_enemy_action(action_list, rating_zero))
		}
		
		private function testActionValid(element:*, index:int, arr:Array):Boolean {
			return isActionValid(element);
		}
		
		override public function get exp():int
		{
			return vo.exp;
		}
		
		
		public function make_drop_items():Array
		{
			var items:Array=[];
			for each (var di:DropItem in vo.drops){
				if (di.kind > 0 && Math.random() * di.denominator < drop_item_rate){
					items.push(getItemObj(di.kind, di.id))
					
				}else{
					
				}
			}
			return items;
		}
		
		
		
		public function get drop_item_rate():Number{
			//$game_party.drop_item_double? ? 2 : 1
			return 1;
		}
		
		public function getItemObj(kind, id):BaseItem{
			if (kind == 1) return db.getItem(id);
			if (kind == 2) return db.getItem(id);
			if (kind == 3) return db.getItem(id);
			return null;
		}
	}
}