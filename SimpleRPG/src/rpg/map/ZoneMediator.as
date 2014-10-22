package rpg.map
{
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.WindowConst;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.events.SceneEvent;
	
	public class ZoneMediator extends Mediator
	{
		[Inject]
		public var model:ZoneModel;
		[Inject]
		public var view:ZoneView;
		public function ZoneMediator()
		{
			super();
		}
		
		
		override public function initialize():void	{
			eventMap.mapListener( eventDispatcher, BattleEvent.FINISH, battleFinishHandler );
			addViewListener("go",goHandler);
		}
		
		private function battleFinishHandler(event:BattleEvent):void
		{
			dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
			view.moveable=true;
			//	model.interpreter.next();
			
			
		}
		
		private function goHandler(event:Event):void
		{
			
			var cmdEvent:ScriptCmdEvent=new ScriptCmdEvent(ScriptCmdEvent.EXE_BATTLE_COMMAND);
			cmdEvent.code=301
			cmdEvent.params=[0,1]
				dispatch(cmdEvent);
				
				view.go(Random.integet(10),false);
		}			
			
			
			
	}
}