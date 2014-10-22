package rpg.view.irender
{
	import flash.display.Graphics;
	import flash.events.AsyncErrorEvent;
	import flash.filters.GlowFilter;
	
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	import rpg.Cache;
	
	import skins.EqItemSkin;

	public class EqueitRender extends ItemRenderer
	{
		public var img:UIAsset;
		public var lb:Label;
		private var filter:GlowFilter;
		public function EqueitRender()
		{
			super();
			this.skinName=EqItemSkin;
//			img=new UIAsset;
//			lb=new Label;
//			
//			img.x=5;
//			img.y=4;
//			lb.x=50;
//			lb.y=4;
//			lb.textColor=0xFFFFFF;
//			filter=new GlowFilter(0x333333,1,4,4,10);
//			img.filters=[filter]
//			lb.filters=[filter];
			
		//	DisplayUtil.drawRect(this.graphics,0,0,100,30,0xAb8000,5);
		//	DisplayUtil.drawRect(img.graphics,0,0,24,24,0xEEEEEE,5);
			
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