package rpg.command
{
	import org.robotlegs.mvcs.Command;
	
	import rpg.GameMain;
	import rpg.WindowConst;
	import rpg.events.WindowEvent;
	import rpg.manager.WindowManager;
	
	import spark.components.Group;
	
	public class WindowCommand extends Command
	{
		[Inject]
		public var event:WindowEvent
		
		
		public function WindowCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			switch(event.type)
			{
				case WindowEvent.OPEN:
				//	var window:Group=mainView.statusWindow;
				//	PopUpManager.addPopUp(window,mainView.windows,false);
					WindowManager.addWindow(event.window);
					//mainView.windows.addElement(window);
					break;
				case WindowEvent.CLOSE:
					WindowManager.closeAllWindow();
					break;
				default:
					break;
			}
		}
	}
}