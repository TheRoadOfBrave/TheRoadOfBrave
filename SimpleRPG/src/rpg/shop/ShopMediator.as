package rpg.shop
{
	
	
	
	import org.flexlite.domUI.collections.ArrayCollection;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import rpg.DataBase;
	import rpg.events.ItemEvent;
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
			var list:ArrayCollection=new ArrayCollection(model.goods);
//			item.num=1
//			list.addItem(item);
//			var item:Item=db.getItem(2)
//			item.num=1
//			list.addItem(item);
//			var item:Item=db.getItem(3);
//			item.num=1
//			list.addItem(item);
//			var item:Item=db.getItem(4);
//			item.num=1
//			list.addItem(item);
//			
			var eq:EquipItem=db.getWeapon(1);
			item.num=1
			list.addItem(eq);
			var eq:EquipItem=db.getWeapon(2);
			item.num=1
			list.addItem(eq);
			var eq:EquipItem=db.getWeapon(3);
			item.num=1
			list.addItem(eq);
//			var eq:EquipItem=db.getWeapon(300);
//			item.num=1
//			list.addItem(eq);
//			var eq:EquipItem=db.getWeapon(401);
//			item.num=1
//			list.addItem(eq);
//			var eq:EquipItem=db.getWeapon(502);
//			item.num=1
//			list.addItem(eq);
//			var eq:EquipItem=db.getWeapon(600);
//			item.num=1
//			list.addItem(eq);
			var eq:EquipItem=db.getWeapon(701);
			item.num=1
			list.addItem(eq);
//			var eq:EquipItem=db.getWeapon(901);
//			item.num=1
//			list.addItem(eq);
			
			view.dpArr=list;
			view.dpArr.refresh();
			view.list.dataProvider=view.dpArr;
			view.list.addEventListener(ItemEvent.BUY,buyHandler);
			
			//view.party=party;
		}
		
		
		override public function destroy():void
		{
			view.list.removeEventListener(ItemEvent.BUY,buyHandler);
		}
		
		
		protected function buyHandler(event:ItemEvent):void
		{
			var item:IPackItem=event.item;
				if (item is EquipItem){
					item=db.getWeapon(BaseItem(item).id);
				}
			party.gold-=item.price;
			party.gain_item(item,item.num);
		}
		
		private function clone():IPackItem
		{
			// TODO Auto Generated method stub
			return null;
		}
	}
}