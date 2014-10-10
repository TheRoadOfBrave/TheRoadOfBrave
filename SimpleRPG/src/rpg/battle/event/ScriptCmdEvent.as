package rpg.battle.event
{
	import flash.events.Event;
	
	public class ScriptCmdEvent extends Event
	{
		public static const EXE_COMMAND:String="exe_command";
		public static const END_COMMAND:String="end_command";
		public static const EXE_SHOP_COMMAND:String="exe_shop_command";
		public static const EXE_BATTLE_COMMAND:String="exe_battle_command";
		private var _code:uint;
		//命令是否会挂起  即处理完后再调用下调指令 如播放一段动画  选择分支,滚动文字等
		public var yield:Boolean;
		public var params:Array;
		public var indent:int;
		//场景类别 0 普通 1 战斗
		public var scene:uint=0;
		public function ScriptCmdEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			params=[];
		}
		
		override public function clone():Event
		{
			var event:ScriptCmdEvent=new ScriptCmdEvent(type, bubbles, cancelable);
			event.code=_code;
			event.yield=yield;
			event.params=params;
			event.indent=indent;
			event.scene=scene;
			return event;
		}
		
		public function newTypeEvent(newType:String):ScriptCmdEvent{
			var event:ScriptCmdEvent=new ScriptCmdEvent(newType, bubbles, cancelable);
			event.code=_code;
			event.yield=yield;
			event.params=params;
			event.indent=indent;
			event.scene=scene;
			return event;
		}
		
		public function get code():uint
		{
			return _code;
		}

		public function set code(value:uint):void
		{
			_code = value;
			if (code<1000){
				yield=true;
			}
			if (code==214){
				yield=false;
			}
		}

	}
}