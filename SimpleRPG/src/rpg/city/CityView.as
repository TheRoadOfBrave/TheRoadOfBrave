package rpg.city
{
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	
	public class CityView extends Group
	{
		public var goBtn:Button;
		public function CityView()
		{
			super();
			init();
		}
		
		
		private function init():void
		{
			width=480;
			height=300;
			
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