package rpg.battle.view
{
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	
	public class BattleView extends Group
	{
		public var battleStage:BattleStage;
		public var msgBox:MessageBox;
		public var actorWnd:ActorWnd;
		public var actorWnd2:ActorWnd;
		public var cmdWindow:ActorCmdWnd;
		public function BattleView()
		{
			super();
			init();
		}
		
		private function init():void{
			var canvas:UIComponent=new UIComponent;
			battleStage=new BattleStage();
			canvas.addChild(battleStage);
			addElement(canvas);
			
			cmdWindow=new ActorCmdWnd;
			cmdWindow.width=475;
			cmdWindow.y=270;
			
			msgBox=new MessageBox;
			msgBox.y=250;
			
			msgBox.visible=false;
			
			addElement(cmdWindow);
			addElement(msgBox);
		}
		
		public function reset():void
		{
			//battleStage.clear();
			//msgWindow.clear();
			
		}
		
		public function showMsg(str:String):void{
			msgBox.showMsg(str);
		}
		
		public function showResultBox(items:Array):void
		{
//			items=items.map( 
//				function(item :BaseItem, index :int, arr :Array) :ObjectProxy{
//					var obj:ObjectProxy=new ObjectProxy({item:item,sell:false});
//					return obj;}
//			)
//			var arrList:ArrayList=new ArrayList(items);
//			resultbox.arrList=arrList;
//			addElement(resultbox);
			
		}
		
		public function hideResultBox():void{
//			if (containsElement(resultbox)){
//				removeElement(resultbox);
//			}
		}
		
		protected function partyCmdWnd_clickHandler(event:MouseEvent):void
		{
			
		}
		
		//显示角色指令窗
		public function showCommandWindow():void{
			cmdWindow.mouseEnabled=false;
			cmdWindow.mouseChildren=true;
			
			cmdWindow.visible=true
			msgBox.visible=true;
			msgBox.showMsg("请选择你的行动");
			//cmdWindow.playShow();
			
		}
		
		public function hideCommandWindow():void{
			cmdWindow.visible=false;
			msgBox.visible=true;
		}
		
		public function dispose():void
		{
			battleStage.dispose();
			
		}
		
		
	}
}