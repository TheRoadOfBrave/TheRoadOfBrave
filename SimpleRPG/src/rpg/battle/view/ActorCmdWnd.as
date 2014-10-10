package rpg.battle.view
{
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	import rpg.events.GameEvent;
	import rpg.vo.Skill;
	
	public class ActorCmdWnd extends Group
	{
		public static const SELECT_ACTION:String="select_action";
		private var btns:Vector.<Button>
		public function ActorCmdWnd()
		{
			super();
			var hlayout:HorizontalLayout=new HorizontalLayout;
			hlayout.gap=2;
			hlayout.horizontalAlign=HorizontalAlign.RIGHT;
			this.layout=hlayout;
			
			this.addEventListener(MouseEvent.CLICK,clickBtnHandler);
			
			
		}
		
		protected function clickBtnHandler(event:MouseEvent):void
		{
			var btn:Button=event.target as Button;
			if (btn){
				var evt:GameEvent=new GameEvent(SELECT_ACTION,int(btn.id),true);
				dispatchEvent(evt);
			}
			
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			btns=new Vector.<Button>();
			for (var i:int = 0; i < 9; i++) 
			{
				var btn:Button=new Button;
				btn.width=50;
				btn.height=50;
				btns.push(btn);
			}
		}
		
		
		
		public function showCmdBtns(arr:Array):void{
			for (var i:int = 0; i < arr.length; i++) 
			{
				var skill:Skill=arr[i]
				var btn:Button=btns[i];
				btn.id=skill.id.toString();
				btn.label=skill.name;
				addElement(btn);
			}
			
			
		}
	}
}