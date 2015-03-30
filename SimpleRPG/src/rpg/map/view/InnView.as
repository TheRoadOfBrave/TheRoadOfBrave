package rpg.map.view
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	
	import rpg.asset.ImgW;
	
	import skins.BtnSkin;
	
	public class InnView extends Group
	{
		public var background:UIAsset;
		private var label:Label;
		private var label2:Label;
		private var btn:Button;
		private var _gold:int;
		private var PAY:String="pay";
		public function InnView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			background=new UIAsset;
			background.skinName=new ImgW;
			background.height=100;
			
			label=new Label;
			label.x=14;
			label.y=10;
			label.textColor=0xffffff;
			label.text="住宿恢复HP MP"
			
			label2=new Label;
			label2.textColor=0xffffff;
			label2.text="花费 100"
			label2.x=115;
			label2.y=70;
			
			
			btn=new Button;
			btn.width=46;
			btn.height=24;
			btn.skinName=BtnSkin;
			btn.x=40;
			btn.y=70;
			btn.label="住 宿"
		}		
	

		override protected function createChildren():void
		{
			super.createChildren();
			
			
			addElement(background);
			
		
			
			addElement(label);
			addElement(label2);
			
			addElement(btn);
			btn.addEventListener(MouseEvent.CLICK,clickHandler);
			
		}
		
		public function get gold():int
		{
			return _gold;
		}
		
		public function set gold(value:int):void
		{
			_gold = value;
			label2.text="花费："+value;
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(PAY));
		}		
		
		
	}
}