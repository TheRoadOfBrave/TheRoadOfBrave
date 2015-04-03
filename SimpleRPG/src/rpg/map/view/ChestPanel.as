package rpg.map.view
{
	import flash.events.Event;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.components.Panel;
	
	import rpg.events.ItemEvent;
	import rpg.vo.IPackItem;
	
	import skins.ChestItemSkin;
	import skins.GPanelSkin;
	
	public final class ChestPanel extends Panel
	{
		private var _items:Array;
		public var itemList:List;
		public function ChestPanel()
		{
			super();
			title="宝 箱"
				
			itemList=new List;
			itemList.width=220;
			itemList.height=120;
			itemList.itemRenderer=ChestRender;
			itemList.itemRendererSkinName=ChestItemSkin;
			itemList.addEventListener(ItemEvent.GET,getItemHandler);
			//itemList.top=20;
			skinName=GPanelSkin;
			addElement(itemList);
		
		}
		
		protected function getItemHandler(event:ItemEvent):void
		{
			var item:IPackItem=event.item;
			var arrc:ArrayCollection=itemList.dataProvider as ArrayCollection;
			//var index:int=arrc.getItemIndex(item);
			//arrc.removeItemAt(index);
			arrc.replaceItemAt(null,itemList.selectedIndex);
			//arrc.removeItemAt(itemList.selectedIndex);
		}
		
		public function get items():Array
		{
			return _items;
		}

		public function set items(arr:Array):void
		{
			itemList.dataProvider=new ArrayCollection(arr);
		}

	}
}