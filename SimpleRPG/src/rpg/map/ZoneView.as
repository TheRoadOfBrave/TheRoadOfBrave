package rpg.map
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.graphics.ImageSnapshot;
	
	import mk.TweenMac;
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.components.Panel;
	import org.flexlite.domUI.components.SkinnableContainer;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	import org.flexlite.domUI.utils.callLater;
	
	import rpg.Cache;
	import rpg.GameSound;
	import rpg.map.view.Chest;
	import rpg.map.view.InnView;
	import rpg.util.UIUtil;
	
	public class ZoneView extends Group
	{
		private var background:UIAsset;
		private var btn:Button;
		private var _moveable:Boolean;
		private var backgroundBox:UIComponent;
		public var inn:InnView;
		private var window:Group;
		private var canvas:UIComponent;
		public function ZoneView()
		{
			super();
			init();
		}
		
	

		private function init():void
		{
			background=new UIAsset;
			background.skinName=Cache.getBackground(1);
			background.x=-80;
			addElement(background);
			
			backgroundBox=new UIComponent;
			backgroundBox.x=-80;
			addElement(backgroundBox);
			
			btn=new Button;
			btn.width=50;
			btn.height=50;
			btn.x=420;
			btn.y=250;
			btn.label="前进"
			addElement(btn);
			btn.addEventListener(MouseEvent.CLICK,goHandler);
			
			
			inn=new InnView;
			inn.x=110;
			inn.y=108;
			window=new Group;
			addElement(window);
			canvas=new UIComponent;
			addElement(canvas);
		}
		
		public function get moveable():Boolean
		{
			return _moveable;
		}
		
		public function set moveable(value:Boolean):void
		{
			_moveable = value;
			btn.visible=moveable;
		}
		
		protected function goHandler(event:MouseEvent):void
		{
			clearWindow();
			dispatchEvent(new Event("go",false));
		}
		
		public function setBackground(id:int):void{
			background.skinName=Cache.getBackground(id);
		}
		
		public function go(bg:int,moveable:Boolean):void{
			playChangeStage(bg);
		}
		
		public function arrive():void{
			dispatchEvent(new Event("arrive",false));
		}
		
		
		public function playChangeStage(id:int):void{
			var bmd:BitmapData=DisplayUtil.captureBitmapData(background);
			var bmp:Bitmap=new Bitmap(bmd);
			var bg:BitmapData=Cache.getBackground(id)
			var bmp2:Bitmap=new Bitmap(bg);;
			backgroundBox.addChild(bmp);
			backgroundBox.addChild(bmp2);
			background.visible=false;
			TweenLite.to(bmp,0.6,{z:-100,alpha:0.5,ease:Linear.easeNone,onComplete:end});
			bmp2.alpha=0;
			bmp2.y=-80;
			bmp2.z=160;
			TweenLite.to(bmp2,0.6,{delay:0.5,x:0,z:0,y:0,alpha:1,ease:Linear.easeNone,onComplete:end2});
			function end():void{
				//backgroundBox.swapChildren(bmp,bmp2);
				//bmp.alpha=0;
				//backgroundBox.swapChildren(bmp,bg);
				
			}
			function end2():void{
				background.visible=true;
				while(backgroundBox.numChildren>0){
					backgroundBox.removeChildAt(0);
				}
				setBackground(id);
				this.moveable=moveable
					arrive();
			}
		}
		
		/**
		 *显示宝箱 
		 * @param items
		 * 
		 */
		private var chest:Chest
		public function showChest(items:Array):void{
			chest=new Chest;
			chest.setItems(items);
			chest.x=240;
			chest.y=210;
			chest.addEventListener(Chest.OPEN,openChest);
			window.addElement(chest);
		}
		
		protected function openChest(event:Event):void
		{
			var panel:SkinnableContainer=chest.panel;
			
			//list.alpha=0;
			panel.x=chest.x-100;
			panel.y=chest.y-150;
			window.addElement(panel);
			panel.visible=false;
		//	list.scaleX=list.scaleY=0.1;
			GameSound.getInstance().playChest();
			callLater(function ():void{
				new TweenMac(panel,canvas,true).from(chest.x,chest.y-22,0.4);
			})
			
		//	TweenLite.to(list,0.8,{x:200,y:60,alpha:1,scaleX:1,scaleY:1});
			
			
		}
		
		public function clearWindow():void{
			UIUtil.clear(window);
			DisplayUtil.clear(canvas);
			canvas.graphics.clear();
		}
		
		public function showInn(gold:int):void{
			inn.gold=gold;
			window.addElement(inn);
		}
		
		public function showShop():void{
			
		}
		
		public function showPub():void{
			
		}
		
		
	}
}