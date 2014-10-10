package rpg.view
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.managers.ToolTipManager;
	
	import rpg.model.Battler;

	public class BattlerSpriteBase extends Sprite
	{	
		
		public var view:DisplayObject;
		public var battler:Battler
		public var oPoint:Point
		
		
		private var curDisplayObj:DisplayObject;
		
		public function BattlerSpriteBase(view:DisplayObject,battler:Battler=null)
		{
			this.view=view ;
			this.battler=battler;
			addChild(view);
			
			init()
		}
		
		public function get index():int{
			var myIndex:int=-1
			if (battler!=null){
				myIndex=battler.index;
			}
			return myIndex
		}
		
		
		
		private function init():void{	
			//this.addChild(view);
			//this.mouseChildren=false;
//			if (view.numChildren>1){
//				for(var i:int=1;i<view.numChildren;i++){
//					view.getChildAt(i).visible=false;
//				}
//			}
//			
			//ToolTipManager.registerToolTip(this, "oldValue", "value");
			view.name="member"+index;
		}
		
		public function move(x:Number,y:Number):void{
			this.x=x;
			this.y=y;
		}
		
		public function update():void{
//			if (curAct!=NORMAL){
//				var mc:MovieClip=view as MovieClip;
//				if (mc.currentFrame>100){
//					trace("动作结束")
//					endAct();
//				}
//				
//				
//			}
			collapse()
		}
		
		private function collapse():void{
			if (battler.collapse){
				TweenLite.to(this.view,1,{alpha:0});	
				battler.collapse=false;
				
			}
		}
		public function revert_to_normal():void{
			
		}
		
		public function playAct():void{
		
		}
	
	//设置动作，原来显示图片隐藏，更新为新动作的图片	
		private function play(actName:String):Boolean{
			var act_mc:Sprite
//			var mc:MovieClip=view as MovieClip;
//			if (actName==NORMAL){
//				mc.gotoAndStop(1);
//				
//			}else{
//				mc.gotoAndPlay(actName);
//				curAct=actName;
//			}
			
			return false;
		}
		
		public function endAct():void{
			
		}
		
	
		
		
	}
}