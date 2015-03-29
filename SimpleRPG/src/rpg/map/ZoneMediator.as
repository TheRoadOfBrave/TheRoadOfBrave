package rpg.map
{
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.GameConst;
	import rpg.WindowConst;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.events.SceneEvent;
	import rpg.model.MonsterTroop;
	import rpg.model.Troop;
	
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
			addViewListener("arrive",arriveHandler);
		}
		
		private function battleFinishHandler(event:BattleEvent):void
		{
			var result:int=event.kind 
			dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
			
			if (result==GameConst.WIN){
				var troop:MonsterTroop=event.troop;
				var gold:uint=troop.gold_total();
				var exp:uint=troop.exp_total();
				var items:Array=troop.make_drop_items();
				view.moveable=true;
			}else if (result==GameConst.LOSE){
				dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
				
			}else{
				view.moveable=true;
			}
			
			//	model.interpreter.next();
			
			
		}
		
		private function goHandler(event:Event):void
		{
				view.go(Random.integet(10),false);
		}		
		
		private function arriveHandler(event:Event):void
		{
			var cmdEvent:ScriptCmdEvent=new ScriptCmdEvent(ScriptCmdEvent.EXE_BATTLE_COMMAND);
			cmdEvent.code=301
			var monsterId:int=Random.integet(5)
			if (monsterId==4) monsterId=1;
			cmdEvent.params=[0,monsterId]
			dispatch(cmdEvent);
		}
			
			
			
	}
}