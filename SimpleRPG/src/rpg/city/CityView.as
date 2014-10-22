package rpg.city
{
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	
	import rpg.Cache;
	
	public class CityView extends Group
	{
		public var goBtn:Button;
		private var uibox:UIComponent;
		public function CityView()
		{
			super();
			init();
		}
		
		
		private function init():void
		{
			width=480;
			height=300;
			var asset:UIAsset=new UIAsset;
			asset.skinName=Cache.getBackground(0);
			addElement(asset);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			goBtn=new Button;
			goBtn.label="出发"
			goBtn.id="goBtn"
			addElement(goBtn);
		}
		
	}
}