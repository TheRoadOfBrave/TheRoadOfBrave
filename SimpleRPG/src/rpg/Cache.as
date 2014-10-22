package rpg
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	import mk.LibUtil;
	
	import rpg.asset.Background0;
	import rpg.asset.Background1;
	import rpg.asset.Background10;
	import rpg.asset.Background11;
	import rpg.asset.Background12;
	import rpg.asset.Background2;
	import rpg.asset.Background3;
	import rpg.asset.Background4;
	import rpg.asset.Background5;
	import rpg.asset.Background6;
	import rpg.asset.Background7;
	import rpg.asset.Background8;
	import rpg.asset.Background9;
	import rpg.asset.Monster1;
	import rpg.asset.Monster2;
	import rpg.asset.Monster3;
	

	/**
	 * 
	 * 管理图片资源数据
	 * 
	 */
	public class Cache
	{
		private var dummySkillClass:Array= []; 
		private var dummyMonsterClass:Array= [Monster1,Monster2,Monster3]; 
		private var dummyBgClass:Array=[ Background0,Background1,Background2,Background3,Background4,Background5,Background6,Background7,Background8,Background9,Background10,Background11,Background12]; 
		public static var ant_xml:XML;
		
		
		
		
		[Embed(source="/../asset/IconSet.png")]
		private static var IconSetClass:Class; 
		
		private static var IconSet:BitmapData=Bitmap(new IconSetClass).bitmapData; 
		public function Cache()
		{
		}
		
		public static function creatBattlerSkin(id:int):DisplayObject{
			var skinClass:Class=getDefinitionByName("rpg.asset.Monster"+id) as Class;
			var bmd:BitmapData=new skinClass;
			
			var bitmap:Bitmap=new Bitmap(bmd);
			
			
			//var bitmap1:Bitmap=new Bitmap(bitmap0.bitmapData);
			
			bitmap.x=-bitmap.width/2;
			bitmap.y=-bitmap.height;
			var skin:Sprite=new Sprite();
			
			skin.addChild(bitmap);
			skin.graphics.beginFill(0x333333,0.8);
			skin.graphics.drawEllipse(bitmap.x+5,-10,bitmap.width,10);
			skin.graphics.endFill();
			skin.mouseChildren=false;
			skin.mouseEnabled=false;
			skin.buttonMode=true;
			return skin;
		}
		public static function getFace(id:uint):BitmapData{
			var bmd:BitmapData;
				var index:int=int(id);
				//var picClass:Class=getDefinitionByName("rpg.asset.Actor"+id) as Class

				bmd=LibUtil.newClass("rpg.asset.Actor"+id) as BitmapData;
			return bmd;
		}
		
		
		public static function getAnimation(id:String):MovieClip{
			try {
				var index:int=int(id);
				var mcClass:Class;
				if (index>0){
					mcClass=getDefinitionByName("rpg.effect.skillmc"+id) as Class
					
				}else{
					mcClass=getDefinitionByName("mk.rpg.asset.skill."+id) as Class
					
				}
			}catch (err:Error){
				trace("技能动画获取错误："+err)				
				return null;
			}
				
				var mc: MovieClip=new mcClass as MovieClip;
				if(mc){
					mc.stop();
					mc.addFrameScript(mc.totalFrames-1,mc.stop);
					mc.id=id;
					var xml:XML=getMcData(id);
					if (xml){
						mc.pos=xml.@pos;
						mc.data=xml;
					}
				}
				return mc;
			
		}
		
		public static function getMcData(id:String):XML{
			try {
				var xml:XML;
				xml=XML(ant_xml.animation.(@id==id) );
				return xml;
			}catch (err:Error){
				trace("技能动画数据:"+err)	
				return null;
			}
			return null;
		}
		
		public static function getIcon(id:int):BitmapData{
			var rect:Rectangle=new Rectangle(0,0,24,24);
			//Update display bitmap
			rect.x = id%16 * 24
			rect.y = int(id/16) * 24
				var bmd:BitmapData=new BitmapData(24,24,true,0);
			bmd.copyPixels(IconSet,rect,new Point,null,null,true);
			return bmd;
		}
		
		/**
		 *地图上事件角色的图像 
		 * @param id
		 * @return 
		 * 
		 */
		public static function getCharacter(id:int):BitmapData{
			var bmd:BitmapData;
			if (id==1){
				bmd=LibUtil.newClass("rpg.asset.Player") as BitmapData;
			}else{
				var rect:Rectangle=new Rectangle(0,0,24,24);
				//Update display bitmap
				rect.x = id%16 * 24
				rect.y = int(id/16) * 24
				bmd=new BitmapData(24,24,true,0);
				bmd.copyPixels(IconSet,rect,new Point,null,null,true);
				
			}
			return bmd;
		}
		
		/**
		 *获取战斗背景图 
		 * @param id
		 * @return 
		 * 
		 */
		public static function getBackground(id:int):BitmapData{
			var bmd:BitmapData;
			try {
				var index:int=int(id);
				var picClass:Class=getDefinitionByName("rpg.asset.Background"+id) as Class
				
				bmd=new picClass;
			}catch (e:Error){
				trace(e)
			}
			
			return bmd;
		}
		
	}
}