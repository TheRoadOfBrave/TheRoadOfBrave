package rpg.map.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.core.UIComponent;
	
	import rpg.asset.ChestMc;
	
	public class Chest extends UIComponent
	{
		public var mc:MovieClip
		public static var OPEN:String="open";
		public var items:Array;
		public var itemList:List;
		public function Chest()
		{
			super();
			mc=new ChestMc;
			mc.scaleX=mc.scaleY=2;
			mc.stop();
			addChild(mc);
			this.addEventListener(MouseEvent.CLICK,open);
			itemList=new List;
		}
		
		public function setItems(arr:Array):void{
			items=arr;
			itemList.dataProvider=new ArrayCollection(arr);
		}
		
		public function open(event:MouseEvent):void{
			mc.play();
			dispatchEvent(new Event(OPEN));
		}
		
	}
}