package rpg.model
{
	import rpg.DataBase;
	import rpg.HeroData;
	import rpg.vo.BaseItem;
	import rpg.vo.IPackItem;
	import rpg.vo.Item;
	import rpg.vo.Talent;
	import rpg.vo.TalentPt;
	
	public class Party extends Troop
	{
		private static var _instance:Party;
		public var troopId:int
		public var actors:Array;
		private var _gold:int;
		private var _food:int;
		public var maxFood:int=10;
		public var bag:ItemBag;
		public var inBattle:Boolean;
		
		public function Party()
		{
			super();
			bag=new ItemBag();
			actors = [];
			inBattle=true;
		}

		

		
		

		public static function getInstance():Party{
			if (!_instance) {
				
				_instance=new Party();
				
			}
			return _instance;
		}
		
		
		
		[Bindable]
		public function get gold():int
		{
			return _gold;
		}
		
		public function set gold(value:int):void
		{
			_gold = value;
		}
		
		[Bindable]
		public function get food():int
		{
			return _food;
		}
		
		public function set food(value:int):void
		{
			_food = value;
		}
		
		
		public function get troopData():XML{
			return db.getTroop(troopId);
		}
		
		override public function get isAllDead():Boolean{
			return super.isAllDead;
		}
		
		override public function get members():Array{
			return actors;
		}
		
		
		//需修正
		public function setup(troopId:int):void{
			clear();
		    this.troopId = troopId
			actors = [];
		    	
		      if (DataBase.actors.actor[0] !=null){
		      	
			     var  actor:Actor = db.getActor(1);
//			      enemy.hidden = int(member.@hidden);
//			      enemy.immortal = int(member.@immortal);
//			      enemy.screen_x = member.@x
//			      enemy.screen_y = member.@y
			      actors.push(actor)
					  actor.index=actors.length;
					  actor.learnPoint=10
				addLearning(actor);
			//	actor.gain_exp(50)
		      }
		     
			
		}
		
		public function addLearning(actor:Actor):void{
			var classId:int=actor.classId;
			var heroData:HeroData=HeroData.getInstance();
			var talent1:Talent;
			var talent2:Talent;
			var talent3:Talent;
			if (classId==1){
				 talent1=heroData.getLearning(1);
				 talent2=heroData.getLearning(2);
				 talent3=heroData.getLearning(3);
			}else if (classId==2){
				talent1=heroData.getLearning(4);
				talent2=heroData.getLearning(5);
				talent3=heroData.getLearning(6);
			}else{
				talent1=heroData.getLearning(7);
				talent2=heroData.getLearning(8);
				talent3=heroData.getLearning(9);
			}
			actor.learning.addTalent(talent1);
			actor.learning.addTalent(talent2);
			actor.learning.addTalent(talent3);
		}
		
		public function has_item(item:IPackItem, include_equip = false):Boolean{
			
			if (bag.item_number(item) > 0) return true ;
			//	return include_equip ? members_equip_include?(item) : false
			
			return false;
		}
		
			
			
		
		public function gain_item(item:IPackItem,n:int,include_equip = false):void{
			bag.gainItem(item,n);
			
		}
		
		/**
		 * 减少物品
		#     include_equip : 是否包括装备
		 * @param item
		 * @param n
		 * @param include_equip
		 * 
		 */
		public function  lose_item(item, n:int, include_equip = false):void{
			gain_item(item, -n, include_equip)
		}
			
		/**
		 * 消耗物品
  #    减少 1 个持有数。 
		 * @param item
		 * 
		 */
		public function consume_item(item:Item):void
		{
			if (item is Item && item.consumable){
				lose_item(item, 1)
			}
		}
		
		public function clear():void{
			this.clear_actions();
			for each (var actor:Actor in actors){
				actor.clear_action_results();
				
			}
		}
		
		/**
		 * 队伍全恢复 
		 * 
		 */
		public function recover_all():void
		{
			for each (var actor:Actor in actors){
				actor.recover_all();
				
			}
			
		}
		
	
	}
}