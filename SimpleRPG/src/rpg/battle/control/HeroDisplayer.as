package rpg.battle.control
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import rpg.Cache;
	import rpg.DataBase;
	import rpg.GameSound;
	import rpg.battle.view.BattleSceneView;
	import rpg.battle.view.BattleStage;
	import rpg.battle.view.BattleView;
	import rpg.model.BattleAction;
	import rpg.model.Battler;
	import rpg.view.BattlerSprite;
	import rpg.vo.RpgState;
	import rpg.vo.Skill;
	import rpg.vo.UsableItem;

	public class HeroDisplayer  extends BaseActDisplayer
	{
		
		
		
		public function HeroDisplayer(view:BattleView)
		{
			this.view=view;
		}
		
		protected function addText(str:String):void{
			//view.msgWindow.showMsg(str);
		}
		
	private var scope:int;
		override public function determineEffect(actBattler:Battler,act:BattleAction):String{
			var txt:String="";
			skillmc=null;
			var aid:String = act.item.animation_id.toString();
			
			skillmc=Cache.getAnimation(aid);
			if (skillmc&&skillmc.pos!=null)
				pos=skillmc.pos;
				
				if (act.item.isForOne){
					scope=1
				}else{
					scope=2
				}
			txt=act.item.name;
		//	view.msgWindow.showMsg(battler.battler_name+txt);
			return txt;
		}
		
		
		var timeline:TimelineMax
		override public function playBattlerAct(activeBattler:Battler,targets:Array,act:BattleAction):int{
			battler=activeBattler;
			actSp=battleStage.getBattlerSprite(activeBattler);
			
			
			determineEffect(activeBattler,act);
			//var effect_xml:XML=db.getEffectData(1);
			var flag:int=0;
			
		 timeline = new TimelineMax({useFrames:true});
			//var tween:TweenMax=TweenMax.to(actSp.view, 10, {repeat :1 ,yoyo:true,colorMatrixFilter:{colorize:0xFFFFFF, amount:1,brightness:2}});
			//闪烁动作发起者 。(己方可能是空形象)
			var tween:TweenMax=TweenMax.to(actSp.view,5, {repeat :1 ,yoyo:true,colorTransform:{tint:0xffffff, tintAmount:0.3, brightness:1, redMultiplier:1}});
			//var hitTime:int=int(xml.hit.@frame);
			//trace("动作打击点："+hitTime);
			flag+=5;
		//	timeline.append(tween);
		
			if (skillmc){
				var lbs:XML=skillmc.data;
				if (lbs)
					addFlag(timeline,flag,lbs.children(),activeBattler,targets);
				flag+=skillmc.totalFrames+10;
			//	flag+=20;
			}
			timeline.addCallback(playHitEffect,10,[targets]); 
		//	flag+=skillmc.totalFrames;
			//timeline.addCallback(playActionEffect,flag); 
			//playHitEffect(targets);
			return flag;
			
		}
		
		//播放打击MC效果
		private function playHitEffect(targets:Array):void{
			if (skillmc){
				if (pos==3){
					battleStage.playAnimation(skillmc,targets);
				}else if (targets.length==1){
					battleStage.addMcOnSprite(targets[0],skillmc,pos);
					skillmc.play();
				}else{
				//	playMc(skillmc,targets);
				}
			}
		}
		
		
		
		override public function display_action_kind(kind:int,target:Battler,obj:Object=null):void{
			if (kind>0)
			view.showMsg(target.battler_name+"进行反击");
		}
		
		override public  function display_hp_damage(target:Battler,obj:Object=null):void{
			var hp_damage:int=target.result.hp_damage;
			if (hp_damage==0){
				
			}else if (hp_damage>0){
				
				battleStage.showDamage(target,hp_damage,target.result.critical);
				view.showMsg(target.battler_name+"受到伤害"+hp_damage);
			}else{
				view.showMsg(target.battler_name+"回复体力："+hp_damage);
			}
			
		}
		
		override public  function display_added_states(target:Battler):void{
			var battlerSp:BattlerSprite=battleStage.getBattlerSprite(target);
			for each (var state:RpgState in target.result.added_state_objects){
				if (state.id == target.death_state_id){
				//	trace(state.name+"无法战斗---------------")
				//	target.performCollapse();
					battlerSp.collapse();
				} else{
					var icon:Bitmap=new Bitmap(Cache.getIcon(state.id));
					icon.y=-battlerSp.height;
						battlerSp.addChild(icon);
						TweenLite.delayedCall(3,removeStateIcon,[battlerSp,icon]);
				}
				
			}
			
			
		}
		private function removeStateIcon(sp:Sprite,icon:Bitmap):void
		{
			if (sp&&sp.contains(icon)){
				sp.removeChild(icon);
			}
			
		}
		
		
		

		
	}
}