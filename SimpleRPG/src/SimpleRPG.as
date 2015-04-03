package
{
	import flash.display.Sprite;
	
	import org.flexlite.domUI.components.Button;
	
	import rpg.Application;
	
	import skins.BtnSkin;
	 
	[SWF(backgroundColor="0xffffff", frameRate="30", width="480", height="600")]
	public class SimpleRPG extends Sprite
	{
		private var context:AppContext;
		private var app:Application;
		public function SimpleRPG()
		{
			init();
		}
		
		private function init():void{
			context=new AppContext();
			context.run(this);
			app=new Application;
			addChild(app);
			var btn:Button=new Button;
			btn.label="ABCD"
				btn.skinName=BtnSkin;
			addChild(btn);
		}
		
	}
}