package rpg.city
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.Code;
	import rpg.WindowConst;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.events.GameEvent;
	import rpg.events.MapEvent;
	import rpg.events.SceneEvent;
	import rpg.events.WindowEvent;
	import rpg.model.BattleModel;
	import rpg.model.GameData;
	import rpg.model.Party;
	
	
	public class CityMediator extends Mediator
	{
		[Inject]
		public var view:CityView;
		
		private var party:Party;
		
		
		public function CityMediator()
		{
			super();
		}
		
		override public function initialize():void	{
			
			//model.setup_events();
			eventMap.mapListener( eventDispatcher, SceneEvent.GOTO, enterSceneHandler );

			eventMap.mapListener( eventDispatcher, SceneEvent.ACTION, actionHandler );
//			eventMap.mapListener( eventDispatcher, BattleEvent.FINISH, battleFinishHandler );
//			eventMap.mapListener( eventDispatcher, SceneEvent.GO_FORWARD, goForwardHandler );
//			eventMap.mapListener( eventDispatcher, SceneEvent.BACK_HOME, backHomeHandler );
//			
			
			view.addEventListener(MouseEvent.CLICK,click);
			
			//城市视图加入后 ，游戏初始化完成 ，跳转到 第一个场景
		//	dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
			
		}
		
		override public function destroy():void
		{
			
		}
		
		private function enterSceneHandler(event:SceneEvent):void
		{
			
			switch(event.type)
			{
				case SceneEvent.GOTO:
					if (event.scene==WindowConst.SCENE_CITY){

					}
					break;
				default:
					break;
			}
			
			
		}
		
		
		private function battleFinishHandler(event:BattleEvent):void
		{
			dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
		//	model.interpreter.next();
			
			
		}
		
		private function actionHandler(event:SceneEvent):void
		{
			var battle:BattleModel=BattleModel.getInstance();
			if (battle.in_battle){
				switch (event.action){
					case 1:
						fight();
						break;
					case 2:
						runaway();
						break;
					case 3:
						break;
				}
			}else{
				switch (event.action){
					case 1:
						break;
					case 2:
						rest();
						break;
					case 3:
						backHome();
						break;
				}
			
			}
			
		}
		
		
		
		private function runaway():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function fight():void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		private function rest():void
		{
			party=Party.getInstance();
			GameData.getInstance().day++;
			if (party.food>0){
				party.food--;
				party.recover_all();
			}
		}
		/**
		 *回城 
		 * 
		 */
		private function backHome():void
		{
			dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
			var arr:Array=[0,1]
			
			dispatch(new MapEvent(MapEvent.TRANSFER,arr));
		}
		
		
		
		protected function exeScript(event:ScriptCmdEvent):void
		{
			dispatch(event);
		}
	
		
		
		protected function click(event:MouseEvent):void
		{
			var btn:Button=event.target as Button;
			if (btn){
				switch(btn.id)
				{
					case "goBtn":
					/*	model.needRefresh=true;
					model.eventObjs[3].start();
						model.update();*/
						
						
						dispatch(new GameEvent(GameEvent.START_JOURNEY));
						break;
					case "shopBtn":
						var goods:Array=[];
						var cmd:ScriptCmdEvent=new ScriptCmdEvent(ScriptCmdEvent.EXE_COMMAND);
						cmd.code=Code.CMD_SHOP;
						cmd.params[0]={type:1,id:1,n:1,price:100}
						cmd.params[1]={type:1,id:3,n:1,price:102}
						cmd.params[2]={type:1,id:2,n:1,price:103}
						cmd.params[3]={type:2,id:2,n:1,price:103}
						cmd.params[4]={type:2,id:1,n:1,price:103}
						cmd.params[5]={type:2,id:502,n:1,price:103}
						cmd.yield=true;
						
						dispatch(cmd);
					//	dispatch(new WindowEvent(WindowEvent.OPEN,WindowConst.SHOP));
						break;
					
					
					
					
					default:
						;
					
				}
			}
		}
		
		
		
		
	}
}