package rpg.vo
{
	/**
	 * 
	 *装备 
	 */
	public class EquipItem extends BaseItem implements IPackItem
	{
		/**価格*/
		private var _price:uint; 
		
		/**
		 * 装備タイプ。
		0 : 武器 
		1 : 盾 
		2 : 頭 
		3 : 身体 
		4 : 鞋
		5 : 装飾品 
		 */
		public var etype_id:uint; 
		
		
		/*** 武器种类  轻 重  物理 魔法 男女 等分类*/
		public var wtype_id:uint; 
		
		
		/*** 防具种类 */
		public var atype_id:uint; 
		
		/**
		 * 能力値変化量。以下の ID を添字とする整数の配列です。
		
		0 : 最大HP 
		1 : 最大MP 
		2 : 攻撃力 
		3 : 防御力 
		4 : 魔法力 
		5 : 魔法防御 
		6 : 敏捷性 
		7 : 運 
		 */
		public var params:Array;
		
		
		/**动画ID*/
		public var animation_id:String;
		
		/**
		 *耐久值  */		
		public var dur:int;
		
		/**
		 * 评价值
		 * 武器としての性能を評価します。最強装備コマンドで使用されます。
			攻撃力 + 魔法力 + 全能力値の合計を返します。
		 *防具としての性能を評価します。最強装備コマンドで使用されます。
			防御力 + 魔法防御 + 全能力値の合計を返します。
		 */
		public var performance :int;
		
		private var _num:int;		
		
		public var flowId:uint;
		
		public function EquipItem()
		{
			super();
			price = 0
			etype_id = 0
			params = [0,0,0,0,0,0,0,0];

		}
		
		public function get isWeapon():Boolean{
			return  (etype_id==0)
		}
		
		public function get isArmor():Boolean{
			return  (etype_id!=0)
		}
		
		public function set price(value:int):void
		{
			_price=value;
			
		}
		
		public function get price():int
		{
			return _price;
		}
		
		public function set num(n:int):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get num():int
		{
			// TODO Auto Generated method stub
			return 1;
		}
		
		public function set key(n:int):void
		{
			flowId=n;
			
		}
		
		public function get key():int
		{
			return flowId;
		}
		
		override public function clone():BaseItem{
			var eq:EquipItem=new EquipItem();
			eq._num=this._num;
			eq._price=this._price;
			eq.animation_id=this.animation_id;
			eq.atype_id=this.atype_id;
			eq.description=this.description;
			eq.dur=this.dur;
			eq.etype_id=this.etype_id;
			eq.features=this.features.concat();
			eq.icon_index=this.icon_index;
			eq.id=eq.id;
			eq.name=eq.name;
			eq.note=eq.note;
			return eq;
		}
	}
}