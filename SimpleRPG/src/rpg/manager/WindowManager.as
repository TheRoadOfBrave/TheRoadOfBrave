package rpg.manager
{
	import flash.utils.Dictionary;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.UIComponent;
	
	import rpg.WindowConst;
	import rpg.shop.view.ShopView;
	

	public class WindowManager 
	{
		private static var _instance:WindowManager;
		public static var container:Group;
		private var dict:Dictionary;
		public function WindowManager()
		{
			dict=new Dictionary;
		}
		
		public static function getInstance():WindowManager{
			if (!_instance) {
				
				_instance=new WindowManager();
				
			}
			return _instance;
		}
		public function getWindow(wndName:String):UIComponent{
			var window:UIComponent
			if (dict[wndName]){
				window=dict[wndName];
				return window;
			}
			switch(wndName)
			{
				case WindowConst.STATUS:
					//window=new StatusWindow;
					
					break;
				case WindowConst.BAG:
					//window=new BagView;
					
					break;
				case WindowConst.SHOP:
					window=new ShopView;
					break;
				case WindowConst.PUB:
					//window=new Pub;
					window.x=50;
					window.y=80;
					break;
				default:
					break;
			}
			dict[wndName]=window
			return window;
		}
		
		
		/**
		 *打开窗口 会自动关闭其他窗口 
		 * @param wndName
		 * 
		 */
		public static function addWindow(wndName:String):void{
			closeAllWindow();
			var window:UIComponent=_instance.getWindow(wndName);
			if (window){
				container.addElement(window);
			}else{
				throw new Error("错误! 没有窗口组件:"+wndName);
			}
		}
		
		public static function closeAllWindow():void{
			if (container.numElements>0){
				container.removeAllElements();
			}
				
		}
	}
}