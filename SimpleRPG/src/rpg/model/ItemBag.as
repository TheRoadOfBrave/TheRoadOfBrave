package rpg.model
{
	
	import org.flexlite.domUI.collections.ArrayCollection;
	
	import rpg.DataBase;
	import rpg.vo.EquipItem;
	import rpg.vo.IPackItem;
	import rpg.vo.Item;
	
	/**
	 * 
	 * @author maikid
	 *物品包 
	 * 不记录位置 装备按流水号存放 物品按ID存放 物品实例 ，实例中记录数量
	 * 不允许批量丢弃装备 
	 */
	public class ItemBag
	{
		
		public var maxLength:int=10;
		private var db:DataBase
		
		
		private var _items:Object={};
		private var _weapons:Object={};
		private var _armors:Object={};
		public function ItemBag()
		{
			db=DataBase.getInstance();
			init_all_items();
		}
		
		public function get items():ArrayCollection
		{
			var list:ArrayCollection=new ArrayCollection;
			for each (var item:Item in _items){
				list.addItem(item);
			}
			return list;
		}
		public function set itemCon(value:Object):void
		{
			_items=value;
		}
		public function get itemCon():Object
		{
			return _items;
		}

		public function get equip_items():ArrayCollection
		{
			//var arr:Array
			var list:ArrayCollection=new ArrayCollection;
			list.source=weapons.source.concat(armors.source);
		//	list.addAll(weapons)
		//	list.addAll(armors);
			return list;
		}
		
		
		
		
		public function get weapons():ArrayCollection
		{
			var list:ArrayCollection=new ArrayCollection;
			for each (var item:EquipItem in _weapons){
				list.addItem(item);
			}
			return list;
		}


		public function get armors():ArrayCollection
		{
			var list:ArrayCollection=new ArrayCollection;
			for each (var item:EquipItem in _armors){
				list.addItem(item);
			}
			return list;
		}


		/**
		 *初始化所有物品列表 
		 * 
		 */
		public function init_all_items():void{
			_items = {}
			_weapons = {}
			_armors = {}
		}
		
		/**
		 *  获取物品类对应的容器实例
		 * @param item_class
		 * @return 
		 * 
		 */
		public function  item_container(item_class:IPackItem):Object{
			if (item_class is Item)
				return _items  ;
			if (item_class is EquipItem && EquipItem(item_class).isWeapon)
				return _weapons 
			if (item_class is EquipItem && EquipItem(item_class).isArmor)
					return _armors
					
			return null;
		}
		
		//获取物品数量
		public function item_number(item:IPackItem):int{
			var container:Object = item_container(item)
				if (container){
					var obj:IPackItem=container[item.key]
					if (obj)
						return obj.num;
				}
				
			return 0
		}
		
		public function gainItemById(itemId:int,n:int):void{
			var tempItem:Item=db.getItem(itemId);
			gainItem(tempItem,n);
			
		}
		
		public function get max_item_number():uint{
			return 99;
		}
		
		public function gainItem(item:IPackItem,n:int):void{
			var container:Object = item_container(item)
			if (container==null) return ;
			
			/*计算物品增减后的新数量*/
			var last_number:uint = item_number(item)
			var new_number:uint = last_number + n;
			/*取得背包中的物品，
				如果没有此物品，把物品按ID存入 背包
			*/
			
			new_number=Math.max(new_number,0);
			new_number= Math.min(new_number, max_item_number);
			
			//0也包含在内
			if (false && new_number==0){
				delete container[item.key] ;
			}else{
				var obj:IPackItem=container[item.key] 
				if (obj==null){
					obj=item;
					container[item.key]=obj;
				}
				obj.num=new_number;
			}
			
//			if (include_equip && new_number < 0){
//				discard_members_equip(item, -new_number)
//			}
			
		
			
		}
		
		
		//loseItem(item, n)
	}
}