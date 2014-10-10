package rpg.command
{
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.events.CloseEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.BattleScene;
	import rpg.DataBase;
	import rpg.WindowConst;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.events.DialogEvent;
	import rpg.events.MapEvent;
	import rpg.events.SceneEvent;
	import rpg.model.GameInterpreter;
	
	public class ScriptCommand extends Command
	{
		
		
		[Inject]
		public var event:ScriptCmdEvent;
		
		[Inject]
		public var battleScene:BattleScene;
		
		public var db:DataBase=DataBase.getInstance();
		
		private var inter:GameInterpreter;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		public function ScriptCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var cmdEvent:ScriptCmdEvent=dealEvent(event);
			if (cmdEvent){
				//转发特定事件, 专门的command处理
				dispatch(cmdEvent);
				return;
			}
			
			if (event.scene==0){

			}else{
				inter=battleScene.interpreter;
			}
			
			switch (event.code){
				case 1:
					var alert:Alert=Alert.show(event.params[0],event.code.toString());
					alert.y=50;
					break;
				
				case 2:
					//Alert.show(event.params[0],event.code.toString(),Alert.YES|Alert.NO|Alert.NONMODAL,null,close);
					break;
				case 101:
					//显示文本
					dispatch(new DialogEvent(DialogEvent.SHOW,event.params[0],event.params));
					break;
				case 201:
					//场所移动 地图数据切换 视图变更交给360 场景移动
					dispatch(new MapEvent(MapEvent.TRANSFER,event.params));
					break;
				case 214:
					
					break;
				case 360:
					if(event.params[0]==0){
						dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
					}else{
						dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_MAP));
					}
					//dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
					
					break;
			}
		}
		
		private function dispatch(event:Event):void{
			dispatcher.dispatchEvent(event);
		}
		
		private function close(event:CloseEvent):void
		{
			if (event.detail==Alert.FIRST_BUTTON){
				//inter.index=1;
			}else{
				inter.index=3
			}
		}
		
		
		/**
		 *根据事件CODE 决定是否生成新的 特定类型命令事件 
		 * @param evt
		 * @return 
		 * 
		 */
		private function dealEvent(evt:ScriptCmdEvent):ScriptCmdEvent{
			var cmdEvent:ScriptCmdEvent
			switch (evt.code){
				case 1:
					break;
				
				case 2:
					break;
				case 301: case 339:
					cmdEvent=evt.newTypeEvent(ScriptCmdEvent.EXE_BATTLE_COMMAND);
					break;
				case 302:
					cmdEvent=evt.newTypeEvent(ScriptCmdEvent.EXE_SHOP_COMMAND);
					break;
			}
			
			
			return cmdEvent;
		}
	}
}