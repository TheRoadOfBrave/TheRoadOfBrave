package rpg.shop.view
{
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	import rpg.Cache;
	import rpg.events.ItemEvent;
	import rpg.vo.BaseItem;
	
	import skins.EqItemSkin;
	import skins.ShopItemSkin;
	
	public class ItemRender extends ItemRenderer
	{
		public var img:UIAsset;
		public  var btn:Button;
		public function ItemRender()
		{
			super();
			this.skinName=ShopItemSkin;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			btn.addEventListener(MouseEvent.CLICK,clickBtn);
		}
		
		protected function clickBtn(event:MouseEvent):void
		{
		//	data.has=true;
			dispatchEvent(new ItemEvent(ItemEvent.BUY,data.item,true));
		}
		
		override protected function dataChanged():void
		{
			if (data){
				var item:BaseItem=data.item;
				var has:Boolean=data.has;
				img.skinName=Cache.getIcon(item.icon_index);
				label=item.name;
				if (has==false){
					btn.visible=true;
				}else{
					btn.visible=false;
				}
			}
		}
		
		
	}
}