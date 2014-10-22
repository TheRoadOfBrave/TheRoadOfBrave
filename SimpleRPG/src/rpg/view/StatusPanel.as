package rpg.view
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	
	import mx.collections.ArrayList;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.components.Panel;
	import org.flexlite.domUI.components.SkinnableContainer;
	import org.flexlite.domUI.core.UIComponent;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	import rpg.Cache;
	import rpg.model.Actor;
	import rpg.view.irender.EqueitRender;
	import rpg.vo.RpgState;
	
	import skins.EqItemSkin;
	import skins.EqListSkin;
	
	public class StatusPanel extends Group
	{
	
		public var name_lb:Label;
		public var hp_lb:Label;
		public var mp_lb:Label;
		private var _hero:Actor;
		private var hpBar:ValueBar;
		private var mpBar:ValueBar;
		private var expBar:ValueBar;
		
		private var paramLbs:Vector.<Label>;
		private var paramValueLbs:Vector.<Label>;
		
		public var eqArrc:ArrayCollection;
		private var equipList:List;
		
		private var uibox:UIComponent;
		public function StatusPanel()
		{
			super();
			init();
		}
		
		

		private function init():void
		{
			var c:uint=0xAAAAAA;
			var r:int=5;
			drawRect(0,0,480,300,0x663300);
			drawRect(5,5,220,90,c,r);
			drawRect(5,120,240,200,c,r);
			drawRect(280,5,200,200,c,r);
			drawRect(280,250,200,25,c,r);
			
			
			hpBar=new ValueBar(100,4,0x00ff00);
			hpBar.x=36;
			hpBar.y=32;
			mpBar=new ValueBar(100,4,0x0000ff);
			mpBar.x=36;
			mpBar.y=52;
			expBar=new ValueBar(480,4,0x993300);
			expBar.x=0;
			expBar.y=0;
			
			uibox=new UIComponent;
			addElement(uibox);
			uibox.addChild(hpBar);
			uibox.addChild(mpBar);
			uibox.addChild(expBar);
			
//			var bit:Bitmap=new Bitmap(Cache.getIcon(2));
//			uibox.addChild(bit);
			name_lb=new Label;
			name_lb.x=5;
			name_lb.y=5;
			addElement(name_lb);
			
			hp_lb=new Label;
			hp_lb.x=5;
			hp_lb.y=5;
			addElement(hp_lb);
			
			mp_lb=new Label;
			mp_lb.x=5;
			mp_lb.y=5;
			addElement(mp_lb);
			
			var group2:Group=new Group;
			group2.x=10;
			group2.y=100;
			paramLbs=new Vector.<Label>(6);
			paramValueLbs=new Vector.<Label>(6);
			for (var i:int = 0; i < 6; i++) 
			{
				var lb:Label=new Label;
				lb.x=20;
				lb.y=30*i
				paramLbs.push(lb);
				
				var lb2:Label=new Label;
				lb2.x=120;
				lb2.y=30*i;
				lb2.text="0"
				paramLbs[i]=lb;
				paramValueLbs[i]=lb2;
				group2.addElement(lb);
				group2.addElement(lb2);
			}
			
			addElement(group2);
			
			paramLbs[0].text="攻击力"
			paramLbs[1].text="防御力"
			paramLbs[2].text="魔攻"
			paramLbs[3].text="魔防"
			paramLbs[4].text="敏捷"
			paramLbs[5].text="幸运"
				
			equipList=new List;
			equipList.width=220;
			equipList.height=200;
			equipList.y=35;
			equipList.x=280
		equipList.itemRenderer=EqueitRender;
		//	equipList.skinName=EqItemSkin;
		
			var layout:VerticalLayout = new VerticalLayout;
			layout.gap = 2;
			layout.horizontalAlign = HorizontalAlign.CONTENT_JUSTIFY;
			equipList.layout = layout;
			
			addElement(equipList);
		}
		
		public function get hero():Actor
		{
			return _hero;
		}
		
		public function set hero(value:Actor):void
		{
			_hero = value;
			eqArrc=new ArrayCollection(_hero.equips);
			equipList.dataProvider=eqArrc;
			update();
		}
		
		private function drawRect(x:Number,y:Number,w:Number,h:Number,c:uint,r:Number=0):void{
			var g:Graphics=this.graphics;
			g.beginFill(c,1);
			if (r>0){
				g.drawRoundRect(x,y,w,h,r)
			}else{
				g.drawRect(x,y,w,h);
			}
			g.endFill();
		}
		
		public function refreshEquipt():void{
			eqArrc.refresh();
		}
		
		public function update():void{
			name_lb.text=hero.battler_name;
			hp_lb.text=hero.hp+"/"+hero.mhp;
			mp_lb.text=hero.mp+"/"+hero.mmp;
			//state_lb.text=actor.stateIdList.toString();
			
			hpBar.setValue(hero.hp,hero.mhp);
			mpBar.setValue(hero.mp,hero.mmp);
			if (hpBar.percent>0.6){
				hpBar.color=0x00ff00;
			}else if (hpBar.percent>0.3){
				hpBar.color=0xffff00;
			}else{
				hpBar.color=0xff0000;
			}
			
			expBar.setValue(hero.exp,hero.next_level_exp);
//			state_lb.text=""
//			for each (var i:RpgState in actor.states){
//				state_lb.text+=i.name+"、";
//			}
//			stateList.dataProvider=new ArrayList(actor.states);
			
			for (var i:int=0;i<6;i++){
				var obj:Object={};
				obj.base=hero.param_base(2+i);
				obj.value=hero.param(2+i);
				paramValueLbs[i].text=obj.base+obj.value;
			}
		}
		
		
	}
}