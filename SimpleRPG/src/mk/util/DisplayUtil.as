package mk.util
{
	import flash.display.DisplayObjectContainer;

	public class DisplayUtil
	{
		public static function clear(container:DisplayObjectContainer):void{
			while(container.numChildren>0){
				container.removeChildAt(0);
			}
		}
		
		
	}
}