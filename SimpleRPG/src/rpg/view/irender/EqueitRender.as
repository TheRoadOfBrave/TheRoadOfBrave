package rpg.view.irender
{
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	import rpg.Cache;
	
	import skins.EqItemSkin;

	public class EqueitRender extends ItemRenderer
	{
		public var img:UIAsset;
		public function EqueitRender()
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