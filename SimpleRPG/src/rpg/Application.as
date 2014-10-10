package rpg
{
	import org.flexlite.domCore.Injector;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.managers.SystemManager;
	import org.flexlite.domUI.skins.themes.VectorTheme;
	import org.flexlite.domUtils.Debugger;
	
	import rpg.city.CityView;
	import rpg.dialog.DialogBox;
	import rpg.manager.WindowManager;
	import rpg.model.Party;
	import rpg.view.Dialog;
	
	public class Application extends SystemManager
	{
		private var top:Group;
		private var windowBox:Group;
		private var city:CityView;
		public var battleView:Group;
		private var battleGroup:Group;
		public var dialog:Dialog;
		
		//当前游戏场景 标识
		public var scene:String;
		public function Application()
		{
			super();
			Injector.mapClass(Theme,VectorTheme);//这里一次性注入所有组件的默认皮肤。正式项目中不需要默认皮肤,应当自定义主题。
			Debugger.initialize(stage);//显示列表调试工具(可选)。
			init();
			
			
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
		}
		
		
		private function init():void{
			windowBox=new Group;
			battleGroup=new Group;
			city=new CityView;
			
			dialog=new Dialog;
			addElement(city);
			addElement(battleGroup);
			
			addElement(windowBox);
			
			var wndManager:WindowManager=WindowManager.getInstance()
			WindowManager.container=windowBox;
		}
		
		public function setup():void{
			var party:Party=Party.getInstance();
			party.setup(1);
			party.recover_all();
			party.gold=1000;
			party.food=10;
			//	learnWindow.actors=new ArrayList(party.actors);
			//				battleScene.setupParty(party);
			//				battleScene.setup();
			/* party.bag.gainItemById(1,2);
			party.bag.gainItemById(2,5);
			var actor:rpg.model.Actor=party.actors[0];
			var weapon:EquipItem=db.getWeapon(1);
			for (var i:int=0;i<10;i++){
			weapon=db.getWeapon(1);
			party.bag.gainItem(weapon,1);
			}
			*/
			//actor.change_equip(0, weapon);
			//actor.gain_exp(50);
			
			
		}
		
		public function gotoScene(scene:String):void{
			switch(scene)
			{
				case WindowConst.SCENE_BATTLE:
					battleGroup.addElement(battleView);
					break;
				case WindowConst.SCENE_CITY:
					
					battleGroup.removeAllElements();
					city.visible=true;
					break;
				case WindowConst.SCENE_MAP:
					
					battleGroup.removeAllElements();
					city.visible=false;
					break;
				default:
					break;
			}
		}
		
		
		
		public function get needDealMap():Boolean{
//			if (dialog.visible==false && windows.numElements==0 
//				&& systemManager.numChildren==1
//				&& (scene==WindowConst.SCENE_CITY || scene==WindowConst.SCENE_MAP)){
//				//	trace("TOPSSSSS:::"+systemManager.numChildren)
//				return true;
//			}
			return false;
		}
		
	}
}