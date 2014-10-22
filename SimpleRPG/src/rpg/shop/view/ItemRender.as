package rpg.shop.view
{
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	import rpg.Cache;
	
	import skins.EqItemSkin;
	
	public class ItemRender extends ItemRenderer
	{
		public var img:UIAsset;
		public function ItemRender()
		{
			super();
			this.skinName=EqItemSkin;
		}
		
		override protected function dataChanged():void
		{
			if (data){
				img.skinName=Cache.getIcon(data.icon_index);
				label=data.name;
			}
		}
		
		
	}
}