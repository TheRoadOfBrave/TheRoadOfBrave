package rpg.vo {
	import flash.events.EventDispatcher;

	/**
	 * 具有物品特性的基类
	 */
	[Bindable]
	public class BaseItem extends EventDispatcher {
		/**
		 * 物品的 ID 编号。
		 */
		public var id:int;
		/**
		 *物品的名称。物品的图标索引号。 
		 */
		public var icon_index :int; 
		public var name:String;
		/**
		 *description 物品的说明文字。 
		 */
		public var description:String;
		/**
		 *note 物品的备注。 
		 */
		public var note:String ; 
		
		//特徴リスト。RPG::BaseItem::Feature の配列です。
		public var features:Array;
		public function BaseItem():void {
		  id = 0;
	      name = "";
	      icon_index = 0;
		  features=[];
	      description = "";
	      note = "";
			
		}
		
		public function clone():BaseItem{
			return null;
		}
		
		
	}
}
