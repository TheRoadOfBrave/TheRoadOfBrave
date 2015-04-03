package rpg.title
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.WindowConst;
	import rpg.events.AppEvent;
	import rpg.events.GameEvent;
	import rpg.events.SceneEvent;
	import rpg.view.TitleView;
	
	public final class TitleMediator extends Mediator
	{
		[Inject]
		public var view:TitleView;
		
		public function TitleMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			//初始化最后创建的Mediator
		//	eventMap.mapListener( eventDispatcher, SceneEvent.GOTO, gotoSceneHandler );
			eventMap.mapListener( view, GameEvent.START, btnHandler );
			eventMap.mapListener( view, GameEvent.CONTINUE, btnHandler );
			eventMap.mapListener( view, GameEvent.DELETE, btnHandler );
		}
		
		private function btnHandler(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.START:
					dispatch(event);
					break;
				case GameEvent.CONTINUE:
					dispatch(new AppEvent(AppEvent.LOAD));
					break;
				case GameEvent.DELETE:
					dispatch(new AppEvent(AppEvent.SAVE));
					break;
				default:
					break;
				
			}
			
		}
		
	}
}