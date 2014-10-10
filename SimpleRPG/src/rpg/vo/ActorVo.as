package rpg.vo
{
	public class ActorVo extends BaseItem
	{
	    public var battler_name:String
	    public var battler_hue:Number;
	    public var maxhp:int
	    public var maxmp:int
		public var params:Array = [100,0,10,10,10,10,10,10];
	   
	    public var exp:Number;
	    public var gold:Number
	    public var drop_item1:XML,drop_item2:XML
	    public var levitate:Boolean
	    public var has_critical:Boolean
	    public var element_ranks:XML
	    public var state_ranks:XML
	    public var actions:XML
		public var skills:Array;
		
		//二つ名。
		public var nickname :String
		
//		職業 ID。
		public var class_id :int
		
//		初期レベル。
		public var initial_level :int
		
//		最高レベル。
		public var max_level :int
		
//		歩行グラフィックのファイル名。
		public var character_name :String
		
//		歩行グラフィックのインデックス (0..7) 。
		public var character_index :int
		
//		顔グラフィックのファイル名。
		public var face_name :String
		
//		顔グラフィックのインデックス (0..7) 。
		public var face_index :int
		
		/**
		 *初期装備。以下を添字とする、武器 ID または防具 ID の配列です。

			0 : 武器 
			1 : 盾 
			2 : 頭 
			3 : 身体 
			4 : 装飾品 
			 
		 */
		public var equips :Array;

		
		
		
		
		
		
		
		public function ActorVo(xml:XML){
			init(xml)
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
		      drop_item1 = data.drop_item[0]
		      drop_item2 = data.drop_item[1]
		      levitate = Boolean(data.levitae);
		      has_critical = Boolean(data.has_critical);
		    //  element_ranks = data.element_ranks;
		    //  state_ranks = data.state_ranks;
		   //   actions = data.actions;
		      note = data.note
			skills=splitToArray(data.skills);
			addFeatures(data.features.feature);
			
			
			nickname = ''
			class_id = 1
			initial_level = 1
			max_level = 99
			character_name = data.battler_name
			character_index = data.character_index
			face_name = ''
			face_index = data.face_index
			equips = [0,0,0,0,0]

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
	}
}