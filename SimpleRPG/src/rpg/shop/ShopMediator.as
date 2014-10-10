package rpg.shop
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	
	
	import rpg.DataBase;
	import rpg.bag.view.BagView;
	import rpg.events.ItemEvent;
	import rpg.model.Party;
	import rpg.shop.view.ShopView;
	import rpg.vo.BaseItem;
	import rpg.vo.EquipItem;
	import rpg.vo.IPackItem;
	import rpg.vo.Item;
	import rpg.vo.PackVo;
	
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
		
		override public function onRegister():void
		{
			party=Party.getInstance();
			db=DataBase.getInstance();
			var item:Item=db.getItem(1);
			var list:ArrayList=new ArrayList(model.goods);
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
			
			view.dp=list;
			view.gold_lb.text=party.gold.toString();
			view.list.addEventListener(ItemEvent.BUY,buyHandler);
			
			//view.party=party;
		}
		
		
		override public function onRemove():void
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
			view.gold_lb.text=party.gold.toString();
		}
		
		private function clone():IPackItem
		{
			// TODO Auto Generated method stub
			return null;
		}
	}
}