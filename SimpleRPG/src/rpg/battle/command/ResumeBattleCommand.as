package rpg.battle.command
{
	
	
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.BattleScene;
	
	public class ResumeBattleCommand extends Command
	{
		[Inject]
		public var battleScene:BattleScene;
		
		public function ResumeBattleCommand()
		{
			super();
		}
		
		override public function execute():void
		{
				//恢复战斗进程，继续战斗
				battleScene.resume();
		}
	}
}