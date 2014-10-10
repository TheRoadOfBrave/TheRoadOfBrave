package rpg
{
	import com.adobe.utils.ArrayUtil;
	
	import flash.utils.Dictionary;
	
	import rpg.battleScript.Script20;
	import rpg.model.Actor;
	import rpg.model.BattlerBase;
	import rpg.model.EventPage;
	import rpg.model.GameEventObject;
	import rpg.model.Monster;
	import rpg.script.*;
	import rpg.vo.ActorVo;
	import rpg.vo.Effect;
	import rpg.vo.EquipItem;
	import rpg.vo.EventVo;
	import rpg.vo.Feature;
	import rpg.vo.GameClass;
	import rpg.vo.Item;
	import rpg.vo.MapVo;
	import rpg.vo.MonsterVo;
	import rpg.vo.RpgState;
	import rpg.vo.Skill;
	import rpg.vo.Talent;
	import rpg.vo.TalentPt;

	public  class DataBase
	{
		public static var skills:XML;
		public static var troops:XML;
		public static var states:XML;
		public static var effects:XML;
		public static var actors:XML;
		public static var monsters:XML;
		public static var items:XML;
		public static var acts:XML;
		public static var animes:XML;
		//配置映射的静态数据
		public static var dicts:Dictionary=new Dictionary;;
		private var _states:Dictionary
		
		private static var _instance:DataBase;
		
		public function DataBase()
		{
			_states=new Dictionary;
		}
		
		
		public static function getInstance():DataBase{
			if (!_instance) {
				
				_instance=new DataBase();
			}
			return _instance;
		}
		
		/**
		 *将基本数据 转换赋值给vo 的对应属性
		 * 名称不匹配自动跳过
		 * @param vo
		 * @param obj 基本配置
		 * @param skips 跳过特殊字段  不赋值 需要另外切割解析
		 * @return vo
		 * 
		 */		
		private function parseVo(vo:Object,obj:Object,skips:Array):void{
			for (var field:String in obj){
				if (skips&&ArrayUtil.arrayContainsValue(skips,field)){
					continue;
				}
				if (vo.hasOwnProperty(field)){
					vo[field]=obj[field]
				}
			}
		}
		
		public  function getTroop(id:int):XML{
			return troops.troop[id-1]
		}
		
		public  function getMonsterVo(mid:int):MonsterVo{
			var monster_xml:XML=XML(monsters.monster.(id==mid));
			var vo:MonsterVo=new MonsterVo(monster_xml)
			
			return vo;
		}
		
		
		/**
		 * 
		 * @param index 在队伍中的位置，从1开始
		 * @param id
		 * @return 
		 * 
		 */		
		public  function getMonster(index:int,id:int):Monster{
			var monster:Monster=new Monster(index,id);
			return monster;
		}
		
		public  function getActorVo(id:int):ActorVo{
			//var xml:XML=actors.monster[int(id)-1] as XML;
			var xml:XML=actors.actor[int(id)-1] as XML;
			var vo:ActorVo=new ActorVo(xml)
			
			return vo;
		}
		
		public  function getActor(id:int):Actor{
			var actor:Actor=new Actor(id);
			actor.gclass=getGameClass(actor.actor_id);
			return actor;
		}
		
		public  function getState(sid:int):RpgState{
			var state:RpgState=_states[sid];
				if (state==null){
					var state_xml:XML=XML(states.state.(id==sid)); 
					state=new RpgState(state_xml);
					_states[state.id];
				}
					
			return state;
		}
		
		
		public  function getSkill(skillId:int):Skill{
			var skill_xml:XML=XML(skills.skill.(id==skillId));
			//trace("getSkill::"+skills.skill.(id=="10") )
			var vo:Skill=new Skill(skill_xml)
			
			return vo;
		}
		
		public  function getItem(id:int):Item{
			var dict:Dictionary=dicts["item"]
			var obj:Object=dict[id];
			
			var vo:Item=new Item();
			var skips:Array=["features","effects","damage"]
			parseVo(vo,obj,skips);
			vo.id=obj.id;
			vo.animation_id=obj.amimation;
			vo.icon_index=obj.icon;
			vo.num=1
			if (obj.effects){
				var effects:Array=obj.effects.split(";");
				for (var i:int=0;i<effects.length;i++){
					effects[i]=parseEffect(effects[i]);
				}
				vo.effects=effects;
			}
		
			return vo;
		}
		
		private function parseEffect(str:String):Effect{
			var arr:Array=str.split(",");
			var eff:Effect=new Effect();
			eff.code=int(arr[0]);
			eff.data_id=int(arr[1]);
			eff.value1=int(arr[2]);
			eff.value2=int(arr[3]);
			return eff;
		}
		
		
		/**
		 *职业  指定人物各等级的数值
		 * @param id
		 * @return 
		 * 
		 */
		public function getGameClass(id:uint):GameClass{
			var gclass:GameClass=new GameClass();
			switch (id){
				case 1:
					gclass.id=1;
					gclass.params=[[60],[10],[10],[30],[6],[1],[2],[8]]//体力
					gclass.features=setClassFeature(1,1,0.12,0.2,[1],[1]);
				
					break;
				case 2:
					gclass.id=2;
					gclass.params=[[62],[1],[10],[13],[6],[1],[2],[8]]
					gclass.features=setClassFeature(1,1,1,1,[1],[1]);
					break;
				
				case 3:
					gclass.id=3;
					gclass.params=[[60],[11],[12],[10],[6],[1],[2],[8]]
					gclass.features=setClassFeature(1,1,1,1,[3],[1]);
					break;
				
			}
			
			return gclass;
		}
		
		/**
		 *设置 职业 基本能力 
		 * @param enmity
		 * @param hit
		 * @param eva
		 * @param cri
		 * @param weapons
		 * @param armors
		 * @return 
		 * 
		 */
		private function setClassFeature(enmity:Number,hit:Number,cri:Number,eva:Number,weapons:Array,armors:Array):Array{
			var fts:Array=[];
			var ft1:Feature=new Feature(BattlerBase.FEATURE_SPARAM,1,enmity);
			fts.push(ft1);
			var ft2:Feature=new Feature(BattlerBase.FEATURE_XPARAM,1,hit);
			fts.push(ft2);
			var ft3:Feature=new Feature(BattlerBase.FEATURE_XPARAM,2,cri);
			fts.push(ft3);
			var ft4:Feature=new Feature(BattlerBase.FEATURE_XPARAM,3,eva);
			fts.push(ft4);
			for each (var wid:int in weapons){
				var wft:Feature=new Feature(BattlerBase.FEATURE_EQUIP_WTYPE,wid);
				fts.push(wft);
			}
			for each (var aid:int in armors){
				var aft:Feature=new Feature(BattlerBase.FEATURE_EQUIP_ATYPE,aid);
				fts.push(aft);
			}
			
			
			return fts;
		}
		
		
		
		
		public  function getActData(id:int):XML{
			return acts.act[id-1]
		}
		
		public  function getEffectData(id:int):XML{
			return effects.effect[id-1]
		}
		
		private var EQUIP_UID:uint=0
		public function getWeapon(id:int):EquipItem
		{
			var dict:Dictionary=dicts["equip"]
			var obj:Object=dict[id];
			
			var equip:EquipItem=new EquipItem();
			var skips:Array=["features","effects","damage","params"]
			parseVo(equip,obj,skips);
			equip.id=obj.id;
			equip.animation_id=obj.amimation;
			equip.icon_index=obj.icon;
			equip.num=1;
			equip.wtype_id=obj.wtype;
			equip.etype_id=obj.etype;
			equip.atype_id=obj.atype;
			
			equip.params= [1000,0,10,0,0,0,0,0];
			EQUIP_UID++;
			equip.flowId=EQUIP_UID;
			return equip;
		}
		
		public function getEventObject(id:uint):GameEventObject{
			var eventObj:GameEventObject;
			switch (id){
				case 1:
					
					break;
				case 2:
					break;
				
				case 3:
					break;
				
			}
			return eventObj;
		}
		
		public static function getTroopEvents(troopId:int):Array
		{
			var list:Array=[];
			if (troopId==0){
				var script:EventPage=new Script20;
				list.push(script);
			}
			return list;
		}
		
		
		
		public static function getMapXML(id:int):XML
		{
			var xml:XML=XML(dicts["map"].map.(@id==id));
			return xml;
		}
	}
}