package skins
{
	import flash.display.GradientType;
	
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.DataGroup;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.skins.VectorSkin;
	
	import rpg.view.irender.RenderBase;
	
	public class EqListSkin extends VectorSkin
	{
		public function EqListSkin()
		{
			super();
		}
		
		public var dataGroup:DataGroup;
		
		public var scroller:Scroller;
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			dataGroup = new DataGroup();
			dataGroup.itemRenderer = RenderBase;
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 10;
			layout.horizontalAlign = HorizontalAlign.CONTENT_JUSTIFY;
			dataGroup.layout = layout;
			
			scroller = new Scroller();
			scroller.left = 0;
			scroller.top = 0;
			scroller.right = 0;
			scroller.bottom = 0;
			scroller.minViewportInset = 1;
			scroller.viewport = dataGroup;
			addElement(scroller);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayList(w:Number,h:Number):void
		{
			super.updateDisplayList(w,h);
			graphics.clear();
			//DisplayUtil.drawRect(this.graphics,0,0,100,30,0xAb8000,5);
			this.alpha = currentState=="disabled"?0.5:1;
		}
		
		
		
	}
}