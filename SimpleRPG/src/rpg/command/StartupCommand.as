package rpg.command
{
	
	
	
	import flash.events.IEventDispatcher;
	
	import rpg.events.AppEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.WindowConst;
	import rpg.events.SceneEvent;
	
	
	public class StartupCommand extends Command
	{
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		public function StartupCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
//		var interpreter:GameInterpreter=injector.instantiate(GameInterpreter);
//			injector.mapValue(GameInterpreter,interpreter);
		//	injector.mapClass(GameInterpreter,GameInterpreter);
		//	var inter:GameInterpreter=RPG(contextView).gameCenter.interpreter;
		///	RPG(contextView).gameCenter.interpreter=interpreter;
		//	injector.injectInto(interpreter);
			
		//	injector.mapValue(GameMain,RPG(contextView).gameCenter);
			trace("robotlegs 启动!")
			
			//dispatch(new GameEvent(GameEvent.SETUP_LOGGER));
			dispatcher.dispatchEvent(new AppEvent(AppEvent.STARTUP_COMPLETE))
			//
			
		}
	}
}