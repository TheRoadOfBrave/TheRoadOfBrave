package rpg.battle.control
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	import rpg.Cache;
	import rpg.DataBase;
	import rpg.GameSound;
	import rpg.battle.view.BattleSceneView;
	import rpg.battle.view.BattleStage;
	import rpg.battle.view.BattleView;
	import rpg.model.BattleAction;
	import rpg.model.Battler;
	import rpg.view.BattlerSprite;

	public class BaseActDisplayer
	{
		
		protected var view:BattleView;
		protected var xml:XML
		protected var actSp:BattlerSprite;
		protected var skillmc:MovieClip;
		protected var battler:Battler;
		protected var pos:int;
		protected var db:DataBase=DataBase.getInstance();
		public function BaseActDisplayer()
		{
		}
		
		protected function get battleStage():BattleStage{
			return view.battleStage;
		}
		
		public function determineEffect(actBattler:Battler,act:BattleAction):String{
			return "";
		}
		
		public function playBattlerAct(activeBattler:Battler,targets:Array,act:BattleAction):int{
			return 0;
		}
		public function display_action_kind(kind:int,target:Battler,obj:Object=null):void{
			//if (kind==1)
			//	view.msgWindow.showMsg(target.battler_name+"遭到反击");
		}
		
		public function display_critical(target:Battler,obj:Object=null):void{
			
		}
		
		
		
		public  function display_miss(target:Battler,obj:Object=null):void{
			
		}
		public  function display_evasion(target:Battler,obj:Object=null):void{
			
		}
		public  function display_hp_damage(target:Battler,obj:Object=null):void{
			
			
		}
		public  function display_mp_damage(target:Battler,obj:Object=null):void{
			
		}
		
		public  function display_added_states(target:Battler):void{}
		
		
		
		
		//解析帧标签数据	
		public function addFlag(timeline:TimelineMax,offset:int,labels:XMLList,activeBattler:Battler,targets:Array):void{
			var len:int=labels.length();
			
			for (var i:int=0;i<len;i++){
				var xml:XML=labels[i];
				var frame:int=xml.@frame;
				var type:String=xml.localName();
				//var arr:Array=["flash","1-2"]
				switch (type){
					case "se":
						timeline.addCallback(playSound,offset+frame,[xml.@snd]); 
						break;
					case "flash":
						var flasher:int=uint(xml.@target);
						var time:uint=uint(xml.@dur);
						var color:uint=uint("0x"+xml.@color.substr(1,6));
						var from:Object={	colorTransform:{tint:color, tintAmount:0.8}}
						var to:Object={	removeTint:true,colorTransform:{tint:color, tintAmount:0}}
						if (flasher==1){
							//闪烁目标
							var spArr:Array=new Array();
							for each (var target:Battler in targets){
								var sp:BattlerSprite=battleStage.getEnemySprite(target.index);
								if (sp)
									spArr.push(sp);
							}
							
							//	var strong:uint=params[3];
							
							if (spArr.length>0){
								var tweens:Array=	TweenMax.allFromTo(spArr,	time,from,to);		
								//timeline.appendMultiple(tweens,frLabel.frame);
								timeline.insertMultiple(tweens,offset+frame);
							}
						}else if (flasher==3){
							//闪烁屏幕
							//	var strong:uint=params[3];
							var tween:TweenMax=	TweenMax.fromTo(battleStage,	time,from,to);		
							timeline.insert(tween,offset+frame);
						}
						break;
				}
				
			}
		}
		
		protected function playSound(name:String):void{
			GameSound.getInstance().play(name);
		}
	}
}