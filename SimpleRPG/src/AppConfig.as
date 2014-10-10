package
{
	import rpg.events.AppEvent;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	
	import rpg.Application;
	import rpg.BattleScene;
	import rpg.battle.command.BattleCommand;
	import rpg.battle.command.ProcessBattleEventCommand;
	import rpg.battle.command.ResumeBattleCommand;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.city.CityMediator;
	import rpg.city.CityView;
	import rpg.command.InitDataCommand;
	import rpg.command.StartupCommand;
	import rpg.mediator.GameMediator;
	import rpg.command.ScriptCommand;
	import rpg.command.ShopCommand;
	
	
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var logger:ILogger;
		
		public function AppConfig()
		{
		}
		
		public function configure():void
		{
			
			models();
			mediators();
			commands();
			logger.info("配置APP logger in AppConfig");
			
		}
		
		private function models():void
		{
		//	injector.map(AppModel).toSingleton(AppModel);
			injector.map(BattleScene).asSingleton();
		}
		
		private function mediators():void
		{
			mediatorMap.map(Application).toMediator(GameMediator);
			mediatorMap.map(CityView).toMediator(CityMediator);
		}
		
		private function commands():void
		{
			commandMap.map(AppEvent.STARTUP, AppEvent).toCommand(StartupCommand).once();
			commandMap.map(AppEvent.STARTUP_COMPLETE, AppEvent).toCommand(InitDataCommand).once();
			
			
			commandMap.map(  BattleEvent.PROCESS_EVENT, BattleEvent).toCommand(ProcessBattleEventCommand);
			commandMap.map(  BattleEvent.RESUME_BATTLE, BattleEvent).toCommand(ResumeBattleCommand);
			
			
			//游戏脚本相关命令
			commandMap.map( ScriptCmdEvent.EXE_COMMAND, ScriptCmdEvent).toCommand(ScriptCommand);
			commandMap.map( ScriptCmdEvent.EXE_BATTLE_COMMAND, ScriptCmdEvent).toCommand(BattleCommand);
			//commandMap.map( ScriptCmdEvent.EXE_BATTLE_COMMAND, ScriptCmdEvent).toCommand(BattleCommand);
			commandMap.map( ScriptCmdEvent.EXE_SHOP_COMMAND, ScriptCmdEvent).toCommand(BattleCommand);
			
			
		}
		
	}
}