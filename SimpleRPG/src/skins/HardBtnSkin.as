package skins
{

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.text.TextFormatAlign;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	
	/**
	 * 按钮默认皮肤
	 * @author dom
	 */
	public class HardBtnSkin extends BaseSkin
	{
		
		public var borderColors:Array = [0x000000,0x000000,0x000000];
		public var radius:Number=6;
		public function HardBtnSkin()
		{
			super();
			states = ["up","over","down","disabled"];
			this.minHeight = 21;
			this.minWidth = 21;
		}
		
		public var labelDisplay:Label;
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			labelDisplay = new Label();
			labelDisplay.textAlign = TextFormatAlign.CENTER;
			labelDisplay.verticalAlign = VerticalAlign.MIDDLE;
			labelDisplay.maxDisplayedLines = 1;
			labelDisplay.left = 5;
			labelDisplay.right = 5;
			labelDisplay.top = 3;
			labelDisplay.bottom = 3;
			addElement(labelDisplay);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			graphics.clear();
			var textColor:uint;
			switch (currentState)
			{			
				case "up":
				case "disabled":
					drawCurrentState(0,0,w,h,borderColors[0],bottomLineColors[0],
						[0xffcc66,0xff6600],radius);
					textColor = themeColors[0];
					break;
				case "over":
					drawCurrentState(0,0,w,h,borderColors[1],bottomLineColors[1],
						0xffff66,radius);
					textColor = themeColors[1];
					break;
				case "down":
					drawCurrentState(0,0,w,h,borderColors[2],bottomLineColors[2],
						0xff9966,radius);
					textColor = themeColors[1];
					break;
			}
			if(labelDisplay)
			{
				labelDisplay.textColor = textColor;
				//labelDisplay.applyTextFormatNow();
				labelDisplay.filters = (currentState=="over"||currentState=="down")?textOverFilter:null;
			}
			this.alpha = currentState=="disabled"?0.5:1;
		}
		
		override public function drawCurrentState(x:Number,y:Number,w:Number,h:Number,borderColor:uint,
										 bottomLineColor:uint,fillColors:Object,cornerRadius:Object=null,g:Graphics=null):void
		{
			var crr:Object = cornerRadius;
			var crr1:Object;
			if(cornerRadius==null||cornerRadius is Number)
			{
				crr1 = cornerRadius==null?0:Number(cornerRadius)-1;
				if(crr1<0)
					crr1 = 0;
				crr1 = {tl:crr1,tr:crr1,
					bl:crr1,br:crr1};
			}
			else
			{
				crr1 = {tl:Math.max(0,crr.tl-1),tr:Math.max(0,crr.tr-1),
					bl:Math.max(0,crr.bl-1),br:Math.max(0,crr.br-1)};
			}
			var r:Number=Number(cornerRadius);
			//绘制边框
			drawRoundRect(
				x, y, w, h, r,
				borderColor, 1); 
			//绘制填充
			drawRoundRect(
				x+1, y+1, w - 2, h - 2, r-1,
				0xffffff, 1); 
			
			
			drawRoundRect(
				x+2, y+2, w-4, h-4, r-2,
				borderColor, 1); 
			//绘制填充
			drawRoundRect(
				x+3, y+3, w - 6, h - 6, r-3,
				fillColors, 1,
				verticalGradientMatrix(x, y, w - 8, h - 8),GradientType.LINEAR,[125,200],null,g); 
			
		}
		
		
		
	}
}