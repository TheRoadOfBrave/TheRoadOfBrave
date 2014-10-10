package rpg.battle.command
{
	
	
	import com.greensock.TweenLite;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.BattleScene;
	import rpg.model.EventPage;
	import rpg.model.GameInterpreter;
	
	/**
	 * 
	 * @author maikid
	 *战斗事件脚本 
	 */
	public class ProcessBattleEventCommand extends Command
	{
		
		public var interpreter:GameInterpreter;
		[Inject]
		public var battleScene:BattleScene;
		
		public function ProcessBattleEventCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//return if $game_temp.next_scene != nil
			//更新正在进行的事件，解释完后 再设置事件页 看是否有合适条件的触发新事件解释
			interpreter=battleScene.interpreter;
			interpreter.update();
			if (interpreter.running==false){
				setEvents();
				interpreter.run(); 
				trace(interpreter+"设置事件"+interpreter.running)
			}
			// wait_for_message
			// process_action if $game_troop.forcing_battler != nil
			//  return unless $game_troop.interpreter.running?
			//	 update_basic
		//	TweenLite.delayedCall(5,battleScene.resume);
			trace(interpreter+"执行事件步进 更新"+interpreter.running)
			
			
		}
		
		private function setEvents():void{
		//	return if interpreter.running?
		//	return if interpreter.setup_reserved_common_event
			var pages:Array=[];
			pages=battleScene.scripts;
			for each (var page:EventPage in pages){
				//next unless conditions_met?(page)
				if (page.condition){
					interpreter.setup(page)
					//event_flags[page] = true if page.span <= 1
					return
				}
					
			}
			
		}
	}
}