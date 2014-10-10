package rpg.battle.control
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.RoughEase;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import rpg.Cache;
	import rpg.battle.view.BattleView;
	import rpg.model.BattleAction;
	import rpg.model.Battler;

	public class EnemyDisplayer extends BaseActDisplayer
	{
		
		
		
		
		public function EnemyDisplayer(view:BattleView)
		{this.view=view;
		}
		
		
		private var scope:int;
		
		override public function determineEffect(actBattler:Battler,act:BattleAction):String{
			var txt:String="";
					txt="使用技能";
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
				txt+=act.item.name;
			view.showMsg(battler.battler_name+txt);
			return txt;
		}
		
		
		private var timeline:TimelineMax
		override public function playBattlerAct(activeBattler:Battler,targets:Array,act:BattleAction):int{
			battler=activeBattler;
			actSp=battleStage.getBattlerSprite(activeBattler);
			
			
			determineEffect(activeBattler,act);
			//var effect_xml:XML=db.getEffectData(1);
			var flag:int=0;
			
		 timeline = new TimelineMax({useFrames:true});
			//var tween:TweenMax=TweenMax.to(actSp.view, 10, {repeat :1 ,yoyo:true,colorMatrixFilter:{colorize:0xFFFFFF, amount:1,brightness:2}});
			var tween:TweenMax=TweenMax.to(actSp.view,5, {repeat :1 ,yoyo:true,colorTransform:{tint:0xffffff, tintAmount:0.3, brightness:1, redMultiplier:1}});
			flag+=12;
			timeline.append(tween);
			timeline.addCallback(playHitEffect,flag,[targets]); 
			if (skillmc&&activeBattler.action.item.scope>=7){
				var lbs:XML=skillmc.data;
				if (lbs)
					addFlag(timeline,flag,lbs.children(),activeBattler,targets);
				flag+=skillmc.totalFrames+10;
			//	flag+=20;
			}
			timeline.addCallback(playHitEffect,10,[targets]); 
		//	flag+=skillmc.totalFrames;
			//timeline.addCallback(playActionEffect,flag); 
			return flag;
			
		}
		
		//播放打击效果
		private function playHitEffect(targets:Array):void{
			if (skillmc){
				if (pos==3){
					battleStage.playAnimation(skillmc,targets);
				}else if (targets.length==1){
					battleStage.addMcOnSprite(targets[0],skillmc,pos);
					skillmc.play();
				}else{
					//复数播放 每个目标上都播放
					//playMc(skillmc,targets);
				}
			}
		}
		
		
		
		override public  function display_hp_damage(target:Battler,obj:Object=null):void{
			var hp_damage:Number=target.result.hp_damage;
			if (hp_damage==0){
				
			}else if (hp_damage>0){
				var index:int=target.index;
				var sp:Sprite=view
				TweenMax.from(sp,0.6,{x:sp.x+1,y:sp.y-1,ease:RoughEase.create(12, 4, false, Linear.easeNone, "none", false)});
				TweenMax.from(sp, 0.4, 
					{ease:RoughEase.create(5, 3, false, Linear.easeNone, "none", false),
						colorTransform:{tint:0xffffff, tintAmount:0.3, brightness:1, redMultiplier:1}});
				view.showMsg(target.battler_name+"受到伤害"+hp_damage);
			}else{
				view.showMsg(target.battler_name+"回复体力："+hp_damage);
				battleStage.showDamage(target,hp_damage,target.result.critical);
			}
			
		}
		
	}
}