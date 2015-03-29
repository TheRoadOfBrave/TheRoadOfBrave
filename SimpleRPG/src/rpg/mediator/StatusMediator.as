package rpg.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.Application;
	import rpg.WindowConst;
	import rpg.events.DialogEvent;
	import rpg.events.GameEvent;
	import rpg.events.ItemEvent;
	import rpg.events.SceneEvent;
	import rpg.model.Party;
	import rpg.view.StatusPanel;
	import rpg.view.irender.EqueitRender;
	import rpg.vo.EquipItem;
	
	public class StatusMediator extends Mediator
	{
		[Inject]
		public var view:StatusPanel;
		
		private var party:Party;
		public function StatusMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
//			eventMap.mapListener( eventDispatcher, SceneEvent.GOTO, gotoSceneHandler );
//			eventMap.mapListener( eventDispatcher, DialogEvent.SHOW, showDialogHandler );
//			eventMap.mapListener( eventDispatcher, ItemEvent.USE, useItemHandler );
			eventMap.mapListener( eventDispatcher, GameEvent.CHANGE_EQUIP,changeEquip );
			//	eventMap.mapListener( eventDispatcher, MapEvent.TRANSFER, transferHandler );
			
			
			//游戏MASTER设置
			party=Party.getInstance();
			
		}
		
		private function changeEquip(event:GameEvent):void
		{
			var eq:EquipItem=event.data as EquipItem;
			view.changeEquipt(eq);
			view.gold=party.gold;
		}
		
		
	}
}