package rpg.vo {
	import rpg.vo.UsableItem;
	
	/**
	 * @author GUNDAM
	 */
	public class Skill extends UsableItem {
		public var lv:int=1;
		public var stype:int;
		public var mp_cost:Number;
		public var hit:Number;
		public var message1 :String,message2:String; 
		
		public function Skill(skillData:XML) {
			super();
			init(skillData);
		}
		private function init(skillData:XML):void{
			id=skillData.id;
			name = skillData.name;
	      	icon_index = skillData.icon_index;
	     	description = skillData.description;
	      	note = skillData.note;
			stype =skillData.stype;
	      	scope = skillData.scope
		    occasion = 0
		    speed = skillData.speed;
			repeats=skillData.repeats;
		    animation_id = skillData.animation_id
		    common_event_id = 0
			var arr:Array=splitToArray(skillData.damage);
			setDamage(arr[0],arr[1],arr[2],Boolean(arr[3]));
			 hit_type=skillData.hit_type;
		    mp_cost = skillData.mp_cost;
		    hit = 100;
		    message1 = ""
		    message2 = ""
			
			element_set = splitToArray(skillData.element_set);
			plus_state_set=splitToArray(skillData.plus_state_set);
			minus_state_set=splitToArray(skillData.minus_state_set);
			
			addEffects(skillData.effects.effect);
			addFeatures(skillData.features);
			
			
		}
		
		private function setDamage(type:uint,element:uint=0,variance:int=20,critical:Boolean=true):void{
			
			damage.type=type;
			damage.element_id=element
			damage.critical=critical;
			damage.variance = variance;
		}
		
		private function splitToArray(str:String):Array{
			var arr:Array=[];
			if (str){
				var tempArr:Array=str.split(",");
				for each(var id:int in tempArr){
					arr.push(id);
				}
			}
			
			return arr;
		}
		
		private function addEffects(data:XMLList):void{
			for (var i:int=0;i<data.length();i++){
				var str:String=data[i]
				var arr:Array=str.split(',');
				var effect:Effect=new Effect(uint(arr[0]),uint(arr[1]),Number(arr[2]),Number(arr[3]));
				effects.push(effect);
			}
		}
		
		private function addFeatures(str:String):void{
				var fts:Array=str.split(";");
				for (var i:int=0;i<fts.length;i++){
					
					var arr:Array=str.split(",");
					var ft:Feature=new Feature();
					ft.code=int(arr[0]);
					ft.data_id=int(arr[1]);
					ft.value=Number(arr[2]);
					fts[i]=ft
				}
				features=fts;
			
			
		}
	}
}
