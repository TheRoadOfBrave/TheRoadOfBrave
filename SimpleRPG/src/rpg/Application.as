package rpg
{
	import mx.controls.Alert;
	
	import mk.ObjUtil0;
	import mk.SLFile;
	import mk.util.ObjUtil;
	
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
	import rpg.view.TitleView;
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
		
		
		public var titleView:TitleView;
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
			
			
			titleView=new TitleView;
		}
		
		
		
		public function gotoScene(scene:String):void{
			switch(scene)
			{
				case WindowConst.SCENE_TITLE:
					addElement(titleView);
					battleGroup.removeAllElements();
					zoneView.visible=false;
					break;
				
				case WindowConst.SCENE_BATTLE:
					if (containsElement(titleView)) removeElement(titleView);
					battleGroup.addElement(battleView);
					zoneView.visible=true;
					break;
				case WindowConst.SCENE_CITY:
					if (containsElement(titleView)) removeElement(titleView);
					battleGroup.removeAllElements();
					zoneView.visible=false;
					city.visible=true;
					break;
				case WindowConst.SCENE_ZONE:
					if (containsElement(titleView)) removeElement(titleView);
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