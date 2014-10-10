package rpg.view
{
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.TextArea;
	
	public class Dialog extends Group
	{
		private var _text:String="";
		private var _isEnd:Boolean;
		private var line:int=5
			
		private var ta:TextArea;
		public function Dialog()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			ta=new TextArea;
			addElement(ta);
		}
		
		
		
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(str:String):void
		{
			_text = str;
			ta.text=str;
//			ta.htmlText=str;
//			ta.verticalScrollPosition=0;
//			
			_isEnd=false;	
			//	
		}
		public function get isEnd():Boolean
		{
			
			return _isEnd;
		}
	}
}