package rpg.view
{
	import com.greensock.TweenLite;
	
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	
	public class Dialog extends Group
	{
		private var _text:String="";
		private var _isEnd:Boolean;
		private var line:int=5
			
		private var label:Label;
		private var timeId:uint;
		private var tween:TweenLite;
		public function Dialog()
		{
			super();
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			graphics.beginFill(0x111111,0.6);
			graphics.drawRect(0,0,480,80);
			graphics.endFill();
			
			label=new Label;
			label.x=10;
			label.y=2;
			label.textColor=0xFFFFFF;
			label.htmlText=""
			addElement(label);
			mouseEnabledWhereTransparent=false;
			this.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			if (tween) tween.kill();
			alpha=1;
			hide();
		}		
		
		
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(str:String):void
		{
			_text = str;
//			ta.text=str;
//			ta.htmlText=str;
//			ta.verticalScrollPosition=0;
//			
		//	label.text+=str+"\n";
			label.htmlText+=str+"\n";
//			if (label.maxScrollV>4){
//				label.text=str+"\n";
//			}
			_isEnd=false;	
			if (tween) tween.kill();
			alpha=1;
//			clearTimeout(timeId);
//			timeId=setTimeout(hide,5000);
			tween=TweenLite.to(this,1,{delay:4,alpha:0,onComplete:hide});
		}
		
		public function clear():void
		{
			label.text="";
			
		}
		
		public function get isEnd():Boolean
		{
			
			return _isEnd;
		}
		
		public function hide():void{
			_isEnd=true;
			clear();
			visible=false;
		}
		
	}
}