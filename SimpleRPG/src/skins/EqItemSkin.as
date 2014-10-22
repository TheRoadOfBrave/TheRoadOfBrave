package skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUI.skins.vector.ItemRendererSkin;
	
	public class EqItemSkin extends ItemRendererSkin
	{
		public var img:UIAsset;
		public var lb:Label;
		public function EqItemSkin()
		{
			super();
			height=30;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			img=new UIAsset;
			
			img.x=5;
			img.y=4;
		//	lb.textColor=0xFFFFFF;
//			filter=new GlowFilter(0x333333,1,4,4,10);
//			img.filters=[filter]
//			lb.filters=[filter];
			labelDisplay.textAlign = TextFormatAlign.LEFT;
			labelDisplay.left=50;
			addElement(img);
		
			
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			//drawRoundRect(0,0,200,25,5,0xAB8000);
			drawRoundRect(
				0, 0, w, h - 1, 4,
				0xAB8000, 1,	verticalGradientMatrix(0, 0, w, h - 1)); 
		}
		
	}
}