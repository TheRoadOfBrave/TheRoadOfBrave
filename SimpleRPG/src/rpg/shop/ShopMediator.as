package rpg.shop
{
	
	
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Alert;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.DataBase;
	import rpg.events.GameEvent;
	import rpg.events.ItemEvent;
	import rpg.model.Actor;
	import rpg.model.Party;
	import rpg.shop.view.ShopView;
	import rpg.vo.BaseItem;
	import rpg.vo.EquipItem;
	import rpg.vo.IPackItem;
	import rpg.vo.Item;
	
	public class ShopMediator extends Mediator
	{
		[Inject]
		public var model:ShopModel;
		
		[Inject]
		public var view:ShopView;
		public var party:Party;
		public var db:DataBase;
		public function ShopMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			party=Party.getInstance();
			db=DataBase.getInstance();
			var item:Item=db.getItem(1);

		/*	var eq:EquipItem=db.getWeapon(1);
			item.num=1
			list.addItem(eq);
			var eq:EquipItem=db.getWeapon(2);
			item.num=1
			list.addItem(eq);
			var eq:EquipItem=db.getWeapon(3);
			item.num=1
			list.addItem(eq);*/


			view.dpArr=getItemCollection();
			view.dpArr.refresh();
			view.list.dataProvider=view.dpArr;
			view.list.addEventListener(ItemEvent.BUY,buyHandler);
			
			//view.party=party;
		}
		
		private function getItemCollection():ArrayCollection{
			var list:ArrayCollection=new ArrayCollection();
			for (var i:int = 0; i < model.goods.length; i++) 
			{
				var obj:Object={item:model.goods[i],has:false};
				list.addItem(obj);
			}
			
			return list;
		}
		
		
		override public function destroy():void
		{
			view.list.removeEventListener(ItemEvent.BUY,buyHandler);
		}
		
		
		protected function buyHandler(event:ItemEvent):void
		{
			var item:IPackItem=event.item;
			if (party.gold<item.price){
				Alert.show("金钱不足！不能购买");
			}else{
				if (item is EquipItem){
					item=db.getWeapon(BaseItem(item).id);
					var hero:Actor=party.leader;
					var eq:EquipItem=item as EquipItem;
					if(hero.equippable(eq)){
						var slot:uint=hero.empty_slot(eq.etype_id);
						if (slot>=0){
							hero.change_equip(slot,eq);
							
						}
					}
				}
				party.gold-=item.price;
				party.gain_item(item,item.num);
				view.updateItem(item);
				
				dispatch(new GameEvent(GameEvent.CHANGE_EQUIP,item));
			}
				
		}
		
		private function clone():IPackItem
		{
			// TODO Auto Generated method stub
			return null;
		}
	}
}