package rpg.script
{
	
	import rpg.Code;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.model.EventPage;
	
	public class InnScript extends RpgScript
	{
		
		public function InnScript()
		{
			trigger=3;
			bg=8;
		}
		override public function get condition():Boolean
		{
			return end==false;
		}
		
		override public function getCommand(index:int):ScriptCmdEvent
		{
			var cmd:ScriptCmdEvent=new ScriptCmdEvent(ScriptCmdEvent.EXE_COMMAND);
			var arr:Array=[
				
				function ():void{
					//	cmd.code=CodeConst;
					cmd.code=101;
						cmd.params[0]="来到了一间旅馆!"
						cmd.params[1]=1
						cmd.params[2]="范德萨"
						cmd.params[4]=2
				},
				
//				function ():void{
//					//	cmd.code=CodeConst;
//					cmd.code=301;
//				cmd.params[0]=0
//				cmd.params[1]=1
//				end=true;
//				},
				function ():void{
					cmd.code=501;
					cmd.params[0]=0
					cmd.params[1]=1
				}
				
				
				
			
			]
				
				var fun:Function=arr[index];
				if (fun!=null)
					fun();
			if (cmd.code>0)
				return cmd;
			end=true;
			return null;
		}
	}
}