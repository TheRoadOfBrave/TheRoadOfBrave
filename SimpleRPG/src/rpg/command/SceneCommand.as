package rpg.command
{
	import org.robotlegs.mvcs.Command;
	
	import rpg.GameMain;
	import rpg.WindowConst;
	import rpg.events.SceneEvent;
	import rpg.events.WindowEvent;
	import rpg.manager.WindowManager;
	
	import spark.components.Group;
	
	public class SceneCommand extends Command
	{
		[Inject]
		public var event:SceneEvent
		
		
		public function SceneCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			switch(event.type)
			{
				case SceneEvent.GOTO:
					WindowManager.closeAllWindow();
					break;
				case WindowEvent.CLOSE:
					break;
				default:
					break;
			}
		}
	}
}