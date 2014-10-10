package rpg.vo
{
	public class DropItem
	{
		/**
		 *種類。
		0 : なし 1 : アイテム 2 : 武器 3 : 防具 
		 */
		public var kind:uint 
		
		/**
		ドロップアイテムの種類に応じたデータ (アイテム、武器、防具) の ID。
		 */
		public var id:uint; 
		
		//出現率 1/N の分母 N
		public var denominator :uint=1;
		

		public function DropItem(kind:uint=0,id:uint=1,den:uint=1):void
		{
			this.kind=kind;
			this.id=id;
			this.denominator=den;
		}
	}
}