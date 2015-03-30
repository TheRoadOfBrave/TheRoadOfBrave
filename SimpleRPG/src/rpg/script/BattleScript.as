package rpg.script
{
	
	import rpg.Code;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.model.EventPage;
	
	public class BattleScript extends EventPage
	{
		private var end:Boolean=false;
		public function BattleScript()
		{
			trigger=3;
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
						cmd.params[0]="测试文字22220.kjkjkjkjhhuugugu\nkjkk\nasdff\ndaege\n" +
							"阿斯达克发结果额打击感iag 阿道夫 \n爱的感觉阿尔加过ix阿福加爱是间隔发!"
						cmd.params[1]=1
						cmd.params[2]="范德萨"
						cmd.params[4]=2
				},
				function ():void{
					//	cmd.code=CodeConst;
					cmd.code=301;
					cmd.params[0]=0
					cmd.params[1]=1
					end=true;
				},
				function ():void{
					cmd.code=501;
					cmd.params[0]=0
					cmd.params[1]=1
				},
				function ():void{
					cmd.code=502;
					cmd.params[0]={type:1,id:1,n:1,price:100}
					cmd.params[1]={type:1,id:3,n:1,price:102}
					cmd.params[2]={type:1,id:2,n:1,price:103}
					cmd.params[3]={type:2,id:2,n:1,price:103}
					cmd.params[4]={type:2,id:1,n:1,price:103}
					cmd.params[5]={type:2,id:502,n:1,price:103}
					end=true;
				}
				
				
			/*	function ():void{
					cmd.code=1;
					cmd.params[0]="测试文字333."
				},
				function ():void{
					cmd.code=301;
					cmd.params[0]=0;
					cmd.params[1]=1;
				},
				function ():void{
					cmd.code=1;
					cmd.params[0]="测试文字000000."
				}*/
			
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