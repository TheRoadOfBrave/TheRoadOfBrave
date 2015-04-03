package skins
{
	import flash.display.Graphics;
	import flash.text.TextFormatAlign;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.RectangularDropShadow;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	/**
	 * Panel默认皮肤
	 * @author dom
	 */
	public class GPanelSkin extends BaseSkin
	{
		public function GPanelSkin()
		{
			super();
			this.minHeight = 60;
			this.minWidth = 80;
		}
		
		public var titleDisplay:Label;
		
		public var contentGroup:Group;
		private var cornerRadius:Number=8;
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			var dropShadow:RectangularDropShadow = new RectangularDropShadow();
			dropShadow.tlRadius=dropShadow.tlRadius=dropShadow.trRadius=dropShadow.blRadius=dropShadow.brRadius = cornerRadius;
			dropShadow.blurX = 20;
			dropShadow.blurY = 20;
			dropShadow.alpha = 0.45;
			dropShadow.distance = 7;
			dropShadow.angle = 90;
			dropShadow.color = 0x000000;
			dropShadow.left = 0;
			dropShadow.top = 0;
			dropShadow.right = 0;
			dropShadow.bottom = 0;
			addElement(dropShadow);
			
			contentGroup = new Group();
			contentGroup.top = 18;
			contentGroup.left = 1;
			contentGroup.right = 1;
			contentGroup.bottom = 1;
			contentGroup.clipAndEnableScrolling = true;
			addElement(contentGroup);
			
			titleDisplay = new Label();
			titleDisplay.maxDisplayedLines = 1;
			titleDisplay.left = 5;
			titleDisplay.right = 20;
			titleDisplay.top = 2;
			titleDisplay.verticalAlign = VerticalAlign.TOP;
			titleDisplay.textAlign = TextFormatAlign.LEFT;
			titleDisplay.size=11;
			addElement(titleDisplay);
			this.graphics.clear();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayList(w:Number,h:Number):void
		{
			super.updateDisplayList(w, h);
			
			graphics.clear();
			var g:Graphics = graphics;
//			g.lineStyle(1,0x000000);
//			g.beginFill(0xFFFFFF);
//			g.drawRoundRect(0,0,w,h,15,15);
//			g.endFill();
			g.lineStyle();
			drawRoundRect(
				1, 1, w-1, 20,{tl:6,tr:6,bl:0,br:0},
				[0xccaa00,0xaa3300], 1,
				verticalGradientMatrix(1, 1, w - 1,28 )); 
			drawLine(1,17,w,17,0x663300);
			drawLine(1,18,w,18,0xeeeeee);
			this.alpha = currentState=="disabled"?0.5:1;
		}
	}
}