package rpg.model
{
	import flash.events.EventDispatcher;
	
	
	import rpg.battle.event.ScriptCmdEvent;
	
	public class GameInterpreter extends EventDispatcher
	{
		public var running:Boolean;
		public var page:EventPage;
		public var index:int;
		public var event_flags:Object={};
		public var event_id:uint;
		public var map_id:uint;
		public function GameInterpreter()
		{
		}
		/**
		 *list里是 一条条的命令参数 
		 * @param list
		 * @param event_id
		 * 
		 */		
		/*public function setup(list:Array, event_id = 0):void{
		//	clear
			//@map_id = $game_map.map_id
//				@event_id = event_id
//				@list = list
			//create_fiber
			
		}*/
		
		public function setup(page:EventPage, event_id:uint = 0):void{
			clear();
			//@map_id = $game_map.map_id
			this.event_id = event_id
			this.page=page;
			//create_fiber
			
		}
		
		public function clear():void{
//			@map_id = 0
//				@event_id = 0
//				@list = nil                       # 执行内容
//				@index = 0                        # 索引
//				@branch = {}                      # 分歧数据
//				@fiber = nil                      # 纤程.
			page=null;
			index=0;
			running=false;
		}
		
		
		public function run():void{
			//wait_for_message
			if (page==null) {
				running=false;
				command_end();
				return;
			}
			var cmd:ScriptCmdEvent;
			cmd=page.getCommand(index)
				/*循环获取脚本命令 ，
				如果命令需要挂起等待 ，则跳出等待命令执行完毕 后 会调用update 继续搅拌
				如果不需要等待 步进index 继续循环获取下一条命令执行
				如果获取不到命令，脚本解释结束 发送恢复战斗命令 继续处理战斗。
				*/
				
			while (cmd){
				running=true;
				execute_command(cmd);
				if (cmd.yield){
					return;
				}else{
					index += 1
					cmd=page.getCommand(index)
				}
			}
			running=false;
			
//				Fiber.yield
//					@fiber = nil
			command_end();
		}
		
		public function update():void
		{
			if (running)
			run();
		}
		
		
		/**
		 *执行下一条指令 （如果事件运行中） 
		 * 
		 */
		public function next():void{
			if (running){
				index++;
				run();
			}
			
		}
		
		private function execute_command(cmd:ScriptCmdEvent):void{
			dispatchEvent(cmd);
		//	eventView.dispatchEvent(new BattleCmdEvent(BattleCmdEvent.EXE_COMMAND));
		}
		private function command_end():void{
			dispatchEvent(new ScriptCmdEvent(ScriptCmdEvent.END_COMMAND));
			//eventView.dispatchEvent(new BattleEvent(BattleEvent.RESUME_BATTLE));
		}
	}
}