package rpg.model
{
	
	
	import com.adobe.utils.ArrayUtil;
	
	import rpg.vo.ActorVo;
	import rpg.vo.BaseItem;
	import rpg.vo.EquipItem;
	import rpg.vo.GameClass;
	import rpg.vo.IPackItem;
	import rpg.vo.Learning;
	import rpg.vo.MonsterVo;
	import rpg.vo.PackVo;
	import rpg.vo.Skill;
	import rpg.vo.Talent;
	import rpg.vo.TalentPt;
	
	/**
	 * 
	 * @author maikid
	 * 己方角色
	 */	
	public class Actor extends Battler
	{
		protected var vo:ActorVo
		public var  actor_id:int ;
		
		 public var name :String                    // 名称
		  public var character_name :String          // 角色行走图文件名
		  public var character_index  :int        // 角色行走图索引
		  public var face_name   :String             // 角色头像文件名
		  public var face_index  :int             // 角色头像索引
		  public var level  :int=1;              // 等级
		  private var _exp  :int                    // 经验值
		 // public var exp:Object
		  
		  public var learnPoint:int;
		public var learning:Learning;
		  
		public var plural:Boolean;
		public var gclass:GameClass;
		public function Actor(id:int=1)
		{
			super();
			this.index = index;
    		actor_id = id;
    		
    		this.vo= db.getActorVo(actor_id);
    		
    		plural = false
    		
    		battler_name = vo.battler_name
			name=battler_name;
    		battler_hue = vo.battler_hue
    		
    		
			setup(id);
			skillIdList=vo.skills;
			_skills=[];
			
			for each(var skillId:int in skillIdList){
				var skill:Skill=db.getSkill(skillId);
				_skills.push(skill);
			}
//			hp = mhp
//			mp = mmp
			trace("人物名"+vo.name,"skill:"+skillIdList)
			learning=new Learning();
		}
		
		 

		  public function get classId():int
		  {
			  return gclass.id;
		  }

		

		override protected function init():void{
			super.init();
			
			
		}
		
		public function setup(actor_id:int):void{
//			actor = $data_actors[actor_id]
//		    this.actor_id = actor_id
//		    this.name = actor.name
		    this.character_name = vo.character_name
		    this.character_index = vo.character_index
		    this.face_name = vo.face_name
		    this.face_index = vo.face_index
//		    this.class_id = actor.class_id
//		    this.weapon_id = actor.weapon_id
//		    this.armor1_id = actor.armor1_id
//		    this.armor2_id = actor.armor2_id
//		    this.armor3_id = actor.armor3_id
//		    this.armor4_id = actor.armor4_id
		  //  this.level = actor.initial_level
		   // this.exp_list =new Array(101)
		   // make_exp_list
		   // this.exp = this.exp_list[this.level]
		  //  this.skills = []
//		    for i in self.class.learnings
//		       if (i.level <= this.level){
//		       	learn_skill(i.skill_id)
//		       }
//		    clear_extra_values
//		    recover_all
				
			
				//skillIdList=[3,1,2,4]
			
		}
   
		
		
		
		override public function get id():int{
			return actor_id;
		}
		
//=======================================================================		
		override public function get feature_objects():Array{
			//super + [actor] + [self.class] + equips.compact
			var arr:Array=super.feature_objects.concat(vo,gclass);
			return arr;
			
		}
		
		override public  function param_base(param_id:uint):int
		{
			return vo.params[param_id];
		//	return gclass.params[param_id][level-1]; 职业等级数组
			
			
		}
		
		override public  function param_plus(param_id:uint):int
		{
			//equips.compact.inject(super) {|r, item| r += item.params[param_id] }
			var value:int=0
			for each (var equip:EquipItem in equips){
				if (equip)
				value+=equip.params[param_id];
			}
			return value;
		}
		
		
	
		
//==============================================================================		
		override public function get exp():int
		{
			return _exp;
		}
		
		override public function set exp(value:int):void
		{
			_exp = value;
		}
		
		private var _skills:Array;
		override public function get skills():Array{
			
			return _skills;
		}
		
		public function isSkillLearn(skill:Skill):Boolean{
			
			/*if (skills.indexOf(skill.id)>-1){
				return true;
			}
				
			return false;*/
			
			return ArrayUtil.arrayContainsValue(skillIdList,skill.id);
		}
    	
    	override public function canUseSkill(skill:Skill):Boolean{
    		if (isSkillLearn(skill)){
    			return true
    		}
    		  
    		return super.canUseSkill(skill);
    	}
   
		
		public function learn_skill(skill_id:int):void{
			var skill:Skill=db.getSkill(skill_id);
			if (skill&&!isSkillLearn(skill)){
			 	skillIdList.push(skill_id)
		      	//skills.sort!
			 }
		}
   
			/**
		● 获取当前等级的最低经验值
			 * 
			 * @return 
			 * 
			 */
			public function get current_level_exp():uint{
				return exp_for_level(level);
			}
		/**
		 *获取下一个等级的经验值 
		 * @return 
		 * 
		 */
		public function get next_level_exp():uint{
			return exp_for_level(level + 1);
		}
		
		
		/**
		 *获得经验值（判断经验获取加成） 
		 * @param exp
		 * 
		 */
		public function gain_exp(exp:int):void
		{
			change_exp(this.exp + exp, true)
		}
		
		/**
		 *经验值变化
  	     show : 等级上升的显示标志 
		 * @param exp
		 * 
		 */
		private function change_exp(exp:int,show:Boolean=false):void
		{
			//_exp[class_id] = [exp, 0].max
			_exp = Math.max(exp, 0);
			var last_level:uint = level
			var last_skills:Array = skills
			 while (level<max_level && _exp >= next_level_exp){
				level_up();
			}
			//level_down while self.exp < current_level_exp
//			
//			display_level_up(skills - last_skills) if show && @level > last_level
//			refresh
			
		}
		
		private function level_up():void
		{
			
			learnPoint+=level;
			LevelCon.levelUp(this);
			level++;
		}
		
		public function change_level(level:int, show:Boolean=true):void{
			level =Math.min(level,max_level);
			level=Math.max(level,1);
			change_exp(exp_for_level(level))
		}
		
		private function exp_for_level(level:int):int
		{
			// TODO Auto Generated method stub
			return gclass.exp_for_level(level);
		}		
		
		/*** 装備槽 对应装备类型
		 0 : 武器  1 : 盾 	 2 : 頭  3 : 身体  4 : 鞋 5 : 装飾品 
		 */
		public var equip_slots:Array=[0,2,3,4,5]
		public var equips:Array=new Array(5);
		private var max_level:uint=50;
		
		
		/**
		 * 
		# ● 将装备类型变换为装备栏 ID（优先返回空的装备栏）
		 * @param etype_id
		 * @return 
		 * 
		 */
		public function  empty_slot(etype_id:uint):uint{
	//		list = slot_list(etype_id)
	//		list.find {|i| @equips[i].is_nil? } || list[0]
			var index:int=-1
			for (var i:int=0;i<equip_slots.length;i++){
				if (equip_slots[i]==etype_id){
					if (equips[i]==null) {
						index=i;
						break;
					}
					if (index<0)	index=i;
				}
			}
			return index;
		}
		/**
		 * 
		● 获取武器实例的数组
		 * @return 
		 * 
		 */
		public function get  weapons():Array{
			//@equips.select {|item| item.is_weapon? }.collect {|item| item.object }
			var arr:Array=[];
			arr=equips.filter(testWeapon);
				function testWeapon(element:EquipItem, index:int, arr:Array):Boolean {
					return  (element && element.isWeapon);
				}
				
			return arr;
		}
		/**
		 * 
			# ● 获取护甲实例的数组
		 * @return 
		 * 
		 */
		public function get armors():Array{
//		@equips.select {|item| item.is_armor? }.collect {|item| item.object }
			var arr:Array=[];
			arr=equips.filter(testArmor);
			function testArmor(element:EquipItem, index:int, arr:Array):Boolean {
				return  (element && element.isArmor);
			}
			return arr;
		}

		/**
		 * # ● 判定是否可以更换装备
		 * @param slot_id  slot_id : 装备栏 ID
		 * @return 
		 * 
		 */
		public function equip_change_ok(slot_id:uint):Boolean{
			 if (equip_type_fixed(equip_slots[slot_id])) return false;
			if (equip_type_sealed(equip_slots[slot_id])) return false;
			return true;
		}
		/**
		 * 更换装备
		 * @param slot_id 装备栏 ID
		 * @param item 武器／护甲（为 nil 时装备解除）
		 * 
		 */
		public function  change_equip(slot_id:uint, item:EquipItem):void{
			//不交换背包里的装备
			//if (trade_item_with_party(item, equips[slot_id])==false) return ;
			//装备与 装备栏位置的 类型不符
			if (item && equip_slots[slot_id] != item.etype_id) return ;
			
				equips[slot_id] = item;
//			refresh
		}
		
		/**
		 * 交换物品
		 * @param new_item 取出的物品
		 * @param old_item 放入的物品
		 * @return 
		 * 
		 */
		public function  trade_item_with_party(new_item:IPackItem, old_item:IPackItem):Boolean{
			var party:Party=Party.getInstance();
			if (new_item && !party.has_item(new_item))
				return false;
			party.gain_item(old_item, 1)
			party.lose_item(new_item, 1)
			return true
		}
		
		override public function makeAction():void
		{
			super.makeAction();
			if (isAutoBattle){
				make_auto_battle_actions()
			}else if (isConfusion){
				make_confusion_actions()
				
			}
		}
		
		private function make_confusion_actions():void
		{
			action.setConfusion();
			
		}

		/**
		# ● 生成自动战斗用的行动候选列表
		 * 
		 */
		private function make_action_list():Array{
			var list:Array = []
	/*	list.push(Game_Action.new(self).set_attack.evaluate)
		usable_skills.each do |skill|
			list.push(Game_Action.new(self).set_skill(skill.id).evaluate)
			end*/
			return list
		}
		private function make_auto_battle_actions():void
		{
			// TODO Auto Generated method stub
			
		}		
		
	
	
		public function learnTalent(talent:Talent, lv:int):void
		{
		//if (lv-talent.lv!=1) return;
			
			var pt:TalentPt=talent.list[talent.lv]
			var curPt:TalentPt=talent.list[talent.lv-1];
			talent.lv++;
			if (pt && learnPoint>=pt.cost&&pt.learned==false){
				
				
				trace("学习天赋:"+pt.name)
				if (pt.skill_id>0){
					trace("天赋:"+pt.name+"--->学习技能"+pt.skill_id)
					learn_skill(pt.skill_id);
				}
				
				vo.params[pt.param_id]+=pt.value;
				hp=mhp;
				pt.learned=true;
				learnPoint-=pt.cost;
				
			}
			
		}
	}
}