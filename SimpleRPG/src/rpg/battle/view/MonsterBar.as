package rpg.battle.view
{
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.core.UIComponent;
	
	import rpg.model.Monster;
	import rpg.view.ValueBar;
	
	public class MonsterBar extends Group
	{
		public  var nameLb:Label;
		public var hpBar:ValueBar;
		private var _monster:Monster;
		public function MonsterBar()
		{
			init();
		}
		
		
		private function init():void
		{
			nameLb=new Label;
			nameLb.x=5;
			nameLb.y=4;
			addElement(nameLb);
			hpBar=new ValueBar(100,4);
			hpBar.x=200;
			hpBar.y=4;
			var uibox:UIComponent=new UIComponent
			uibox.addChild(hpBar);
			addElement(uibox);
			
		}
		
		public function get monster():Monster
		{
			return _monster;
		}
		
		public function set monster(value:Monster):void
		{
			_monster = value;
			update();
		}
		
		public function update():void{
			nameLb.text=_monster.battler_name;
			hpBar.setValue(_monster.hp,_monster.mhp);
		}

		
	}
}