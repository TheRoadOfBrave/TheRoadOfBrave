package rpg.view.irender
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	import rpg.Cache;
	
	import skins.EqItemSkin;

	public class EqueitRender extends ItemRenderer
	{
		public var img:UIAsset;
		public var mydata:Object
		public var isChange:Boolean;
		public var bmd:BitmapData;
		public function EqueitRender()
		{
			super();
			this.skinName=EqItemSkin;

		}
		
		override protected function dataChanged():void
		{
			var myskin:EqItemSkin=this.skin as EqItemSkin;
			if (data){
					img.skinName=Cache.getIcon(data.icon_index);
					label=data.name;
					if (isChange){
					
						var bmd2:BitmapData=DisplayUtil.captureBitmapData(this);
						trace(y+"play:"+itemIndex);
					myskin.play(bmd2);
					}
						
					isChange=false;
			}else{
				isChange=false;
				img.skinName=null;
				myskin.complete();
			}
		}
		override public function get selected():Boolean
		{
			return false;
		}
		
		override public function set selected(value:Boolean):void
		{
			
		}
		
		override protected function getCurrentSkinState():String
		{
			
			if (!isChange){
				//if (selected) return "over";
				return super.getCurrentSkinState();
			}
			
			
		
			
			return "change";
		}
		
		public function play():void
		{
			// TODO Auto Generated method stub
			isChange=true;
			
			var myskin:EqItemSkin=this.skin as EqItemSkin;
			myskin.copy();
			bmd=DisplayUtil.captureBitmapData(this);
			
		}
	}
}