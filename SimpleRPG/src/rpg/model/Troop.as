package rpg.model
 {
 	import rpg.DataBase;

	/**
	 * 队伍的类
	 */
	public class Troop {
		public var preemptive:Boolean;
		public var opponentTroop:Troop
		//回合数
		public var turn_count  :uint=0;             
		protected var db:DataBase=DataBase.getInstance();
		public function Troop():void{
			
			init ();
		}
		private function init ():void{
			
		}
		
		
		public function get members():Array{
			return [];
		}
		
		//获取可战斗队员
		public function  get existing_members():Array{
			var result:Array = [];
		    for each (var battler:Battler in members){
				if (battler.isExist){
		    		 result.push(battler);
		    	}
		    }
		    return result;
		}
		//获取存活的成员数组
		public function  get alive_members():Array{
			//	members.select {|member| member.alive? }
			var result:Array = [];
			for each (var battler:Battler in members){
				if (battler.isAlive){
					result.push(battler);
				}
			}
			return result;
		}
		
	
    	//获取无法战斗队员
    	public function get dead_members():Array{
			var result:Array = [];
		    for each (var battler:Battler in members){
		    	if (battler.isDead){
		    		 result.push(battler);
		    	}
		    }
		    return result;
		}
		
		public function get isAllDead():Boolean{
			return alive_members.length==0;
		}
		
		
		public function setOpponentTroop(oppTroop:Troop):void{
			this.opponentTroop=oppTroop;
			for each(var battler:Battler in members){
				battler.setTroopStandpoint(this,opponentTroop);
			}
		}
		
    
  
		
		
		public function make_actions():void{
			if (preemptive){
				clear_actions();
			}else{
				for each (var battler:Battler in members){
					battler.makeAction();
				}
			}
		}
    	
    	public function clear_actions():void{
			for each (var battler:Battler in members){
				battler.clear_actions();
			}
			
		}
		
		//清除所有队员行动
		
		
		//随机目标选择
		public function randomTarget():Battler{
			/*tgr_rand = rand * tgr_sum //前后卫几率?
			alive_members.each do |member|
				tgr_rand -= member.tgr
				return member if tgr_rand < 0
				end
				alive_members[0]*/
			
			
			var  roulette:Array = [];
			var readyMembers:Array=alive_members;
			
			//添加敌人到轮流
		    for each (var battler:Battler in readyMembers){
		        	roulette.push(battler); 
		    }
		     //转轮盘赌，决定敌人
		    if (roulette.length>0){
				var bigo:int=Math.floor(Math.random()*roulette.length)
				trace(roulette.length+"轮盘中的敌人"+bigo)
				return roulette[bigo];
		    }
			return null;
		   
		   
			
			
		}
		
		public function randomDeadTarget():Battler{
			var  roulette:Array = [];
			var readyMembers:Array=dead_members;
			
			//添加敌人到轮流
			for each (var battler:Battler in readyMembers){
				roulette.push(battler); 
			}
			//转轮盘赌，决定敌人
			if (roulette.length>0){
				var bigo:int=Math.floor(Math.random()*roulette.length)
				trace(roulette.length+"轮盘中的敌人"+bigo)
				return roulette[bigo];
			}
			return null;
			
		}
		
		
		
		/**
		 *  决定顺带目标
  		    也就是如果上下目标无效，则获取下一个目标
		 * index : 位置	    
		 */
		public function smoothTarget(index:int):Battler{
			var member:Battler = members[index-1];
			if (member!=null&&member.isAlive){
				return member;
			}
			
    		return alive_members[0];
		}
		
		/**
		 * 直接目标选择（无法战斗者）
		 * index : 位置	    
		 */
		public function smooth_dead_target(index:int):Battler{
			var member:Battler = members[index];
			if (member!=null&&member.isDead){
				return member;
			}
    		return dead_members[0];
		}
    	
    	
    	/**
    	 * 执行自动回复（回合结束时调用）
    	 */
    	public function do_auto_recovery():void{
    		 for each(var member:Battler in members){
    		// 	 member.do_auto_recovery();
    		 }
     
    	}
   
    	/**
    	 * 发动连续伤害效果,如中毒状态的时候（回合结束时调用）
    	 */
    	public function slip_damage_effect():void{
    		for each(var member:Battler in members){
    			//member.slip_damage_effect();
    		}
    	}
    
		/**
		 *战斗开始处理 
		 * @return 
		 * 
		 */
		public function on_battle_start():void{
//			members.each {|member| member.on_battle_start }
//			@in_battle = true
		}
		/**
		 *战斗结束处理 
		 */
		public function on_battle_end():void{
		//	@in_battle = false
		//	members.each {|member| member.on_battle_end }
		}
	}
}
