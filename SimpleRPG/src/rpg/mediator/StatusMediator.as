package rpg.mediator
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	import mx.events.CloseEvent;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.managers.DragManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import rpg.model.Actor;
	import rpg.model.Party;
	import rpg.view.StatusWindow;
	import rpg.view.irender.PackItemRender;
	import rpg.vo.EquipItem;
	
	import spark.components.List;
	
	/**
	 * 
	 * @author maikid
	 *人物状态窗口控制 
	 */
	public class StatusMediator extends Mediator
	{
		[Inject]
		public var view:StatusWindow;
		
		public var party:Party;
		
		public function StatusMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			trace("statusWindow added!")
			view.addEventListener("show_equips",showEquipsHandler);
			party=Party.getInstance();
			view.party=party;
			view.roleWnd.actor=party.actors[0]
		//	view.roleWnd.equipList.addEventListener(DragEvent.DRAG_OVER,drapStartHandler);
			view.roleWnd.equipList.addEventListener(DragEvent.DRAG_ENTER,drapEnterHandler);
				view.roleWnd.equipList.addEventListener(DragEvent.DRAG_DROP,dragDropEquipHandler);
			
				view.equipWnd.addEventListener(CloseEvent.CLOSE,closeEqWnd);
			
				
			
				//view.role1.actor=party.actors[0]
//			view.role2.actor=party.actors[1]
//			view.role3.actor=party.actors[2]
		}
		
	
	
	
		override public function onRemove():void
		{
			view.roleWnd.equipList.removeEventListener(DragEvent.DRAG_ENTER,drapEnterHandler);
			view.roleWnd.equipList.removeEventListener(DragEvent.DRAG_DROP,dragDropEquipHandler);
		}
		
		
		/**
		 *lilst自动内部调用不启用事件 
		 * @param event
		 * 
		 */
		protected function drapStartHandler(event:DragEvent):void
		{
			if (event.dragSource==null){
				event.preventDefault();
			}else{
				var dragObj:Vector.<Object>=	event.dragSource.dataForFormat("itemsByIndex") as Vector.<Object>; 
				var item:EquipItem=dragObj[0] as EquipItem;
				//dragObj.pop();
				if (item){
					
				}else{
					event.preventDefault();
				}
			}
			
		}
		
		protected function drapEnterHandler(event:DragEvent):void
		{
			var dragObj:Vector.<Object>=	event.dragSource.dataForFormat("itemsByIndex") as Vector.<Object>; 
			var item:EquipItem=dragObj[0] as EquipItem;
			//dragObj.pop();
			if (item&&event.dragInitiator==view.equipWnd.list){
				var actor:Actor=view.roleWnd.actor;
				trace(item.etype_id+"can equip:"+actor.equippable(item));
				if (actor.equippable(item)){
					//view.roleWnd.eqActive=true;
					DragManager.acceptDragDrop(view.roleWnd.equipList);
				}else{
					//view.roleWnd.eqActive=false;
				}
			}
			
		}
		
		/**
		 *更换装备 
		 * @param event
		 * 
		 */
		protected function dragDropEquipHandler(event:DragEvent):void
		{
			//var  arr:Array=event.dragSource.dataForFormat("itemsByIndex") as Array
			var dragObj:Vector.<Object>=	event.dragSource.dataForFormat("itemsByIndex") as Vector.<Object>; 
			var item:EquipItem=dragObj[0] as EquipItem;
			//dragObj.pop();
			if (item==null&&event.dragInitiator!=view.equipWnd.list) return;
			var oldIndex:int=List(event.dragInitiator).dataProvider.getItemIndex(item);
			
			var actor:Actor=view.roleWnd.actor;
			
				var slot:uint=actor.empty_slot(item.etype_id);
				if (slot>=0){
					actor.change_equip(slot,item);
					view.roleWnd.equipList.dataProvider.setItemAt(item,slot);
					
				}
				//List(event.dragInitiator).dataProvider.removeItemAt(oldIndex);

				view.roleWnd.update();
				event.preventDefault();
			
		}
		
		protected function drapEnterBackHandler(event:DragEvent):void
		{
			var dragObj:Vector.<Object>=	event.dragSource.dataForFormat("itemsByIndex") as Vector.<Object>; 
			var item:EquipItem=dragObj[0] as EquipItem;
			//dragObj.pop();
			if (item&&event.dragInitiator!=view.equipWnd.list){
				DragManager.acceptDragDrop(view.equipWnd.list);
			}
			
		}
		protected function dragDropEquipBackHandler(event:DragEvent):void
		{
			//var  arr:Array=event.dragSource.dataForFormat("itemsByIndex") as Array
			var dragObj:Vector.<Object>=	event.dragSource.dataForFormat("itemsByIndex") as Vector.<Object>; 
			var item:EquipItem=dragObj[0] as EquipItem;
			//dragObj.pop();
			if (item==null||event.dragInitiator==view.equipWnd.list) return;
			view.equipWnd.list.dataProvider.addItem(item);
			var slot:int=view.roleWnd.equipList.dataProvider.getItemIndex(item);
			if (slot>-1)
			view.roleWnd.actor.change_equip(slot,null);
			view.roleWnd.equipList.dataProvider.setItemAt(null,slot);
			//List(event.dragInitiator).dataProvider.removeItemAt(oldIndex);
			//view.roleWnd.equipList.dragMoveEnabled=true;
			view.roleWnd.update();
			event.preventDefault();
			
		}
		protected function showEquipsHandler(event:Event):void
		{
			var list:ArrayList=party.bag.equip_items;
			
			view.showEquips(list);
			if (false==view.equipWnd.list.hasEventListener(DragEvent.DRAG_ENTER)){
				view.equipWnd.list.addEventListener(DragEvent.DRAG_DROP,dragDropEquipBackHandler);
				view.equipWnd.list.addEventListener(DragEvent.DRAG_ENTER,drapEnterBackHandler);
			}
		}
		
		protected function closeEqWnd(event:CloseEvent):void
		{
			view.equipWnd.list.removeEventListener(DragEvent.DRAG_DROP,dragDropEquipBackHandler);
			view.equipWnd.list.removeEventListener(DragEvent.DRAG_ENTER,drapEnterBackHandler);
			
		}		
	}
}