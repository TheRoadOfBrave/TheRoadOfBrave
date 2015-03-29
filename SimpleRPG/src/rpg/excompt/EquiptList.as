package rpg.excompt
{
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	import rpg.view.irender.EqueitRender;
	
	import skins.EqListSkin;
	
	public class EquiptList extends List
	{
		public function EquiptList()
		{
			super();
			init();
		}
		
		private function init():void{
	
			itemRenderer=EqueitRender;
			var layout:VerticalLayout = new VerticalLayout;
			layout.gap = 2;
			layout.horizontalAlign = HorizontalAlign.CONTENT_JUSTIFY;
			this.layout = layout;
			skinName=EqListSkin;
		}
		
		
		
		public function getRender(index:int):EqueitRender{
			var render:EqueitRender=dataGroup.getElementAt(index) as EqueitRender;
			
			return render;
		}
		
		public function playRender(item:Object):void{
			var index:int=dataProvider.getItemIndex(item);
			var eqRender:EqueitRender=getRender(index);
		//	selectedIndex=-1;
			//equipList.updateRenderer(
			if (eqRender){
				trace(eqRender.y);
				eqRender.play();
				ArrayCollection(dataProvider).itemUpdated(item);
				
			}
		}
		
	}
}