package
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	import rpg.events.AppEvent;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	
	
	public class AppContext extends Context
	{
		public function AppContext()
		{
			super();
			
			
		}
		
		public function run(view:Sprite):void{
			this.install(MVCSBundle);
			this.configure(AppConfig);
			this.configure(new ContextView(view));
			this.initialize();
			
			var dispatcher:IEventDispatcher=injector.getInstance(IEventDispatcher) as IEventDispatcher 
			dispatcher.dispatchEvent(new AppEvent(AppEvent.STARTUP));
		}
	}
}