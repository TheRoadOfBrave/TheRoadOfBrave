package rpg.model
{
	import com.adobe.utils.ArrayUtil;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.events.DynamicEvent;
	
	import rpg.DataBase;
	import rpg.battle.event.BattleEvent;
	import rpg.events.GameEvent;
	import rpg.vo.Item;
	import rpg.vo.RpgState;
	import rpg.vo.Skill;
	import rpg.vo.UsableItem;

	public class BattleModel extends EventDispatcher{
		public static const START_ACTOR_COMMAND_SELECTION:String="start_actor_command_selection";
		public static const SETUP_STATUSWINDOWS:String="setup_statuswindows";
		public static const START_PARTY_COMMAND:String="start_party_command";
		
		public static const SELECT_ENEMY:String = "select_enemy";
		public static const SELECT_ACTOR:String = "select_actor";
		public static const END_SKILL_SELECT:String = "end_skill_select";
		
		//主阶段，个角色行动设置完毕
		
		public static const CREAT_BATTLER_SPRITES:String="creat_battler_sprites";
		public static const PLAY_ANIMATION:String="play_animation";
		public static const DISPLAY_ACTION:String="display_action";
		public static const STATE_CHANGE:String="state_change";
		
		public static const WIN:String="win";
		public static const GAME_OVER:String="game_over";
		
		
		public static const END_ACTION:String="end_action";
		public static const TURN_STAR:String="turn_star";
		public static const TURN_END:String="turn_end";
		/**
		 * 
			1战斗准备  2指令输入 3回合开始 4战斗回合中 5回合结束
		 */
		public var phase:int;
		public var actionBattlers:Array;
		public var turn:int;
		/**当前控制角色索引 -1 没有选择		 */
		public var actorIndex:int=-1;
		/**
		 *当前行动的角色 
		 */
		public var activeBattler:Battler;
		
		/**
		 * 当前行动指定的目标
		 */
		public var actTargets:Array;
		public var cpuTroop:MonsterTroop;
		public var party:Party;
		private var battleFormula:BattleFormula;
		
		public var in_battle:Boolean
		private var preemptive:Boolean;
		private var surprise:Boolean;
		private var _action_forced:Battler;
		private static var _instance:BattleModel;
		public function BattleModel(){
			
			if (_instance) {
				throw new Error("BattleModel是单例,无法再创建!")
			}
			trace("战斗MODEL初始化")
			init();
		}
		
		public function get isTurnEnd():Boolean
		{
			return phase==5;
		}

		public static function getInstance():BattleModel{
			if (!_instance) {
				_instance=new BattleModel();
			}
			return _instance;
		}

		/**
		 * @spriteset = Spriteset_Battle.new
		    @message_window = Window_BattleMessage.new
		    @action_battlers = []
		    create_info_viewport
		*/
		
		
		private function init():void{
			actionBattlers=[];
			battleFormula=new BattleFormula();
			
			
		}
		
		private function sendEvent(eventName:String,obj:Object=null):void{
			var event:Event;
			if (obj){
				var dyEvent:GameEvent=new GameEvent(eventName);
				
				dyEvent.data=obj;
				event=dyEvent;
			}else{
				event=new Event(eventName);
			}
			
			dispatchEvent(event);
		}
		
		
		public function reset():void{
			cpuTroop=null;
			turn=0;
			actorIndex=-1;
			in_battle=false;
			party.clear();
		}
		
		/**
		 * 创建队伍，设置队伍成员，设置敌对队伍
		 * 
		 * */
		public function setupParty(party:Party):void{
			this.party=party;
			
			
		}
		
		public function setupEnemyTroop(troop:MonsterTroop):void{
			cpuTroop=troop;
			
			party.setOpponentTroop(cpuTroop);
			cpuTroop.setOpponentTroop(party);
		}
		
		//准备战斗
		public function battle_start():void{
			in_battle=true;
			trace("战斗准备，先选择队伍命令")
			start_party_command_selection();
		}
		
		
		private function call_gameover():void{
			sendEvent(GAME_OVER);
			trace("游戏结束")
		}
		
		/**
		 *继续下面的战斗 
		 * 
		 */
		public function  process_battle():void{
			process_forced_action();
			if (phase==4)
			process_action();
			
			//return if $game_temp.next_scene != nil
      		//$game_troop.interpreter.update
     		// $game_troop.setup_battle_event
     	// wait_for_message
    	 // process_action if $game_troop.forcing_battler != nil
    	//  return unless $game_troop.interpreter.running?
    	 //	 update_basic
		}
		
		
		/**
		 *判断胜负结果 
		 * @return 胜负已分
		 * 
		 */		
		private function judge_win_loss():Boolean{
			if (in_battle){
				if (party.isAllDead){
					
					 process_defeat();
			        return true
				}else if(cpuTroop.isAllDead){
					 process_victory();
			        return true
				}else{
			      	 return false
			    }
			     
			}else{
			    	 return true
			}
		      
		   
		}
    	
		
		public function process_escape():Boolean{
			//$game_message.add(sprintf(Vocab::EscapeStart, $game_party.name))
			var success:Boolean = preemptive ? true : (Math.random() < 100)
			if (success){
				//process_abort
				battle_end(1);
			}else{
				//@escape_ratio += 0.1
//				$game_message.add('\.' + Vocab::EscapeFailure)
//				$game_party.clear_actions
			}
			
			return success
		}
		
		/**
		 *全灭时的处理 
		 * 
		 */
    	private function process_defeat():void{
//    		 @info_viewport.visible = false
//    @message_window.visible = true
//    text = sprintf(Vocab::Defeat, $game_party.name)
//    $game_message.texts.push(text)
//    wait_for_message
   			 battle_end(2)
    	}
   
   		private function process_victory():void{
//			display_exp_and_gold
//			display_drop_items
			deal_level_up();
			trace("胜利！！！！！！！！！！！！！！")
   			battle_end(0)
			sendEvent(WIN);
   		}
    
		private function deal_level_up():void{
			var exp:int =1000
			for each(var actor:Actor in party.existing_members){
				//last_level = actor.level
				//last_skills = actor.skills
				actor.gain_exp(exp)
			}
		}
    	//   result : 结果（0：胜利，1：逃跑，2：失败）
		private function battle_end(result:int):void{
			
			
		  	if (result == 2 && ! cpuTroop.canLose){
				trace("团队全灭！！！！！！！！！！！！！！！！！！！！！！")
		  		 call_gameover();
		  	}else{
				trace("逃跑 胜利???！！！！！！！！！！！！！！！")
		  		party.clear_actions();
		    //  party.remove_states_battle
		   //  cpuTroop.clear();
				
//		      if $game_temp.battle_proc != nil
//		        $game_temp.battle_proc.call(result)
//		        $game_temp.battle_proc = nil
//		      end
				
//		      unless $BTEST
//		        $game_temp.map_bgm.play
//		        $game_temp.map_bgs.play
//		      end
		  
		  	}
		     
		  
		    in_battle = false
		}
    
		
		
		
		
		//显示所获得的金钱和经验值
		private function display_exp_and_gold():void{
			
		}
		
		//显示所获得的掉落物品
  		private function display_drop_items():void{
  		
  		}
  		
  		//显示升级
  		private function display_level_up():void{
  		
  		}
		
		//战斗开始处理
		private function  process_battle_start():void{
			//清空消息
			//等待10
			//显示敌人出现消息
			 //生成逃跑机率make_escape_ratio
    			//战斗事件处理
			//process_battle_event();
   				 start_party_command_selection();
		}


//============================我方角色行动设置===============================================		
		//开始队伍命令选择  战斗或逃跑，现在一直选择战斗直接nextActor()
		public function  start_party_command_selection():void{
    	 	 actorIndex = -1
     		activeBattler = null;
			if (phase!=2){
				phase=2;
				party.make_actions()
				cpuTroop.make_actions();
				sendEvent(START_PARTY_COMMAND);
			}
			
     		 //start_main();
			
     		 //nextActor();	
			
		}
		
		
		//确认技能 根据技能范围开始选择技能目标
		public function  determineSkill(skill:Skill):void{
			activeBattler.action.setSkill(skill.id)
			 if (skill.isNeedSelection){
			 	 if (skill.isForOpponent){
			 	 sendEvent(SELECT_ENEMY);
			 	 } else{
			 	  sendEvent(SELECT_ACTOR);
			 	 }			    
			 }else{
			 	
			 	 nextCommand()
			 }
		      
		    
		}
		
		public function  determineItem(item:Item):void{
			activeBattler.action.setItem(item.id)
			 if (item.isNeedSelection){
			 	 if (item.isForOpponent){
			 	 sendEvent(SELECT_ENEMY);
			 	 } else{
			 	  sendEvent(SELECT_ACTOR);
			 	 }			    
			 }else{
			 	
			 	 nextCommand()
			 }
		      
		    
		}
		
		
		//指定角色动作目标，指定完成后轮到设置下一个角色的行动
		public function setActionTarget(index:int):void{
			activeBattler.action.target_index=index;
			nextCommand();
			
		}
		
		public function setGuard():void{
			activeBattler.action.setGuard();
			nextCommand();
		}
		
		public function nextCommand():void{
			sendEvent(START_ACTOR_COMMAND_SELECTION);
		}
		
			//指定下一个角色命令
		public function nextActor():Boolean{
			do{
				if (actorIndex >= party.members.length -1){
					//FALSE 应该开始主回合
					return false;
					
				}		     
				actorIndex += 1;
				activeBattler = party.members[actorIndex];
				//			if (activeBattler.auto_battle){
				//				active_battler.make_action
				//				nextActor();
				//			}
				
			}while(!activeBattler.inputable);
			
        	
			//如果可以接受指令，发送命令选择事件
			
				trace("开始选择角色命令:"+activeBattler.battler_name)
				return true;
				//sendEvent(BattleModel.START_ACTOR_COMMAND_SELECTION);
			
		
		}

//===================================================================================		
		//回合开始 开始执行战斗处理
		public function turn_start():void{
			phase = 3;
   			turn++;
    		actorIndex = -1
    		activeBattler = null;
    		trace("进入主阶段！生成敌人行动")
			cpuTroop.increase_turn();
    	//	cpuTroop.make_actions();
    		//playerTroop.make_actions();
    		makeActionOrders();
			
			phase = 4
//			process_forced_action();
//    		process_action();
			sendEvent(TURN_STAR);
		}
		
		//排列行动顺序	
		private function makeActionOrders():void{
			actionBattlers=[];
			actionBattlers=actionBattlers.concat(party.members);
			actionBattlers=actionBattlers.concat(cpuTroop.members);
			for each(var battler:Battler in actionBattlers){
				battler.make_speed();
			}
			
			actionBattlers.sort(sortOnSpeed);
			for(var i:uint = 0; i < actionBattlers.length; i++) {
				var index:Battler = actionBattlers[i];
				trace("速度排列：：："+index.battler_name, ": " + index.speed);
			}
		}
		
		private function sortOnSpeed(a:Battler, b:Battler):Number {
			var speed1:Number = a.speed;
			var speed2:Number = b.speed;
			
			if(speed1 > speed2) {
				return -1;
			} else if(speed1 < speed2) {
				return 1;
			} else  {
				return 0;
			}
		}
		
		
		private var last_subject:Battler;
	
		
		/**
		 *  ● 处理强制战斗行动
		 */
		public function  process_forced_action():void{
			if (isActionForced){
				
				last_subject = activeBattler;
			
				activeBattler = action_forced_battler
				clear_action_force();
				//	并不立即行动
				process_action();
				
				// 这里不能立刻恢复
			}
			
		}
		/**
		 * 战斗行动处理,步进
		 * 
		 */	
		public function process_action():void{
			if (judge_win_loss()){
				return;
			}
			if (activeBattler==null || activeBattler.action==null)
				activeBattler=next_active_battler();
			
			if (activeBattler==null){
				turn_end();
				return;
			}
			//如果行动条件允许，执行行动
			if (activeBattler.action && activeBattler.action.isValid){
				trace(activeBattler.action.item.name)
			    	execute_action();
		   }
			
			
		}
		
		public function process_action_end():void{
			trace("行动结束---"+activeBattler.battler_name);
			activeBattler.action=null;
			activeBattler.on_action_end();
			
			//refresh_status
//			@log_window.display_auto_affected_status(@subject)
//				@log_window.wait_and_clear
//				@log_window.display_current_state(@subject)
//				@log_window.wait_and_clear
				judge_win_loss();
		}
		
		/**
		 * 行动结束，状态自然恢复判定并开始下个角色行动
		 * 行动播放完后调用
		 * 
		 */		
		public function endAction(delay:int=0):void{
			if (ArrayUtil.arrayContainsValue(actionBattlers,activeBattler)){
				activeBattler.makeAction();
			}
			if (last_subject){
				activeBattler = last_subject
				last_subject=null;
			}else{
				trace("清空ACT者..."+activeBattler)
				activeBattler=null;
			}
			
			sendEvent(END_ACTION);
//			if (delay>0){
//				process_forced_action();
//				TweenLite.delayedCall(delay,process_action,[],true);
//			}else{
//				process_forced_action();
//				process_action();
//			}
			
			
		}
		
		/**
		 *● 设置下一战斗者行动
  #    当「强制战斗行动」事件命令被执行时，设置该战斗者并将他从列表中移除
  #    否则从列表顶端开始。当角色不在队伍之中时（可能因事件命令而离开）则
  #    直接跳过。 
		 * @return 
		 * 
		 */		
		public function next_active_battler():Battler{
				 
				 do{
					 var battler:Battler = actionBattlers.shift();
					 if (!battler) return null;
				 }while(!(battler.index && battler.isAlive));
				 
				 return battler
		}
		
		
		public function remove_states_auto():Boolean{
			var last_st:Array = activeBattler.states
			if (activeBattler.states != last_st){
				
			//	display_state_changes(activeBattler)
			//	sendEvent(STATE_CHANGE);
				return true;
			}
			return false;
		}
		
			/**
			 *● 获取敌我双方的全部参战角色 
			 * @return 
			 * 
			 */
			public function get all_battle_members():Array{
				var array:Array=party.members.concat(cpuTroop.members);
				return array;
			}
		public function turn_end():void{
			//cpuTroop.turn_ending = true
		    party.slip_damage_effect()
		    cpuTroop.slip_damage_effect()
		    party.do_auto_recovery()
			for each (var battler:Battler in all_battle_members){
				battler.on_turn_end();
			}
			preemptive = false
			surprise = false
				phase=5
		   // cpuTroop.preemptive = false
		   //cpuTroop.surprise = false
		 //   process_battle_event();
				sendEvent(TURN_END);
		 //   start_party_command_selection()
			
		}
		
		public function execute_action():void{
			use_item()

			
		}
		
//===========强制行动相关=========================================
		/**
		 * ● 强制行动
		 */
		public function force_action(battler:Battler):void{
			_action_forced = battler
		//	actionBattlers.delete(battler)
				if (battler.isAddAction) return;
			ArrayUtil.removeValueFromArray(actionBattlers,battler);
		}

		public function get action_forced_battler():Battler{
			return _action_forced ;
		}
		
		/**
		 *  ● 获取是否战斗行动的强制状态
		 * @return 
		 * 
		 */
		public function get isActionForced():Boolean{
			return _action_forced != null;
		}
		
		/**
		 *  ● 清除强制的战斗行动
		 */
		public function clear_action_force():void{
			_action_forced = null;
		}

//====================计算行动效果并发出相应消息给视图演示动画===============================================================		
		private function use_item():void{
			var item:UsableItem = activeBattler.action.item
			//	@log_window.display_use_item(@subject, item)
			//activeBattler.use_item(item)
			//refresh_status
			actTargets = activeBattler.action.make_targets();
			ArrayUtil.removeValueFromArray(actTargets,null);
			trace("use_item() 行动开始---"+activeBattler.battler_name+activeBattler.action.item.name);
			//便于扩展，发送dyEvent
			var evt:BattleEvent=new BattleEvent(BattleEvent.DISPLAY_ACTION);
			evt.battler=activeBattler;
			evt.targets=actTargets;
			evt.action=activeBattler.action;
			//sendEvent(BattleModel.DISPLAY_ACTION,evtObj);	
			dispatchEvent(evt);
			
		//	targets.each {|target| item.repeats.times { invoke_item(target, item) } }
			for each(var target:Battler in actTargets){
				//	trace("计算攻击效果")
				invoke_item(target,item);
			}
		}
		
		private function invoke_item(target:Battler, item:UsableItem):void{
			var evt:BattleEvent=new BattleEvent(BattleEvent.DISPLAY_ACTION_RESULT);
			if (Math.random()<0&& target is Monster){
				//反击
				//target.item_cnt(@subject, item)
				invoke_counter_attack(target, item)
				evt.battler=target;
				evt.targets=[activeBattler];
				evt.kind=1;
			}else if (0){
				//魔法反射
	//			elsif rand < target.item_mrf(@subject, item)
	//			invoke_magic_reflection(target, item)
				evt.battler=target;
				evt.targets=[activeBattler];
				evt.kind=2;
			}else{
				// 应用效果
				apply_item_effects(target, item)
				//便于扩展，发送dyEvent
			
				evt.battler=activeBattler;
				evt.targets=[target];
				
			}
				//apply_item_effects(apply_substitute(target, item), item)
				activeBattler.last_target_index = target.index;
				
				dispatchEvent(evt);
		}
		
		/**
		 *反击 
		 * @param target
		 * @param item
		 * 
		 */
		private function invoke_counter_attack(target:Battler, item:UsableItem):void
		{
		//	@log_window.display_counter(target, item)
				var attack_skill:Skill =DataBase.getInstance().getSkill(target.attack_skill_id);
			trace("应用反击"+attack_skill)
				battleFormula.item_apply(target,activeBattler,attack_skill);
					//refresh_status
			//@log_window.display_action_results(@subject, attack_skill)
		}
		public function apply_item_effects(target:Battler, item:UsableItem):void{
			battleFormula.item_apply(activeBattler,target,item);
			//target.item_apply(@subject, item)
				
		//	refresh_status
			//@log_window.display_action_results(target, item)
			
		}
		
			
			
			
		
		public function execute_action_guard():void{
			
		}
		
		public function execute_action_wait():void{
			
		}
		
		public function execute_action_escape():void{
			
		}
	}
}