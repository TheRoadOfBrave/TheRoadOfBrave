package mk.util
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;

	public class DisplayUtil
	{
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
		
	}
}