package skins
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	import org.flexlite.domUI.layouts.VerticalAlign;
	import org.flexlite.domUI.skins.vector.ItemRendererSkin;
	
	public class ItemSkin extends ItemRendererSkin
	{
		public var img:UIAsset;
		public var lb:Label;
		private var filter:GlowFilter;
		public var uibox:UIComponent;
		public var overFilter:BitmapFilter;
		public function ItemSkin()
		{
			super();
			this.states.push("change")
			width=60;
			//height=30;
		
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			img=new UIAsset;
			//img.horizontalCenter=0
			img.x=5;
			img.y=0;
			lb=new Label();
		lb.textColor=0xFFFFFF;
		lb.size=16;
			filter=new GlowFilter(0x333333,1,2,2,10);
			overFilter=new DropShadowFilter(2,90,0,0.6,2,2)
			//overFilter=new GlowFilter(0x996633,1,2,2,10);
//			img.filters=[filter]
			lb.filters=[filter];
			labelDisplay.textAlign = TextFormatAlign.LEFT;
			labelDisplay.top=30;
			labelDisplay.left=0
			labelDisplay.verticalCenter=0
			labelDisplay.filters=[filter];
			labelDisplay.size=12;
			addElementAt(img,0);
			lb.x=40
			lb.top=14;
			lb.text="x16"
			addElement(lb);
			uibox=new UIComponent;
		//	addElement(uibox);
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			this.graphics.clear();
			labelDisplay.textColor=0xffffff;
			labelDisplay.filters=[filter];
			lb.x=labelDisplay.x+labelDisplay.textWidth;
			var g:Graphics = graphics;
			g.clear();
			var textColor:uint;
			switch (currentState)
			{			
				case "up":
				case "disabled":
					filters=[]
					break;
				case "over":
				case "down":
					filters=[filter,overFilter]
					break;
			}
			if(labelDisplay)
			{
			//	labelDisplay.textColor = textColor;
			//	labelDisplay.applyTextFormatNow();
			//	labelDisplay.filters = (currentState=="over"||currentState=="down")?textOverFilter:null;
			}
		//	this.alpha = currentState=="disabled"?0.5:1;
			
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