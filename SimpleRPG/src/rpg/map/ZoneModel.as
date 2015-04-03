package rpg.map
{
	import rpg.model.EventPage;
	import rpg.model.GameEventObject;
	import rpg.model.GameInterpreter;
	import rpg.script.BattleScript;
	import rpg.script.RpgScript;

	public class ZoneModel
	{
		public var bg:int;
		/**
		 *当前进度 
		 */
		public var step:int;
		public var scripts:Array;
		public var interpreter:GameInterpreter;
		/**
		 *是否需要刷新事件 
		 */
		public var needRefresh:Boolean;
		
		public function ZoneModel()
		{
			scripts=[];
			interpreter=new GameInterpreter;
		}
		
		public function update():void{
			
			update_interpreter();
			
		}
		
		public function update_interpreter():void{
			//interpreter.update();
			interpreter.next();
			if (interpreter.running){
				return;
			}
			interpreter.clear();
			setup_starting_event()
		}
		
		public function setup_starting_event():void{
			setup_starting_map_event();
		}
		
		/**
		 *设置启动的事件 
		 * 
		 */
		public function setup_starting_map_event():void{
			if (script && script.condition){
				interpreter.map_id=1;
				interpreter.setup(script, 1) 
				interpreter.run();
			}
			
		}
		
		
		public  function erase():void
		{
			if (interpreter.map_id==1 && interpreter.event_id>0){
			//	eventObjs[interpreter.event_id].erase();
			}
			
		}
		
		public function get script():RpgScript{
			var eventPage:RpgScript=scripts[step];
		
			return eventPage;
		}
		
		public function go():void{
			step++;
			if (step>=scripts.length){
				trace("超出脚本范围索引");
				step=scripts.length-1;
			}
			bg=script.bg;
		}
		
		public function buildScript():void{
			if (scripts==null || scripts.length==0){
				scripts=[];
				scripts.push(new BattleScript);
				
				setup_starting_event();
			}
		
		}
		
		public function stepTo(value:int):void
		{
			step=value;
			bg=script.bg;
		}
	}
}