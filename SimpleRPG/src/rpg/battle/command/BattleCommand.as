package rpg.battle.command
{
	
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.BattleScene;
	import rpg.DataBase;
	import rpg.WindowConst;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.events.SceneEvent;
	import rpg.model.GameInterpreter;
	import rpg.model.MonsterTroop;
	import rpg.model.Party;
	
	public class BattleCommand extends Command
	{
		[Inject]
		public var battleScene:BattleScene;
		
		[Inject]
		public var event:ScriptCmdEvent;
		public var db:DataBase=DataBase.getInstance();
		
		private var inter:GameInterpreter;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		public function BattleCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//trace(inter+"执行命令"+inter.running)
			trace(event.code,event.params,"执行战斗相关脚本命令开始");		
			if (event.scene==0){
				//inter=city.interpreter;
			}else{
				inter=battleScene.interpreter;
			}
			var params:Array=event.params;
			switch (event.code){
				case 301:
					enterBattle(event.params);
					break;
				
				case 339: //强制战斗行动
					forceAction(event.params);
					break;
			}
			
		}
		
		/**
		 *进入战斗场景 
		 * 
		 */
		private function enterBattle(params:Array):void
		{
			var party:Party=Party.getInstance();
//			 if (party.in_battle){
//				 return
//			 }
			var troop_id:uint;
			if (params[0] == 0 ){
				// 直接指定
				troop_id = params[1]
			}else if (params[0] == 1  ){
				// 变量指定
	//		troop_id = $game_variables[params[1]]
				
			}else{
				//地图指定的敌群
	//		troop_id = $game_player.make_encounter_troop_id
			}
			
			if (troop_id>0){
	//			BattleManager.setup(troop_id, @params[2], @params[3])
//				BattleManager.event_proc = Proc.new {|n| @branch[@indent] = n }
		//		$game_player.make_encounter_count
				setup(troop_id)
				dispatcher.dispatchEvent(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_BATTLE));
				
			}
		}
		
		public function setup(id:uint):void{
			var party:Party=Party.getInstance();
			var cpuTroop:MonsterTroop=new MonsterTroop();
			cpuTroop.setMonster(id);
		//	cpuTroop.setup(troopId);
			
			
			battleScene.setupParty(party);
			battleScene.setupTroop(cpuTroop);
			
		}
		
		/**
		 *强制行动命令 
		 * @param params
		 * 
		 */
		private function forceAction(params:Array):void
		{
//			iterate_battler(@params[0], @params[1]) do |battler|
//				next if battler.death_state?
//					battler.force_action(@params[2], @params[3])
//				BattleManager.force_action(battler)
//				Fiber.yield while BattleManager.action_forced?
//					end
			//var battler:Battler=
			battleScene.force_action(params[0],params[1],params[2],params[3]);
			//next()
		}
		
		
		
	}
}