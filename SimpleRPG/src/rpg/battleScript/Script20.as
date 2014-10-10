package rpg.battleScript
{
	import flash.events.IEventDispatcher;
	
	import rpg.Code;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.model.BattleModel;
	import rpg.model.EventPage;
	
	public class Script20 extends EventPage
	{
		public function Script20()
		{
		}
		override public function get condition():Boolean
		{
			var battle:BattleModel=BattleModel.getInstance();
			if (battle.isTurnEnd){
				return true;
			}
			return false;
		}
		
		override public function getCommand(index:int):ScriptCmdEvent
		{
			var cmd:ScriptCmdEvent=new ScriptCmdEvent(ScriptCmdEvent.EXE_COMMAND,true);
			cmd.scene=1;
			var arr:Array=[
//				function ():void{
//						cmd.code=1;
//						cmd.params[0]="测试文字000"
//				},
				/*function ():void{
					cmd.code=2
					cmd.params[0]="选择题222，yes or no ？"
					cmd.params[1]=3;
					cmd.params[2]=4;
				},
				function ():void{
					cmd.code=1;
					cmd.params[0]="测试文1111"
					doit=false;
				},
				
				function ():void{
					cmd.code=1;
					cmd.params[0]="NONONO"
				},*/
				
				
				function ():void{
					cmd.code=339;
					cmd.params[0]=1
					cmd.params[1]=1
					cmd.params[2]=29
					cmd.params[3]=2
					//doit=false;
				}
			]
				var fun:Function=arr[index];
				if (fun!=null)
					fun();
			if (cmd.code>0)
				return cmd;
			
			return null;
		}
	}
}