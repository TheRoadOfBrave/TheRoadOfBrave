package rpg.vo
{
	public class MonsterVo extends BaseItem
	{
	    public var battler_name:String
	    public var battler_hue:Number;
	    public var maxhp:int
	    public var maxmp:int
	   public var params:Array = [100,0,10,10,10,10,10,10];

	   
	    public var exp:Number;
	    public var gold:Number
	    public var drops:Array;
	    public var levitate:Boolean
	    public var has_critical:Boolean
	    public var element_ranks:String;
	    public var state_ranks:String;
	    public var actions:Array;

		public function MonsterVo(monster_xml:XML){
			init(monster_xml)
		}
		
		private function init(data:XML):void{
			id = data.id;
		    name = data.name
		    battler_name = data.battler_name
		    battler_hue = data.battler_hue
		    maxhp = data.maxhp
		    maxmp = data.maxmp
	
			params=splitToArray(data.params)
		      exp = data.exp
		      gold = data.gold
		      levitate = Boolean(data.levitae);
		      has_critical = Boolean(data.has_critical);
		      element_ranks = data.element_ranks;
		      state_ranks = data.state_ranks;
		   //   actions = data.actions;
		      note = data.note
			//  addFeatures(data.features.feature);
			actions=[];
				  addActions(data.actions.action);
			drops=[];
			  addDropItems(data.drops);
		}
		
		//获取属性修正值
		public function getElementRate(element_id:int):int{
			var rank:String = element_ranks.charAt(element_id-1);
			var rankRate:Object={A:200,B:150,C:100,D:50,E:0,F:-100}
			//undefined会转为0
			var result:int = rankRate[rank];
			return result
		}
		
		private function splitToArray(str:String):Array{
			var arr:Array=[];
			if (str){
				var tempArr:Array=str.split(",");
				for each(var v:int in tempArr){
					arr.push(v);
				}
			}
			
			return arr;
		}
		
		private function addFeatures(data:XMLList):void{
			for (var i:int=0;i<data.length();i++){
				var str:String=data[i]
				var arr:Array=str.split(',');
				var feature:Feature=new Feature(arr[0],arr[1],arr[2]);
				features.push(feature);
			}
		}
		
		private function addActions(data:XMLList):void{
			for (var i:int=0;i<data.length();i++){
				var str:String=data[i]
				var arr:Array=str.split(',');
				var action:ActionVo=new ActionVo(arr[0],arr[1]);
				action.condition_type=arr[2];
				action.condition_param1=Number(arr[3]);
				action.condition_param2=Number(arr[4]);
				actions.push(action);
			}
		}
		
		private function addDropItems(data:XMLList):void{
			for (var i:int=1;i<4;i++){
				var dropItem:DropItem=new DropItem(1,i);
				drops.push(dropItem);
			}
		}
	}
}