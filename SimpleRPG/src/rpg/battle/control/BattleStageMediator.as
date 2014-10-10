package rpg.battle.control
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.effects.Move;
	import mx.effects.Sequence;
	
	import rpg.model.BattleModel;
	import rpg.battle.view.BattleStage;
	import rpg.view.BattlerSprite;
	
	/**
	 *不使用，合并到actorcommandmediator中 
	 * @author Administrator
	 * 
	 */	
	public class BattleStageMediator extends EventDispatcher
	{
		public static const NAME:String = "BattleStageMediator";
		
		public static const SHOW_ACTION_RESULT:String = "show_action_result";
		public static const SHOW_ACTION_EFFECT:String = "show_action_effect";
		
		private var model:BattleModel;
		
		private var view:BattleStage
		public function BattleStageMediator(view:BattleStage,model:BattleModel)
		{
			this.view=view;
			this.model=model;
			init();
		}
		
//		private function get view():BattleStage{
//			return viewComponent as BattleStage;
//		}
		
		private function init():void{
			view.monsterBox.addEventListener(MouseEvent.CLICK,selectTarget);
			view.cancelSelect();
			
		}


		
		
		
//====================================================================================================	
//		 public function listNotificationInterests():Array{
//			return [BattleAppProxy.CREAT_BATTLER_SPRITES,
//					BattleAppProxy.SELECT_ENEMY,
//					SHOW_ACTION_RESULT,
//					SHOW_ACTION_EFFECT
//			
//			 ];
//		}
		
//		 public function handleNotification(note:INotification):void{
//			switch ( note.getName() ){
//				case BattleAppProxy.CREAT_BATTLER_SPRITES:
//					view.createEnemies(appProxy.cpuTroop);
//					break;
//				case BattleAppProxy.SELECT_ENEMY:
//					view.canSelectMonsters(true);
//					break;
//				case SHOW_ACTION_EFFECT:
//					var noteObj:Object=note.getBody()
//					view.addAnimationOnSkins(noteObj.mc,noteObj.targets);
//					break;
//				
//					
//			}
//		}
//		
   		
   		
   		
   		private function selectTarget(event:MouseEvent):void{
			var skin:BattlerSprite=event.target as BattlerSprite
			
			if (skin){
				trace("点击战斗图形象"+skin.name)
				var battlerSelected:BattlerSprite=skin;
				
				if (battlerSelected){
					trace("选择了"+battlerSelected.battler.battler_name+"INDEX"+battlerSelected.index)
					view.cancelSelect();
					model.setActionTarget(battlerSelected.index);
					
				}
			}
			
			
		}
   		
   		private function playAnimation():void{
   			trace("播放动画")
				var sequence:Sequence=new Sequence();
				
					 var moveEffect:Move = new Move(); 
					moveEffect.xFrom=500;
					moveEffect.target=view.enemySprites[0];					
					sequence.addChild(moveEffect);
				
				sequence.play();
				
				
			} 
    
	}
}