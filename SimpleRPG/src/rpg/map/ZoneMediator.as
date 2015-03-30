package rpg.map
{
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.Code;
	import rpg.DataBase;
	import rpg.GameConst;
	import rpg.WindowConst;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.events.MapEvent;
	import rpg.events.SceneEvent;
	import rpg.model.MonsterTroop;
	import rpg.model.Troop;
	import rpg.vo.IPackItem;
	
	public class ZoneMediator extends Mediator
	{
		[Inject]
		public var model:ZoneModel;
		[Inject]
		public var view:ZoneView;
		
		private var db:DataBase;
		public function ZoneMediator()
		{
			super();
			db=DataBase.getInstance();
		}
		
		
		override public function initialize():void	{
			eventMap.mapListener( eventDispatcher, BattleEvent.FINISH, battleFinishHandler );
			eventMap.mapListener( eventDispatcher, MapEvent.VISIT, scriptHandler );
			addViewListener("go",goHandler);
			addViewListener("arrive",arriveHandler);
		}
		
		private function scriptHandler(event:MapEvent):void
		{
			switch(event.objType)
			{
				case Code.CMD_CHEST:
				{
					
					var params:Array=event.data;
					var goods:Array=[];
					for (var i:int=0;i<params.length;i++){
						var obj:Object=params[i]
						var item:IPackItem;
						if (obj.type==1){
							item=db.getItem(obj.id);
							item.num=obj.n;
							item.price=obj.price;
							goods.push(item);
						}else if (obj.type==2){
							item=db.getWeapon(obj.id);
							item.num=obj.n;
							item.price=obj.price;
							goods.push(item);
						}
					}
						view.showChest(goods);
					
				
					break;
				}
				case Code.CMD_INN:
				{
					var gold:int=event.data[0];
					view.showInn(gold);
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function battleFinishHandler(event:BattleEvent):void
		{
			var result:int=event.kind 
			dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
			
			if (result==GameConst.WIN){
				var troop:MonsterTroop=event.troop;
				var gold:uint=troop.gold_total();
				var exp:uint=troop.exp_total();
				var items:Array=troop.make_drop_items();
				view.moveable=true;
			}else if (result==GameConst.LOSE){
				dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
				
			}else{
				view.moveable=true;
			}
			
			//	model.interpreter.next();
			
			
		}
		
		private function goHandler(event:Event):void
		{
				model.go();
				view.go(Random.integet(10),false);
		}		
		
		private function arriveHandler(event:Event):void
		{
		/*	var cmdEvent:ScriptCmdEvent=new ScriptCmdEvent(ScriptCmdEvent.EXE_BATTLE_COMMAND);
			cmdEvent.code=301
			var monsterId:int=Random.integet(5)
			if (monsterId==4) monsterId=1;
			cmdEvent.params=[0,monsterId]
			dispatch(cmdEvent);*/
			
			model.setup_starting_event();
		}
			
			
			
	}
}