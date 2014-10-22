package rpg.shop.view
{
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.components.Panel;
	import org.flexlite.domUI.components.TitleWindow;
	
	import rpg.manager.WindowManager;
	
	
	public class ShopView extends TitleWindow
	{
		
		public var list:List;
		public var dpArr:ArrayCollection;
		public function ShopView()
		{
			init();
			this.width=300;
			this.height=280;
			this.left=20;
		}
		
		private function init():void
		{
			this.title="商 店"
			list=new List;
			list.top=10;
			list.left=10;
			list.right=10;
			
			list.height=200;
			list.y=30;
			list.x=10
			list.itemRenderer=ItemRender;
			list.dataProvider=dpArr;
			addElement(list);
		}
		
		override protected function closeButton_clickHandler(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.closeButton_clickHandler(event);
			WindowManager.closeAllWindow();
		}
		
		
		
	}
}