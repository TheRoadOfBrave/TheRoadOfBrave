package rpg.model
{
	import rpg.vo.EventVo;

	/**
	 * @author maikid
	 *相当于RPGMAKER地图上的事件点 
	 * 继承GameCharacter具有图形行走图 移动等功能
	 */
	public class GameEventObject extends GameCharacter
	{
		public var map_id:uint;
		public var name:String;
		/**
		 *启动中的标志 
		 */
		public var starting:Boolean;
		/**
		 *启动方式  0确定点击  1 2接触判定 3自启动 4并行
		 */
		public var trigger:int;
		public var vo:EventVo;
		public var pages:Array;
		public var page:EventPage;
		//事件坐标地点ID
		public var locale:uint;
		/**
		 *暂时消除的标志 
		 */
		private var _erased:Boolean;
		public var normal_priority:int=1;
		public function GameEventObject(map_id:uint, event:EventVo)
		{
			this.map_id=map_id;
			this.id=event.id;
			this.vo=event;
			locale=event.locale;
			init();
		}
		
		public function init():void{
			starting=false;
			trigger=0;
			page=null;
			_erased=false;
			refresh();
		}
		
		
		
		/**
		 *  判定指定的启动方式是否能启动事件
		 * @param triggers 启动方式的数组
		 * @return 
		 * 
		 */
		public function  trigger_in(triggers:Array):Boolean{
			if ( triggers.indexOf(trigger)>-1){
				return true;
			}
			return false;			
		}
		
		/**
		 * 
		● 事件启动
		 * 
		 */
		public function  start():void{
			if (null==page)return;
				starting = true
			//lock if trigger_in?([0,1,2])
			
		}
		
		public function erase():void{
			_erased = true
			refresh();
		}
		
		
		public function clear_starting_flag():void
		{
				starting=false;
			
		}
		
		
		/**
		 *更新 ,目前作用就是开启 自启动事件 
		 * 
		 */
		public function update():void{
			check_event_trigger_auto();
			/*并行事件 需更新子解释器 未实现
			return unless @interpreter
				@interpreter.setup(@list, @event.id) unless @interpreter.running?
					@interpreter.update*/
		}
		/**
		 *刷新事件页
		 * 寻找满足条件的事件页并设置 执行 
		 * 
		 */
		public function refresh():void{
			var new_page:EventPage = _erased ?null: find_proper_page();
				if (!new_page || new_page != page){
					setup_page(new_page)
				}
			
		}
		public function find_proper_page():EventPage{
			
		//	@event.pages.reverse.find {|page| conditions_met?(page) }
			for each(var page:EventPage in vo.pages){
				if (page.condition){
					return page;
				}
				
			}
			
			return null;
		}
		
		
		public function setup_page(new_page:EventPage):void{
			page = new_page
			if (page){
				//setup_page_settings
				trigger=page.trigger;
			}else{
		//		clear_page_settings
				trigger=0
			}
				
		//	update_bush_depth
			clear_starting_flag()
			check_event_trigger_auto();
		}
		
		private function check_event_trigger_auto():void
		{
			if (trigger==3){
				//自动事件的启动判定
				start();
			}
		}
	
	}
}