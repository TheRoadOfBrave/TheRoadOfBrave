package rpg.battle.view
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.greensock.easing.RoughEase;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import rpg.Cache;
	import rpg.model.Battler;
	import rpg.model.Troop;
	import rpg.view.BattlerSprite;
	
	public class BattleStage extends Sprite
	{
		private var monsterBox:Sprite;
		private var animationBox:Sprite;
		private var background:Sprite;
		
		public  var  enemySprites:Array=[];
		public var friendSprites:Array=[];
		
		public function BattleStage()
		{
			super();
			init();
		}
		
		private function init():void{
			background=new Sprite;
			background.graphics.beginFill(0xBBBBBB);
			background.graphics.drawRect(0,0,480,320);
			background.graphics.endFill();
			monsterBox=new Sprite;
			animationBox=new Sprite;
			addChild(background);
			addChild(monsterBox);
			addChild(animationBox);
		}
		
		public function dispose():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function clear():void{
			while (monsterBox.numChildren>0){
				monsterBox.removeChildAt(0);
			}
		}
		
		private function createBattler(troop:Troop):Array{
			var battlerArray:Array=[];
			var i:int=1
			for each(var battler:Battler in troop.members){
				var skin:Sprite=Cache.creatBattlerSkin(battler.id) as Sprite;
				if (skin==null){
					skin=Cache.creatBattlerSkin(1) as Sprite;
				}
				
				var battlerSp:BattlerSprite=new BattlerSprite(skin, battler)
				battlerArray.push(battlerSp);
				
				battlerSp.move(180+200*i,60)
				
				i++;
			}
			return battlerArray;
		}
		public function  createFriends(troop:Troop):void{
			friendSprites=createBattler(troop);
			var i:int=1
			for each(var battlerSp:BattlerSprite in friendSprites){
				battlerSp.move(100*i,0)
				
				monsterBox.addChild( battlerSp);
				i++;
			}
			
		}
		
		public function  createEnemies(troop:Troop):void{
			enemySprites=createBattler(troop);
			var i:int=1
			for each(var battlerSp:BattlerSprite in enemySprites){
				battlerSp.move(240*i,180)
				monsterBox.addChild( battlerSp);
				i++;
			}
			
			
		}
		
		public function getFriendSprite(index:int):BattlerSprite{
			return friendSprites[index] as BattlerSprite;
		}
		
		public function getEnemySprite(index:int):BattlerSprite{
			return enemySprites[index-1] as BattlerSprite;
		}
		
		public function searchBattlerSprite(skin:Sprite):BattlerSprite{
			var list:Array=friendSprites.concat(enemySprites);
			var battlerSp:BattlerSprite;
			for each(battlerSp in list){
				if (battlerSp.view==skin){
					return battlerSp;
				}
			}
			if (battlerSp&&battlerSp.view==skin){
				return battlerSp;
			}
			return null;
		}
		
		public function getBattlerSprite(battler:Battler):BattlerSprite{
			var list:Array=friendSprites.concat(enemySprites);
			var battlerSp:BattlerSprite;
			for each(battlerSp in list){
				if (battlerSp.battler==battler){
					return battlerSp;
				}
			}
			if (battlerSp&&battlerSp.battler==battler){
				return battlerSp;
			}
			return null;
		}
		
		
		public function playAnimation(mc:MovieClip,targets:Array):void{
			mc.x=400;
			mc.y=100;
			animationBox.addChild(mc);
			mc.play();
		}
		
		/**
		 * 在battler上播放mc动画
		 * @param battler
		 * @param mc
		 * @param pos 0-头顶 1-正中 2-脚底 
		 * 
		 */
		public function addMcOnSprite(battler:Battler,mc:MovieClip,pos:int=1):void{
			var skin:BattlerSprite=getBattlerSprite(battler);
			trace("播放攻击效果MCa")
			mc.x=skin.x;
			switch(pos){
				case 0:
					mc.y=skin.y-skin.height;
					break;
				case 1:
					mc.y=skin.y-skin.height/2
					break;
				case 2:
					mc.y=skin.y
					break;
				case 3:
					break;
			}
			
			animationBox.addChild(mc);
			//				TweenMax.from(skin, 0.4, 
			//					{ease:RoughEase.create(5, 3, false, Linear.easeNone, "none", false),
			//						colorTransform:{tint:0xffffff, tintAmount:0.3, brightness:1, redMultiplier:1}});
			//	TweenLite.from(skin, 5, {tint:0xffffff,useFrames:true});
		}
		
		public function clearAnimations():void{
			while(animationBox.numChildren>0){
				animationBox.removeChildAt(0);
			}
			
		}
		
		
		private function getTf():TextField{
			
			//listFonts();
			var txt : TextField=new TextField();
			txt.selectable=false;
			txt.autoSize=TextFieldAutoSize.CENTER;
			
			
			var format:TextFormat = new TextFormat("Arial");
			//format.font="myFon"
			
			format.align=TextFormatAlign.CENTER;
			format.color = 0xFFFFFF;
			format.size=18;
			txt.defaultTextFormat=format;
			//txt.embedFonts=true;
			//txt.setTextFormat(format);
			return txt;
		}
		
		private function filte(displayObj:DisplayObject):void{
			var color:Number = 0x000000;
			var thickness:int=2
			var filter:BitmapFilter = new GlowFilter(color,1,thickness,thickness,4);
			displayObj.filters = [filter];
		}
		
		public function showDamage(battler:Battler,damage:int,critical:Boolean=false):void{
			var sp:Sprite=getBattlerSprite(battler);
			var txt : TextField=getTf();
			filte(txt);
			txt.text=damage.toString();
			txt.x=sp.x-txt.width/2;
			txt.y=sp.y-sp.height/2;
			if (critical)txt.textColor=0xff0000;
			animationBox.addChild(txt);
			TweenLite.to(txt,0.8,{y:"-60",alpha:0.1,ease:Cubic.easeIn});
			TweenMax.from(sp,0.6,{x:sp.x+1,y:sp.y-1,ease:RoughEase.create(12, 4, false, Linear.easeNone, "none", false)});
			TweenMax.from(sp, 0.4, 
				{ease:RoughEase.create(5, 3, false, Linear.easeNone, "none", false),
					colorTransform:{tint:0xffffff, tintAmount:0.3, brightness:1, redMultiplier:1}});
			//TweenLite.from(sp,1,{x:sp.x+5,y:sp.y+5,ease:Bounce.easeInOut});
			
		}
		
	}
}