package rpg.view
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public class ValueBar extends Sprite
	{
		private var barBg:Shape
		private var rectLength:Number=100;
		private var rectH:Number=4;
		private var _color:uint=0x000000;
		private var bgColor:uint=0x000000;
		private var bar:Shape;
		public var _value:Number=0;
		public var max:Number=100;
		public function ValueBar(w:Number,h:Number,color:uint=0xffff00,bgColor:uint=0x000000)
		{
			draw(w,h,color,bgColor);
			bar.width = 1;
			barBg.alpha=0.3
			
			
		}
		
		public function draw(w:Number,h:Number,color:uint=0xffff00,bgColor:uint=0x000000):void{
			rectLength=w;
			rectH=h;
			if (barBg&&bar.parent&&barBg.parent){
				removeChild(bar);
				removeChild(barBg);
			}
			bar = createUi(color);
			barBg = createUiBg(bgColor);
			
			addChild(bar);
			addChild(barBg);
		}
		
		public function get color():uint{
			return _color;
		}
		public function set color(c:uint):void{
			var colorInfo:ColorTransform = bar.transform.colorTransform; 
			colorInfo.color = c; 
			bar.transform.colorTransform=colorInfo;
		}
		
		
		public function get value():Number{
			return _value;
		}
		public var percent :Number
		public function set value(v:Number):void{
			_value=v;
			percent =v/max
			if(percent>1)percent=1;
			bar.scaleX=percent;
		}
		
		public function setValue(v:Number,max:Number):void{
			this.max=max;
			value=v;
		}
		
		
		private function createUi(color:uint):Shape
		{
			var shape:Shape = new Shape;
				
				shape.graphics.beginFill(color);
			shape.graphics.drawRect(0, 0, rectLength, rectH);
			shape.graphics.endFill();
			return shape;
		}
		
		private function createUiBg(color:uint):Shape
		{
			var shape:Shape = new Shape;
			shape.graphics.lineStyle(1,color);
			shape.graphics.drawRect(0, 0, rectLength, rectH);
			shape.graphics.endFill();
			return shape;
		}
	}
}