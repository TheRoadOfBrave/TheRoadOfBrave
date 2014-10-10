package rpg.battleScript
{
	import flash.events.IEventDispatcher;
	
	import rpg.battle.event.BattleCmdEvent;
	import rpg.model.EventPage;
	
	public class Script10 extends EventPage
	{
		public function Script10()
		{
		}
		override public function get condition():Boolean
		{
			return true;
		}
		
		override public function getCommand(index:int):BattleCmdEvent
		{
			var cmd:BattleCmdEvent=new BattleCmdEvent(BattleCmdEvent.EXE_COMMAND);
			switch (index){
				case 0:
					
					cmd.code=1;
					cmd.paras[0]="测试文字0."
					break;
				case 1:
					
					cmd.code=1;
					cmd.paras[0]="测试文字显示TOAST..."
					break;
				case 2:
					cmd.code=2
					cmd.paras[0]="选择题，yes or no ？"
					cmd.paras[1]=3;
					cmd.paras[2]=4;
					break;
				case 30:
					cmd.code=1;
					cmd.paras[0]="测试答案1"
					break;
				case 40:
					cmd.code=1;
					cmd.paras[0]="测试答案2"
					break;
			}
			if (cmd.code>0)
				return cmd;
			
			return null;
		}
	}
}