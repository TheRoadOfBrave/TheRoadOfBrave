package rpg.map
{
	import rpg.model.Party;
	import rpg.script.BattleScript;
	import rpg.script.InnScript;
	import rpg.script.RpgScript;

	public final class ScriptBuilder
	{
		private static var _instance:ScriptBuilder;
		public function ScriptBuilder()
		{
		}
		
		public static function getInstance():ScriptBuilder{
			if (!_instance) {
				
				_instance=new ScriptBuilder();
				
			}
			return _instance;
		}
		
		
		public function build():Array{
			var arr:Array=[];
			var script:RpgScript=new BattleScript;
			arr.push(script);
			var script:RpgScript=new InnScript;
			arr.push(script);
			var script:RpgScript=new BattleScript;
			arr.push(script);
			return arr;
		}
		
		public function copy(data:Array):Array{
			var arr:Array=[];
			arr=data;
			return arr;
		}
		
		
	}
}