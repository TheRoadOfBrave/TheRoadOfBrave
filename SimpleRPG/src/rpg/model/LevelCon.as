package rpg.model
{
	/**
	 * 
	 * @author maikid
	 *控制角色的水平升降
	 * 生成下一级的参数 习得技能等 
	 */
	public class LevelCon
	{
		public function LevelCon()
		{
		}
		
		public static function levelUp(actor:Actor):void{
			var lv:uint=actor.level;
			for (var i:int=0;i<8;i++){
				var param:uint=1
				var last:int=actor.gclass.params[i][lv-1]
				param+=last;
				actor.gclass.params[i][lv]=param;
			}
		}
		public function levelUp(lv:uint):void{
			
			
		}
	}
}