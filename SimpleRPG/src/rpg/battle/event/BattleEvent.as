package rpg.battle.event
{
	import flash.events.Event;
	
	import rpg.model.BattleAction;
	import rpg.model.Battler;
	import rpg.model.MonsterTroop;
	import rpg.model.Troop;
	
	public class BattleEvent extends Event
	{
		public static const PROCESS_EVENT:String="process_event";
		public static const RESUME_BATTLE:String="resume_battle";
		public static const START_ACTOR_COMMAND_SELECTION:String="start_actor_command_selection";
		public static const NEXT_COMMAND:String="next_command";
		public static const DISPLAY_ACTION:String="display_action";
		public static const DISPLAY_ACTION_RESULT:String="display_action_result";
		
		
		
		public static const FINISH:String="battle_finish";
		public var battler:Battler;
		public var targets:Array;
		public var action:BattleAction;
		/**
		 *打倒的队伍 ，用来获取战斗后的奖励 
		 */
		public var troop:MonsterTroop;
		public var kind:int;
		public function BattleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}