package rpg.map
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	import rpg.Cache;
	
	public class ZoneView extends Group
	{
		private var background:UIAsset;
		private var btn:Button;
		private var _moveable:Boolean;
		public function ZoneView()
		{
			super();
			init();
		}
		
	

		private function init():void
		{
			background=new UIAsset;
			background.skinName=Cache.getBackground(1);
			addElement(background);
			
			btn=new Button;
			btn.width=50;
			btn.height=50;
			btn.x=420;
			btn.y=250;
			btn.label="前进"
			addElement(btn);
			btn.addEventListener(MouseEvent.CLICK,goHandler);
		}
		
		public function get moveable():Boolean
		{
			return _moveable;
		}
		
		public function set moveable(value:Boolean):void
		{
			_moveable = value;
			btn.visible=moveable;
		}
		
		protected function goHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("go",false));
		}
		
		public function setBackground(id:int):void{
			background.skinName=Cache.getBackground(id);
		}
		
		public function go(bg:int,moveable:Boolean):void{
			setBackground(bg);
			this.moveable=moveable
		}
		
	}
}