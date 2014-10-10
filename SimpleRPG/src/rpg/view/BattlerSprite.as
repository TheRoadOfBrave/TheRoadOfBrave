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

	public class BattlerSprite extends BattlerSpriteBase
	{	
		public static const NORMAL:String = "stand";
		public static const ATTACK:String = "attack";
		public static const SKILL:String = "skill";
	
		
		
		private var curDisplayObj:DisplayObject;
		public var curAct:String;
		public function BattlerSprite(view:DisplayObject,battler:Battler=null)
		{
			super(view,battler);
			
			setCurDisplay(NORMAL);
			init()
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
		
	
		
	
		
		public function collapse():void{
			if (battler.collapse){
				TweenLite.to(this.view,1,{alpha:0});	
				battler.collapse=false;
				
			}
		}
		override  public function revert_to_normal():void{
			
		}
		override public function playAct():void{
			trace("行动动画播放")
			playAttack()
		}
	
	//设置动作，原来显示图片隐藏，更新为新动作的图片	
		private function setCurDisplay(actName:String):Boolean{
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
		
		override public function endAct():void{
			setCurDisplay(NORMAL)
		}
		
		public function playAttack():int{
			var isAct:Boolean=setCurDisplay(ATTACK)
			if (isAct==false){
//				TweenLite.from(this,1,{alpha:0.1});	
			}
			
			return 20;
		}
		
		
	}
}