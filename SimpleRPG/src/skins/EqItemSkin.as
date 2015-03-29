package skins
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUI.skins.vector.ItemRendererSkin;
	
	public class EqItemSkin extends ItemRendererSkin
	{
		public var img:UIAsset;
		public var lb:Label;
		public var uibox:UIComponent;
		public function EqItemSkin()
		{
			super();
			this.states.push("change")
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
		
			uibox=new UIComponent;
			addElement(uibox);
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			//drawRoundRect(0,0,200,25,5,0xAB8000);
			graphics.clear();
			drawRoundRect(
				0, 0, w, h - 1, 8,
				0xAB8000, 1,	verticalGradientMatrix(0, 0, w, h - 1)); 
			switch (currentState)
			{			
				case "change":
					drawRoundRect(
						0, 0, w, h - 1, 5,
						0xFF8800, 1,	verticalGradientMatrix(0, 0, w, h - 1)); 
					TweenLite.delayedCall(2,endTween);
					break;
			}
		
			
		}
		
		private function endTween():void
		{
			// TODO Auto Generated method stub
		//	currentState="up"
		}
		private function drawRect(x:Number,y:Number,w:Number,h:Number,c:uint,r:Number=0):void{
			var g:Graphics=uibox.graphics;
			g.beginFill(c,1);
			if (r>0){
				g.drawRoundRect(x,y,w,h,r)
			}else{
				g.drawRect(x,y,w,h);
			}
			g.endFill();
		}
		private var tween:TweenLite
		public function play(bmd2:BitmapData):void
		{
			var bmp1:Bitmap=new Bitmap(bmd);
			var bmp2:Bitmap=new Bitmap(bmd2);
			trace(this.y);
			drawRect(0,0,width,height,0x000000,5);
			this.uibox.addChild(bmp1);
			this.uibox.addChild(bmp2);
			if (tween) tween.kill();
			tween=TweenLite.from(bmp2,0.6,{x:200, y:0,onComplete:complete});
		}
		
		public  function complete():void{
			uibox.graphics.clear();
			DisplayUtil.clear(uibox);
		}
		
		private var bmd:BitmapData;
		public function copy():void
		{
			currentState="up";
			DisplayUtil.clear(uibox);
			commitCurrentState();
			commitProperties();
			bmd=DisplayUtil.captureBitmapData(this);
			
		}
	}
}