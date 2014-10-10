package rpg.battle.view
{
	import flash.display.Sprite;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	
	public class MessageBox extends Group
	{
		private var label:Label;
		public function MessageBox()
		{
			super();
			init();
		}
		
		private function init():void{
			graphics.beginFill(0x111111,0.6);
			graphics.drawRect(0,0,480,20);
			graphics.endFill();
			
			label=new Label;
			label.x=10;
			label.y=2;
			label.textColor=0xFFFFFF;
			addElement(label);
		}
		
		public function showMsg(str:String):void{
			label.text=str;
		}
	}
}