package rpg
{
	import mx.core.mx_internal;
	use namespace mx_internal;
	import mx.logging.targets.LineFormattedTarget;
	
	public class LogTarget extends LineFormattedTarget
	{
		public var logFun:Function;
		public function LogTarget()
		{
			super();
		}
		
		override  mx_internal function internalLog(message:String):void
		{
			if (logFun!=null) logFun(message);
		}
		
	}
}