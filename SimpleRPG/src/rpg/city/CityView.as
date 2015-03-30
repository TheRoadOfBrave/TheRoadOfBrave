package rpg.city
{
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	
	import rpg.Cache;
	
	import skins.BtnSkin;
	import skins.HardBtnSkin;
	
	public class CityView extends Group
	{
		public var goBtn:Button;
		public var shopBtn:Button;
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
			goBtn.x=240;
			goBtn.y=100;
			goBtn.skinName=HardBtnSkin;
			addElement(goBtn);
			
			shopBtn=new Button;
			shopBtn.label="商店"
			shopBtn.id="shopBtn"
				shopBtn.x=50;
				shopBtn.y=150;
			shopBtn.width=64;
			shopBtn.height=26;
			shopBtn.skinName=BtnSkin;
			addElement(shopBtn);
		}
		
	}
}