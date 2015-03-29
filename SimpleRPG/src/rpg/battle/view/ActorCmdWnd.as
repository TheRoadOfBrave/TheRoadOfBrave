package rpg.battle.view
{
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Spacer;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	import rpg.events.GameEvent;
	import rpg.vo.Skill;
	
	public class ActorCmdWnd extends Group
	{
		public static const SELECT_ACTION:String="select_action";
		private var btns:Vector.<Button>
		private var max:int=9;
		public function ActorCmdWnd()
		{
			super();
//			var hlayout:HorizontalLayout=new HorizontalLayout;
//			hlayout.gap=2;
//			hlayout.horizontalAlign=HorizontalAlign.LEFT;
//			this.layout=hlayout;
			
			this.addEventListener(MouseEvent.CLICK,clickBtnHandler);
			left=2;			
			
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
			for (var i:int = 0; i < max; i++) 
			{
				var btn:Button=new Button;
				if (i<max-1){
					btn.width=50;
					btn.height=50;
					btn.x=52*i
				}else{
					btn.width=90;
					btn.height=46;
					btn.right=2;
					btn.y=2;
					btn.id="4";
					btn.label="逃 跑"
				}
			
				
				btns.push(btn);
			}
		}
		
		
		
		public function showCmdBtns(arr:Array):void{
			for (var i:int = 0; i < max; i++) 
			{
				var skill:Skill=arr[i]
				if (skill){
					var btn:Button=btns[i];
					btn.id=skill.id.toString();
					btn.label=skill.name;
					addElement(btn);
				}else if(i==max-2){
					addElement(btns[max-1]);
				}
			
				
			}
			
			
		}
	}
}