package rpg.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.Application;
	import rpg.BattleScene;
	import rpg.DataBase;
	import rpg.WindowConst;
	import rpg.events.DialogEvent;
	import rpg.events.ItemEvent;
	import rpg.events.MapEvent;
	import rpg.events.SceneEvent;
	import rpg.manager.WindowManager;
	import rpg.model.Party;
	
	/**
	 *协调游戏主体各场景部分 
	 * @author maikid
	 * 
	 */
	public class GameMediator extends Mediator
	{
		
		[Inject]
		public var battleScene:BattleScene;
	
		
		
		/**
		 * 游戏主窗体
		 */
		[Inject]
		public var view:Application;
		
		private var db:DataBase=DataBase.getInstance();
		public function GameMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			//初始化最后创建的Mediator
		//	eventMap.mapListener( eventDispatcher, GameServerCommand.LOGINED, loginHandler );
			eventMap.mapListener( eventDispatcher, SceneEvent.GOTO, gotoSceneHandler );
			eventMap.mapListener( eventDispatcher, DialogEvent.SHOW, showDialogHandler );
			eventMap.mapListener( eventDispatcher, ItemEvent.USE, useItemHandler );
		//	eventMap.mapListener( eventDispatcher, MapEvent.TRANSFER, transferHandler );
			
			view.dialog.addEventListener(MouseEvent.CLICK,showNextDialog);
			view.addEventListener(Event.ENTER_FRAME,updateHandler);
			
			view.battleView=battleScene.view;
			
			//游戏MASTER设置
			view.setup();
			//转到第一个场景
			dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
			
		}
		
		protected function updateHandler(event:Event):void
		{
			if (view.needDealMap){

			}
			
		}		
	
		
		private function transferHandler(event:MapEvent):void
		{
			if (Party.getInstance()){
				//return if $game_party.in_battle
			}
			var params:Array=event.data
			var new_map_id:int;
			//Fiber.yield while $game_player.transfer? || $game_message.visible
			if (params[0] == 0  ) {
				new_map_id = params[1]
				//x = @params[2]
				//y = @params[3]
			}else{
				//map_id = $game_variables[@params[1]]
				//x = $game_variables[@params[2]]
				//y = $game_variables[@params[3]]
			}
			
		}
		
		protected function showNextDialog(event:MouseEvent):void
		{
			if (view.dialog.isEnd){
				view.dialog.visible=false;
			}
		}
		
		private function showDialogHandler(event:DialogEvent):void
		{
			view.dialog.visible=true;
			view.dialog.text=event.text;
			//view.dialog.setIcon(event.params[1],event.params[2]);
			
		}		
	
		
		private function gotoSceneHandler(event:SceneEvent):void
		{
			
			switch(event.type)
			{
				case SceneEvent.GOTO:
					gotoScene(event.scene);
					break;
				default:
					break;
			}
			
			
		}
		
		/**
		 *场景切换 
		 * @param scene
		 * 
		 */
		private function gotoScene(scene:String):void{
			WindowManager.closeAllWindow();
			view.scene=scene;
			view.gotoScene(scene)
			switch(scene)
			{
				case WindowConst.SCENE_BATTLE:
					//有的视图组件需要添加入舞台才会实例化，添加后调用战斗场景设置
					battleScene.setup();
				
					break;
				case WindowConst.SCENE_CITY:
					break;
				case WindowConst.SCENE_MAP:
					break;
				case WindowConst.SCENE_ZONE:
					//view.battleGroup.addElement(battleScene.view);
					var party:Party=Party.getInstance()
					battleScene.dispose();
					battleScene.setupParty(party);
					
					battleScene.setup();
					
					break;
				default:
					break;
			}
			
		}
		
		private function useItemHandler(event:ItemEvent):void
		{
			if (view.scene==WindowConst.SCENE_BATTLE||view.scene==WindowConst.SCENE_BATTLE){
				//battleScene.view.actorWindows.update();
			}
			
		}
		
		
	}
}