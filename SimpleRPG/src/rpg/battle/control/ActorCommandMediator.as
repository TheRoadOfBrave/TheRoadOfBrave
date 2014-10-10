package rpg.battle.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import rpg.DataBase;
	import rpg.battle.view.ActorCmdWnd;
	import rpg.battle.view.ActorWindow;
	import rpg.battle.view.BattleView;
	import rpg.events.GameEvent;
	import rpg.model.BattleModel;
	import rpg.model.Battler;
	import rpg.view.BattlerSprite;
	import rpg.vo.Skill;
	
	
	/**
	 *负责命令框组件 的 
	 * @author ganweida
	 * 
	 */	
	public class ActorCommandMediator extends EventDispatcher
	{
		public static const NAME:String = "ActorCommandMediator";
		
		
		public static const START_SELECT_SKILL:String = "start_select_skill";
		public static const START_SELECT_ITEM:String = "start_select_item";
		
	
		
	
		private var view:BattleView;
		private var model:BattleModel;
		public function ActorCommandMediator(view:BattleView,model:BattleModel){
			this.model=model;
			this.view=view;
			init()
		}
		
		
		
		private function init():void{
			cmdWindow.visible=false;
			cmdWindow.addEventListener(ActorCmdWnd.SELECT_ACTION,selectActHandler);
			
			//view.battleStage.monsterBox.addEventListener(MouseEvent.CLICK,selectTarget);
			//view.battleStage.cancelSelect();
			
			//view.actorWindows.addEventListener(MouseEvent.CLICK,selectActor);
			//view.actorWindows.canSelect(false);
		}
		
		private function get cmdWindow():ActorCmdWnd{
			return view.cmdWindow;
		}
		
		
		private function sendEvent(eventName:String,obj:Object=null):void{
			var event:Event;
			
				event=new Event(eventName);
			
			
			dispatchEvent(event);
		}
		
		
		private function selectActorCommand(evt:Event):void{
			showCommandWindow()
		 	
		 	
		}
		
		private function showCommandWindow():void{
			cmdWindow.visible=true
			cmdWindow.mouseChildren=true;
			
			//cmdWindow.playShow();
			var battler:Battler=model.activeBattler;
		}
		
		private function selectActHandler(evt:GameEvent):void{
				var activeBattler:Battler=model.activeBattler;
				var actId:int=evt.data as int;
				
				activeBattler.action.clear();
				if (actId==activeBattler.attack_skill_id){
					activeBattler.action.setAttack()
					model.setActionTarget(1);
				}else if(actId==activeBattler.guard_skill_id){
					model.setGuard();
				}else  {
					var skill:Skill=DataBase.getInstance().getSkill(actId);
					
					if (skill!=null){
						
						
						activeBattler.action.setSkill(skill.id);
						model.setActionTarget(1);
						
					}
					
				}
				
				
			
		}
		
		private function selectTarget(event:MouseEvent):void{
			
			
		}
		
		private function selectActor(event:MouseEvent):void{
			
			
		}
		
	}
}