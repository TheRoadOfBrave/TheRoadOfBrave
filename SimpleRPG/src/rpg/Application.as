package rpg
{
	import mx.controls.Alert;
	
	import org.flexlite.domCore.Injector;
	import org.flexlite.domUI.components.Alert;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.managers.SystemManager;
	import org.flexlite.domUI.skins.themes.VectorTheme;
	import org.flexlite.domUtils.Debugger;
	
	import rpg.city.CityView;
	import rpg.dialog.DialogBox;
	import rpg.manager.WindowManager;
	import rpg.map.ZoneView;
	import rpg.model.Actor;
	import rpg.model.Party;
	import rpg.view.Dialog;
	import rpg.view.StatusPanel;
	import rpg.vo.EquipItem;
	
	public class Application extends SystemManager
	{
		private var top:Group;
		private var windowBox:Group;
		private var city:CityView;
		private var zoneView:ZoneView;
		public var battleView:Group;
		private var battleGroup:Group;
		public var dialog:Dialog;
		
		//当前游戏场景 标识
		public var scene:String;
		
		public var statusPanel:StatusPanel;
		public function Application()
		{
			super();
			Injector.mapClass(Theme,VectorTheme);//这里一次性注入所有组件的默认皮肤。正式项目中不需要默认皮肤,应当自定义主题。
			Debugger.initialize(stage);//显示列表调试工具(可选)。
			init();
			
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
		}
		
		
		private function init():void{
			windowBox=new Group;
			battleGroup=new Group;
			city=new CityView;
			zoneView=new ZoneView;
			zoneView.visible=false;
			dialog=new Dialog;
			dialog.y=250;
			dialog.visible=false;
			addElement(city);
			addElement(zoneView);
			addElement(battleGroup);
			addElement(dialog);
			addElement(windowBox);
			
			var wndManager:WindowManager=WindowManager.getInstance()
			WindowManager.container=windowBox;
			
			statusPanel=new StatusPanel;
			statusPanel.y=320;
			addElement(statusPanel);
		}
		
		public function setup():void{
			var party:Party=Party.getInstance();
			party.setup(1);
			party.recover_all();
			party.gold=100000;
			party.food=10;
			statusPanel.gold=party.gold;
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
			statusPanel.hero=party.actors[0];
			
			party.bag.gainItemById(1,0);
			party.bag.gainItemById(3,5);
			party.bag.gainItemById(4,5);
			party.bag.gainItemById(5,5);
			party.bag.gainItemById(6,6);
			statusPanel.setBag(party.bag.items);
			
			
			var hero:Actor=party.actors[0];
			var eq:EquipItem=DataBase.getInstance().getWeapon(1);
			if(hero.equippable(eq)){
				var slot:uint=hero.empty_slot(eq.etype_id);
				if (slot>=0){
					hero.change_equip(slot,eq);
					
				}
			}else{
				Alert.show("不能装备"+eq);
			}
			
			var eq:EquipItem=DataBase.getInstance().getWeapon(501);
			if(hero.equippable(eq)){
				var slot:uint=hero.empty_slot(eq.etype_id);
				if (slot>=0){
					hero.change_equip(slot,eq);
					
				}
			}else{
				Alert.show("不能装备"+eq);
			}
			
			
			statusPanel.refreshEquipt();
			
		}
		
		public function gotoScene(scene:String):void{
			switch(scene)
			{
				case WindowConst.SCENE_BATTLE:
					battleGroup.addElement(battleView);
					zoneView.visible=true;
					break;
				case WindowConst.SCENE_CITY:
					
					battleGroup.removeAllElements();
					zoneView.visible=false;
					city.visible=true;
					break;
				case WindowConst.SCENE_ZONE:
					zoneView.visible=true;
					battleGroup.removeAllElements();
					city.visible=false;
					break;
				default:
					break;
			}
		}
		
		
		
		/**
		 *是否需要更新地图事件脚本 ，检测事件场景  窗口 
		 * @return 
		 * 
		 */
		public function get needDoScript():Boolean{
			if ( 	 (scene==WindowConst.SCENE_CITY || scene==WindowConst.SCENE_ZONE)){
				//	trace("TOPSSSSS:::"+systemManager.numChildren)
				return true;
			}
			return false;
		}
		
		/**
		 *是否挂起 ,挂起 对应的解释器 不往下执行
		 * @return 
		 * 
		 */
		public function get isYield():Boolean{
			if (dialog.visible) return true;
			return false;
		}
		
	
	}
}