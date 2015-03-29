package rpg.view.irender
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import mk.util.DisplayUtil;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	import rpg.Cache;
	import rpg.events.ItemEvent;
	import rpg.vo.IPackItem;
	
	import skins.EqItemSkin;
	import skins.ItemSkin;

	public class BagItemRender extends ItemRenderer
	{
		public var img:UIAsset;
		public var mydata:Object
		public var isChange:Boolean;
		public var bmd:BitmapData;
		public function BagItemRender()
		{
			super();
			this.skinName=ItemSkin;
			this.addEventListener(MouseEvent.CLICK,clickItem);
		}
		
		protected function clickItem(event:MouseEvent):void
		{
			var item:IPackItem=data as IPackItem;
			dispatchEvent(new ItemEvent(ItemEvent.USE,item,true));
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