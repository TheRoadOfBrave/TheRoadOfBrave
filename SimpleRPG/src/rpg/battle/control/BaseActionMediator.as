package rpg.battle.control
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.events.DynamicEvent;
	
	import spark.components.Button;
	
	import rpg.Cache;
	import rpg.DataBase;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.view.ActorCmdWnd;
	import rpg.battle.view.BattleSceneView;
	import rpg.battle.view.BattleStage;
	import rpg.battle.view.BattleView;
	import rpg.battle.view.CommandWindow;
	import rpg.battle.view.PlayerCommandWindow;
	import rpg.model.BattleAction;
	import rpg.model.BattleModel;
	import rpg.model.Battler;
	import rpg.view.BattlerSprite;
	import rpg.vo.UsableItem;
	
	/**
	 * 监听战斗消息
	 *控制播放动作和效果流程 
	 * @author ganweida
	 * 
	 */	
	public class BaseActionMediator extends EventDispatcher
	{
		
		public static const START_SELECT_SKILL:String = "start_select_skill";
		public static const START_SELECT_ITEM:String = "start_select_item";
		
	
		
	
		protected var view:BattleView;
		protected var model:BattleModel;
		protected var battler:Battler;
		protected var targets:Array;
		protected var act:BattleAction;
		protected var db:DataBase=DataBase.getInstance();
		protected var playList:Array;
		protected var playing:Boolean=false;
		public function BaseActionMediator(view:BattleView,model:BattleModel){
			this.model=model;
			this.view=view;
			
			init()
		}
		
		
		
		protected function init():void{
			playList=[];
			model.addEventListener(BattleEvent.DISPLAY_ACTION,playHandler);
			model.addEventListener(BattleEvent.DISPLAY_ACTION_RESULT,playHandler);
			//model.addEventListener(BattleModel.STATE_CHANGE,changedState);
		}
		
		protected function playHandler(event:BattleEvent):void
		{
			playList.push(event);
			
			play();
		}		
		
		protected function play():void
		{
			if (playing==true){
				return;
			}
				var evt:BattleEvent=playList.shift();
			if (evt.type==BattleEvent.DISPLAY_ACTION){
				//播放工击动作
				actHandler(evt);
			}else if (evt.type==BattleEvent.DISPLAY_ACTION_RESULT){
				//播放行动造成的效果
				display_action_kind(evt.kind,evt.battler);
				playActionEffect(evt.battler,evt.targets)
			}
			playing=true;
		}		
		
		
		
		protected function get cmdWindow():ActorCmdWnd{
			return view.cmdWindow;
		}
		
		protected function get battleStage():BattleStage{
			return view.battleStage;
		}
		
		
		protected function actHandler(evt:BattleEvent):void{
		
		}
		
		protected function changedState(evt:Event):void{
		//	display_state_changes(activeBattler);
		}
		
		
		//播放动作效果
		protected function playAction():int{
			
			playBattlerAct(battler,targets,act)
			return 20;
		}
		
		
		
		
		//播放敌人行动动作
		public function playBattlerAct(activeBattler:Battler,targets:Array,act:BattleAction):void{

		}
		
		
//		protected function display_state_changes(target:Battler,item:UsableItem=null):void{
//			
//		}
		
		private function actEnd():void{
			model.process_action();
		}
		
		//遍历播放动作在目标上的效果
		protected function playActionEffect(battler:Battler,targets:Array):void{
		
			if (targets.length==1){
				playResultEffect(targets[0])
			}else if (targets.length>0){
				for each (var target:Battler in targets){
					playResultEffect(target)
				}
			}
			
			
		}
		
		private function playResultEffect(target:Battler,item:UsableItem=null):void{
//			if (!target.actResult.skipped){
//				display_critical(target, obj)
//				display_damage(target, obj)
//				display_state_changes(target, obj)
//			}
			
			if (target.result.used){
				
				display_critical(target, item)
				display_damage(target, item)
				display_affected_status(target, item)
				display_failure(target, item)
				//wait if line_number > last_line_number
			}
			
		}
		
		protected function display_action_kind(kind:int,target:Battler,item:UsableItem=null):void{
			
		}
		
		
		protected function display_critical(target:Battler,item:UsableItem=null):void{
			
		}
		
		protected  function display_damage(target:Battler,item:UsableItem=null):void{
			if (target.result.missed){
				display_miss(target, item)
				
			}else if (target.result.evaded){
				display_evasion(target, item)
				
			}else{
				display_hp_damage(target, item)
				display_mp_damage(target, item)
			}
			
		}
		
		protected  function display_miss(target:Battler,item:UsableItem=null):void{
			
		}
		protected  function display_evasion(target:Battler,item:UsableItem=null):void{
			
		}
		protected  function display_hp_damage(target:Battler,item:UsableItem=null):void{
			
		}
		protected  function display_mp_damage(target:Battler,item:UsableItem=null):void{
			
		}
		
		protected function display_failure(target:Battler,item:UsableItem=null):void{
			//	if target.result.hit? && !target.result.success
			//add_text(sprintf(Vocab::ActionFailure, target.name))
			//wait
			
		}
		
		
		/**
		 * 
		# ● 显示普通状态的效果影响
		 * @param target
		 * @param item
		 * @return 
		 * 
		 */
		protected function  display_affected_status(target:Battler,item:UsableItem=null):void{
			if (target.result.isStatusAffected){
				display_changed_states(target)
				display_changed_buffs(target)
			}
				//add_text("") if line_number < max_line_number
			
			//back_one if last_text.empty?
		}
		
			/**
			# ● 显示自动状态的效果影响
			 * 
			 * @param target
			 * 
			 */
			protected function  display_auto_affected_status(target:Battler):void{
//				if target.result.status_affected?
//					display_affected_status(target, nil)
//				wait if line_number > 0
//				end
//				end
			}
			protected function  display_current_state(subject:Battler):void{
			}
			/**
			# ● 显示状态附加／解除
			 * 
			 * @param target
			 * 
			 */
			protected function  display_changed_states(target:Battler):void{
				display_added_states(target)
				display_removed_states(target)
			}
		
			/**
			# ● 显示状态附加
			 * 
			 * @param target
			 * 
			 */
			protected function display_added_states(target:Battler):void{
//				target.result.added_state_objects.each do |state|
//					state_msg = target.actor? ? state.message1 : state.message2
//					target.perform_collapse_effect if state.id == target.death_state_id
//					next if state_msg.empty?
//						replace_text(target.name + state_msg)
//					wait
//					wait_for_effect
//					end
//					end
//				
			}
				/**
				 * 
				# ● 显示状态解除
				 * @param target
				 * 
				 */
				protected function display_removed_states(target:Battler):void{
					
//			target.result.removed_state_objects.each do |state|
//				next if state.message4.empty?
//					replace_text(target.name + state.message4)
//				wait
//				end
//				end
				}
					/**
					 * 
					# ● 显示能力强化／弱化
					 * @param target
					 * 
					 */
					protected function display_changed_buffs(target:Battler):void{
						
//				display_buffs(target, target.result.added_buffs, Vocab::BuffAdd)
//				display_buffs(target, target.result.added_debuffs, Vocab::DebuffAdd)
//				display_buffs(target, target.result.removed_buffs, Vocab::BuffRemove)
					}
					/**
					 * 
					# ● 显示能力强化／弱化（个別）
					 * @param target
					 * @param buffs
					 * @param fmt
					 * 
					 */
					protected function display_buffs(target:Battler, buffs, fmt):void{
//				buffs.each do |param_id|
//					replace_text(sprintf(fmt, target.name, Vocab::param(param_id)))
//					wait
//					end
//					end
						
					}
		
		public function update():void{
			
		}
	}
}