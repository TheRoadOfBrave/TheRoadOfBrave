package rpg.battle.control
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.events.DynamicEvent;
	
	import spark.components.Button;
	
	import avmplus.USE_ITRAITS;
	
	import mk.util.StrUtil;
	
	import rpg.Cache;
	import rpg.DataBase;
	import rpg.battle.BattleTxt;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.view.BattleSceneView;
	import rpg.battle.view.BattleStage;
	import rpg.battle.view.BattleView;
	import rpg.model.BattleAction;
	import rpg.model.BattleModel;
	import rpg.model.Battler;
	import rpg.view.BattlerSprite;
	import rpg.vo.RpgState;
	import rpg.vo.Skill;
	import rpg.vo.UsableItem;
	
	
	public class ActionMediator extends BaseActionMediator
	{
		
		private var enemyDisplayer:EnemyDisplayer
		private var heroDisplayer:HeroDisplayer;
		private var displayer:BaseActDisplayer;
		public function ActionMediator(view:BattleView,model:BattleModel){
			super(view,model);
			enemyDisplayer=new EnemyDisplayer(view);
			heroDisplayer=new HeroDisplayer(view);
		}
		
		
		protected function addText(str:String):void{
			//view.msgWindow.showMsg(str);
		}
		
		override protected function actHandler(evt:BattleEvent):void{
			//有执行行动 并且行动有效
			if (evt.action && evt.action.isValid){
				battler=evt.battler;
				targets=evt.targets;
				act=evt.action;
				if (battler.isActor){
					displayer=heroDisplayer;
				}else{
					displayer=enemyDisplayer;
				}
				
				TweenLite.delayedCall(24,playAction,null,true); 
				
				//接着会调playBattlerAct()
			//	playAction(model.activeBattler);
			}else{
				actEnd();
				
			}
			
		}
		
		private function actEnd():void{
			
			view.update();
//			if (!activeBattler.action.forcing){
//				if (model.remove_states_auto()){
//					//display_state_changes(activeBattler);
//				}
//				
//				display_current_state();
//			}
//			view.actorWindows.update();
//			view.actorWindows2.update();
//			
			
			model.process_action_end();
			//view.actorWindows.update();
			//view.actorWindows2.update();
			//refresh_status
			display_auto_affected_status(battler)
			//				@log_window.wait_and_clear
			display_current_state(battler);
			playing=false;
			if (playList.length>0){
				play();
			}else{
				displayer=null;
				model.endAction();
			}
			
		}
		
		
		
		
		//播放敌人行动动作
		override public function playBattlerAct(activeBattler:Battler,targets:Array,act:BattleAction):void{
			
			
			var time:int=displayer.playBattlerAct(activeBattler,targets,act);
			playing=false;
			TweenLite.delayedCall(time,play,[],true);
			

		}
		
		
		
		override protected function display_action_kind(kind:int,target:Battler,item:UsableItem=null):void{
			displayer.display_action_kind(kind,target);
		}
		
		//显示动作造成的效果，受伤值显示等
		override protected function playActionEffect(battler:Battler,targets:Array):void{
			trace("显示动作效果，受伤值显示等")
			if (battler.isActor){
				displayer=heroDisplayer;
			}else{
				displayer=enemyDisplayer;
			}
			battleStage.clearAnimations();
			super.playActionEffect(battler,targets);
			TweenLite.delayedCall(30,actEnd,[],true);
			
		}
		
		
		
		
		
		override protected function display_failure(target:Battler,item:UsableItem=null):void{
			if (target.result.beHit && !target.result.success){
				addText(StrUtil.replace(BattleTxt.ActionFailure, target.battler_name))
			}
		}
		
		override protected function display_critical(target:Battler,item:UsableItem=null):void{
			if (target.result.critical){
				addText(BattleTxt.Critical);
			}
			displayer.display_critical(target,item);
		}
		
		
		
		override protected  function display_miss(target:Battler,item:UsableItem=null):void{
			var fmt:String
			if( !item || item.isPhysical){
				fmt = target.isActor? BattleTxt.ActorNoHit : BattleTxt.EnemyNoHit
				//Sound.play_miss
				
			}else{
				fmt = BattleTxt.ActionFailure
			}
			fmt=StrUtil.replace(fmt,target.battler_name);
			addText(fmt);
			displayer.display_miss(target,item);
		}
		override protected  function display_evasion(target:Battler,item:UsableItem=null):void{
			var fmt:String
			if( !item || item.isPhysical){
				fmt = BattleTxt.Evasion;
				//Sound.play_miss
				
			}else{
				fmt = BattleTxt.MagicEvasion;
			}
			fmt=StrUtil.replace(fmt,target.battler_name);
			addText(fmt);
		}
		override protected  function display_hp_damage(target:Battler,item:UsableItem=null):void{
			displayer.display_hp_damage(target,item);
			
		}
		override protected  function display_mp_damage(target:Battler,item:UsableItem=null):void{
			
		}
		
		
		
		
//-----------------状态演示-----------------------------------------------------------------------------
		
		
		
		override protected function display_added_states(target:Battler):void{
				//				target.result.added_state_objects.each do |state|
				//					state_msg = target.actor? ? state.message1 : state.message2
				//					target.perform_collapse_effect if state.id == target.death_state_id
				//					next if state_msg.empty?
				//						replace_text(target.name + state_msg)
				//					wait
				//					wait_for_effect
				//			
			var msg:String="";
			for each (var state:RpgState in target.result.added_state_objects){
				msg = target.isActor ? state.message1 : state.message2
				if (state.id == target.death_state_id){
					// 无法战斗
					trace(state.name+"无法战斗---------------")
						target.performCollapse();
				}      
				
				msg=target.battler_name+msg+"\n";
				addText(msg);
			}
			displayer.display_added_states(target);
	}
//		
//		override protected function display_removed_states(target:Battler, obj = null):void{
//			for each (var state:RpgState in target.removed_states){
//				trace(state.name+"解除")
//				if (state.message4){
//				//	text = target.name + state.message4
//					
//					msg+=target.battler_name+"移除状态"+state.name+"\n";
//				}
//					
//			}
//		}
		
		/**
		 *当尝试将以睡着的人附加睡眠状态等时用的。 
		 * @param target
		 * @param obj 技能或物品
		 * 
		 */		
		private function display_remained_states(target:Battler, obj = null):void{
			for each (var state:RpgState in target.remained_states){
				if (state.message3){
					//	text = target.name + state.message4
					
				//	msg+=target.battler_name+"已经存在状态"+state.name+"\n";
				}
				
			}
		}
		
		override protected function  display_auto_affected_status(target:Battler):void{
					if (target.result.isStatusAffected){
						display_affected_status(target, null)
					}
		}
		//显示当前存在的最重要状态
		override protected function  display_current_state(subject:Battler):void{
			if (subject.mostImportantStateText){
				addText(subject.battler_name + subject.mostImportantStateText)
			}
		}
	}
}