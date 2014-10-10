package rpg.battle.control
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.events.DynamicEvent;
	
	import rpg.Cache;
	import rpg.DataBase;
	import rpg.model.BattleModel;
	import rpg.model.Battler;
	import rpg.battle.view.BattleSceneView;
	import rpg.battle.view.BattleStage;
	import rpg.view.BattlerSprite;
	import rpg.battle.view.CommandWindow;
	import rpg.battle.view.PlayerCommandWindow;
	
	import spark.components.Button;
	
	//不使用
	public class ActionPlayControler extends EventDispatcher
	{
		public static const NAME:String = "ActorCommandMediator";
		
		
		public static const START_SELECT_SKILL:String = "start_select_skill";
		public static const START_SELECT_ITEM:String = "start_select_item";
		
	
		
	
		private var view:BattleSceneView
		private var model:BattleModel;
		private var db:DataBase=DataBase.getInstance();
		public function ActionPlayControler(view:BattleSceneView,model)		{
			this.model=model;
			this.view=view;
			init()
		}
		
		
		
		private function init():void{
			
			model.addEventListener(BattleModel.DISPLAY_ACTION,actHandler);
		}
		
		
		protected function get activeBattler():Battler{
			return model.activeBattler;
		}
		
		
		private function get cmdWindow():CommandWindow{
			return view.cmdWindow;
		}
		
		private function get battleStage():BattleStage{
			return view.battleStage;
		}
		
		
		protected function actHandler(evt:DynamicEvent):void{
			xml=db.getActData(1);
			trace(xml)
			playAction(model.activeBattler);
		}
		
		
		//播放动作效果
		protected function playAction(activeBattler:Battler):int{
			
			playBattlerAct(activeBattler)
			return 20;
		}
		
		protected var xml:XML=db.getActData(1);
		protected var actSp:BattlerSprite;
		
		
		
		//播放敌人行动动作
		public function playBattlerAct(activeBattler:Battler):void{
			actSp=battleStage.getFriendSprite(activeBattler.index);
			var targets:Array=activeBattler.action.actTargets
			if (targets){
				var target:Battler=targets[0]
				var targetSp:BattlerSprite=	battleStage.getEnemySprite(target.index);
				
			}
			
			var mc:MovieClip=Cache.getSkillMC("1");
			var effect_xml:XML=db.getEffectData(1);
			var flag:int=0;
			var tween:TweenLite=TweenLite.to(actSp.view,24,{x:targetSp.view.x-50,useFrames:true,onComplete:moveEnd,onCompleteParams:[actSp]});
			var tween2:TweenLite=TweenLite.to(actSp.view,24,{x:100,useFrames:true});
			flag+=tween.duration;
			
			var timeline:TimelineMax = new TimelineMax({useFrames:true,onComplete:actEnd});
			timeline.append(tween);
			
			var hitTime:int=int(xml.hit.@frame);
			trace("动作打击点："+hitTime);
			flag+=hitTime;
			timeline.addCallback(playHitEffect,flag,[targets]); 
			
			flag+=mc.totalFrames;
			timeline.append(tween2,mc.totalFrames);
			
			

		}
		
		
		private function moveEnd(battlerSp:BattlerSprite):void{
			
			battlerSp.playAct();
		}
		
		private function playHitEffect(targets:Array):void{
			var mc:MovieClip=Cache.getSkillMC("1");
			for each (var target:Battler in targets){
				
				battleStage.addMcOnSprite(target,mc);
			}
			playActionEffect();
		}
		
		private function actEnd():void{
			model.process_action();
		}
		
		//动作在目标上的效果
		private function playActionEffect():void{
			if (true||activeBattler.isActor){
				for each (var target:Battler in activeBattler.action.actTargets){
					playEffect(target)
				}
			}
			
			
		}
		
		private function playEffect(target:Battler,obj:Object=null):void{
			if (!target.result.skipped){
				display_critical(target, obj)
				display_damage(target, obj)
				display_state_changes(target, obj)
			}
		}
		
		protected function display_critical(target:Battler,obj:Object=null):void{
			
		}
		
		protected  function display_damage(target:Battler,obj:Object=null):void{
			if (target.result.missed){
				display_miss(target, obj)
				
			}else if (target.result.evaded){
				display_evasion(target, obj)
				
			}else{
				display_hp_damage(target, obj)
				display_mp_damage(target, obj)
			}
			
		}
		
		protected  function display_miss(target:Battler,obj:Object=null):void{
			
		}
		protected  function display_evasion(target:Battler,obj:Object=null):void{
			
		}
		protected  function display_hp_damage(target:Battler,obj:Object=null):void{
			var hp_damage=target.result.hp_damage;
			if (hp_damage==0){
				
			}else if (hp_damage>0){
				battleStage.showDamage(target,hp_damage);
			}
		}
		protected  function display_mp_damage(target:Battler,obj:Object=null):void{
			
		}
		
		
		private function display_state_changes(target:Battler,obj:Object=null):void{
			
		}
		public function update():void{
			
		}
	}
}