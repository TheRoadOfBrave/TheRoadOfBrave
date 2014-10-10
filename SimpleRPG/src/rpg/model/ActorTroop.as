package rpg.model
{
	import mk.rpg.DataBase;
	
	
	//弃用了
	public class ActorTroop extends Troop
	{
		
		public var troopId:int
		public var enemies:Array;
		public var actors:Array;
		public var items:Object;
		public var weapons:Object;
		public var armors:Object;
		public var gold:int;
		
  
		public function ActorTroop()
		{
			super();
		}
		
		private function init():void{
			gold = 0
		   
		    actors = []     
		    items = {}      
		    weapons = {}    
		    armors = {}     
		
		}
		
		public function get troopData():XML{
			return DataBase.getTroop(troopId);
		}
		
		
		
		public function setup(troopId:int):void{
			clear();
		    this.troopId = troopId
		    enemies = []
		    for each(var member:XML in troopData.members.member){
		    	
		      if (DataBase.monsters.monster[member.@enemy_id-1] !=null){
		      	
			     var  enemy:Monster = new Monster(enemies.length,member.@enemy_id);
			      enemy.hidden = int(member.@hidden);
			      enemy.immortal = int(member.@immortal);
			      enemy.screen_x = member.@x
			      enemy.screen_y = member.@y
			      enemies.push(enemy)
			      trace(enemy.hidden+"加入怪物"+member.toXMLString())
		      }
		     
			}
			members=enemies;
		   // make_unique_names
		}
		
		private function clear():void{
			
		}
	}
}