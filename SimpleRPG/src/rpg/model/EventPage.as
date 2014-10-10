package rpg.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.city.MapModel;
	
	/**
	 *事件页 战斗群有多个事件页  每页一个触发条件 
	 * 注入 游戏必要数据  读取判断 但不要在此更改，通过cmd发送出去处理 
	 * @author maikid
	 * 
	 */
	public class EventPage extends EventDispatcher
	{
	//	条件 (RPG::Troop::Page::Condition) 。
		private var _condition:Boolean; 
		
		//触发方式 ，地图上用
		public var trigger :uint;
		//スパン (0:バトル、1:ターン、2:モーメント) 。
		public var span :int;
		//MAKER中是一条条CMD 包括条件分歧等，这里直接在类中写
		public var list:Array; 
		protected var data:GameData=GameData.getInstance();
		public function EventPage(target:IEventDispatcher=null)
		{
			super(target);
		}
		/**
		 *子类重写自己的开启条件 
		 * @return 
		 * 
		 */
		public function get condition():Boolean
		{
			return _condition;
		}

		public function set condition(value:Boolean):void
		{
			_condition = value;
		}

		/**
		 *根据进度索引取得要执行的命令 
		 * @param index
		 * @return 
		 * 
		 */		
		public function getCommand(index:int):ScriptCmdEvent
		{
			return null;
		}
		
		private var cmdDict:Object={302:ScriptCmdEvent.EXE_SHOP_COMMAND}
		public function creatCommand(code:uint):ScriptCmdEvent{
			var cmd:ScriptCmdEvent;
			var type:String=cmdDict[code];
			if (type==null){
				type=ScriptCmdEvent.EXE_COMMAND;
			}
			cmd=new ScriptCmdEvent(type);
			cmd.code=code;
			return cmd;
		}
	}
}