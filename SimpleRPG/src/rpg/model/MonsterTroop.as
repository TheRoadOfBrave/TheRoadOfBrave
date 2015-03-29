package rpg.model
{
	import rpg.DataBase;
	
	public class MonsterTroop extends Troop
	{
		
		public var troopId:int
		public var enemies:Array;
		public var canLose:Boolean=false;
	//	public var interpreter:GameInterpreter;
		
		public function MonsterTroop()
		{
			super();
			//interpreter=new GameInterpreter();
		}
		
		public function get troopData():XML{
			return db.getTroop(troopId);
		}
		
//		override public function get isAllDead():Boolean{
//			return existing_members.length==0;
//		}
		
		override public function get members():Array{
			return enemies;
		}
		
		public function setMonster(id:int):void{
			clear();
			this.troopId = 1
			enemies = []
				
				
				var  enemy:Monster =db.getMonster(1,id);
			
				if (enemy){
					enemies.push(enemy)
					
				}else{
					trace("警告:缺少怪物配置"+id)
				}
				
			
		}
		
		public function setup(troopId:int):void{
			clear();
		    this.troopId = troopId
		    enemies = []
		    for each(var member:XML in troopData.members.member){
		    	
		      	
			     var  enemy:Monster =db.getMonster(enemies.length+1,member.@enemy_id);
				 if (enemy){
					 enemy.hidden = int(member.@hidden);
					 enemy.immortal = int(member.@immortal);
					 enemy.screen_x = member.@x
					 enemy.screen_y = member.@y
					 enemies.push(enemy)
					 trace(enemy.hidden+"加入怪物"+member.toXMLString())
					 
				 }else{
					 trace("警告:缺少怪物配置"+member)
				 }
			     
			}
			
		   // make_unique_names
		}
		
		
		private function clear():void{
			
		}
		
		
//		public function setup_battle_event():void{
//			 if (interpreter.running) return
//		//	return if interpreter.setup_reserved_common_event
//				 for each (var page:EventPage in troopData){
//					 //next unless conditions_met?(page)
//						 interpreter.setup(page.list)
//					//	 @event_flags[page] = true if page.span <= 1
//					 return
//				 }
//		}
			
			/**
			 * 
		# ● 增加回合
			 * 
			 */
			public function increase_turn():void{
			//	troop.pages.each {|page| @event_flags[page] = false if page.span == 1 }
				turn_count += 1
				
			}

			/**
			# ● 计算经验值的总数
			 * 
			 * 
			 */
			public function exp_total():uint{
				var exp:uint=0;
				for each (var enemy:Monster in dead_members){
					exp+=enemy.exp;
				}
				return exp;
			}
			/**
			 * 
			# ● 计算金钱的总数
			 * 
			 */
			public function gold_total():uint{
			var gold:uint=0;
			for each (var enemy:Monster in dead_members){
				gold+=enemy.gold;
			}
			return gold* gold_rate;
			}
			/**
			 * 
			# ● 获取金钱的倍率
			 * 
			 */
			public function get gold_rate():Number{
				//$game_party.gold_double? ? 2 : 1
				return 1;
			}
			/**
			# ● 生成物品数组
			 * 
			 * 
			 */
			public function make_drop_items():Array{
				var items:Array=[]
				//dead_members.inject([]) {|r, enemy| r += enemy.make_drop_items }
				for each (var enemy:Monster in dead_members){
					var arr:Array=enemy.make_drop_items()
					items=items.concat(arr);
				}
				
				return items;
			}
		
	}
}