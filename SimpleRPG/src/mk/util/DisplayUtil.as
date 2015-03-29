package mk.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import mx.core.IFlexDisplayObject;

	public class DisplayUtil
	{
		
		public static const MAX_BITMAP_DIMENSION:int = 2880;
		
		
		public static function clear(container:DisplayObjectContainer):void{
			while(container.numChildren>0){
				container.removeChildAt(0);
			}
		}
		
		public static function  drawRect(grap:Graphics,x:Number,y:Number,w:Number,h:Number,c:uint,r:Number=0):void{
			grap.beginFill(c,1);
			if (r>0){
				grap.drawRoundRect(x,y,w,h,r)
			}else{
				grap.drawRect(x,y,w,h);
			}
			grap.endFill();
		}
		
		
		public static function captureBitmapData(
			source:IBitmapDrawable, matrix:Matrix = null,
			colorTransform:ColorTransform = null,
			blendMode:String = null,
			clipRect:Rectangle = null,
			smoothing:Boolean = false):BitmapData
		{
			var data:BitmapData;
			var width:int;
			var height:int;
			
			var normalState:Array;
//			if (source is IUIComponent)
//				normalState = prepareToPrintObject(IUIComponent(source));
//			
			try
			{
				if (source != null)
				{
					if (source is DisplayObject)
					{
						width = DisplayObject(source).width;
						height = DisplayObject(source).height;
					}
					else if (source is BitmapData)
					{
						width = BitmapData(source).width;
						height = BitmapData(source).height;
					}
					else if (source is IFlexDisplayObject)
					{
						width = IFlexDisplayObject(source).width;
						height = IFlexDisplayObject(source).height;
					}
				}
				
				// We default to an identity matrix
				// which will match screen resolution
				if (!matrix)
					matrix = new Matrix(1, 0, 0, 1);
				
				var scaledWidth:Number = width * matrix.a;
				var scaledHeight:Number = height * matrix.d;
				var reductionScale:Number = 1;
				
				// Cap width to BitmapData max of 2880 pixels
				if (scaledWidth > MAX_BITMAP_DIMENSION)
				{
					reductionScale = scaledWidth / MAX_BITMAP_DIMENSION;
					scaledWidth = MAX_BITMAP_DIMENSION;
					scaledHeight = scaledHeight / reductionScale;
					
					matrix.a = scaledWidth / width;
					matrix.d = scaledHeight / height;
				}
				
				// Cap height to BitmapData max of 2880 pixels
				if (scaledHeight > MAX_BITMAP_DIMENSION)
				{
					reductionScale = scaledHeight / MAX_BITMAP_DIMENSION;
					scaledHeight = MAX_BITMAP_DIMENSION;
					scaledWidth = scaledWidth / reductionScale;
					
					matrix.a = scaledWidth / width;
					matrix.d = scaledHeight / height;
				}
				
				// the fill should be transparent: 0xARGB -> 0x00000000
				// only explicitly drawn pixels will show up
				data = new BitmapData(scaledWidth, scaledHeight, true, 0x00000000);
				data.draw(source, matrix, colorTransform,
					blendMode, clipRect, smoothing);
			}
			catch(e:Error)
			{
				data = null;
			}
			finally
			{
//				if (source is IUIComponent)
//					finishPrintObject(IUIComponent(source), normalState);
			}
			
			return data;
		}
		
	}
}