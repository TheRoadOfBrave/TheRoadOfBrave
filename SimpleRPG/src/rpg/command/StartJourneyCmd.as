package rpg.command
{
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.WindowConst;
	import rpg.events.MapEvent;
	import rpg.events.SceneEvent;
	import rpg.map.ScriptBuilder;
	import rpg.map.ZoneModel;

	public final class StartJourneyCmd extends Command
	{
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var model:ZoneModel;
		
		public function StartJourneyCmd()
		{
		}
		
		override public function execute():void
		{
			model.scripts=ScriptBuilder.getInstance().build();
			
			dispatcher.dispatchEvent(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
			dispatcher.dispatchEvent(new MapEvent(MapEvent.TRANSFER));
		}
	}
}