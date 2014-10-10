package rpg.model
{
	import flash.display.Sprite;
	
	import rpg.model.GameEventObject;
	
	public class GameCharacter 
	{
		public var    id  :int    // ID
		public var    x   :int    // 地图 X 坐标（理论坐标）
		public var    y   :int    // 地图 Y 坐标（理论坐标）
		public var    real_x :int    // 地图 X 坐标（实际坐标）
		public var    real_y :int    // 地图 Y 坐标（实际坐标）
		public var    tile_id:int    // 图块 ID（0 则无效）
		public var    character_name           :String    // 行走图文件名
		public var    character_index          :int    // 行走图索引
		public var    move_speed               :int    // 移动速度
		public var    move_frequency           :int    // 移动频度
		public var    walk_anime               :int    // 步行动画
		public var    step_anime               :int    // 踏步动画
		public var    direction_fix            :int    // 固定朝向
		public var    opacity:int    // 不透明度
		public var    blend_type               :int    // 合成方式
		public var    direction                :int    // 方向
		public var    pattern:int    // 图案
		public var    priority_type            :int    // 优先级类型
		public var    through:int    // 穿透
		public var    bush_depth               :int    // 草木深度
		public var   animation_id             :int    // 动画 ID
		public var   balloon_id               :int    // 心情图标 ID
		public var  transparent              :int    // 透明状态
		public function GameCharacter(evtObj:GameEventObject=null)
		{
			super();
		}
	}
}