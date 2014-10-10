package rpg.command
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.BattleScene;
	import rpg.DataBase;
	import rpg.WindowConst;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.city.MapModel;
	import rpg.events.WindowEvent;
	import rpg.model.GameInterpreter;
	import rpg.shop.ShopModel;
	import rpg.vo.IPackItem;
	
	public class ShopCommand extends Command
	{
		[Inject]
		public var battleScene:BattleScene;
		
		[Inject]
		public var shop:ShopModel;
		
		
		[Inject]
		public var event:ScriptCmdEvent;
		public var db:DataBase=DataBase.getInstance();
		
		private var inter:GameInterpreter;
		[Inject]
		public var dispatcher:IEventDispatcher;
		public function ShopCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//trace(inter+"执行命令"+inter.running)
			trace(event.code,event.params,"执行商店命令开始");		
			var params:Array=event.params;
			switch (event.code){
				case 302:
					var goods:Array=[];
					for (var i:int=0;i<params.length;i++){
						var obj:Object=params[i]
							var item:IPackItem;
						if (obj.type==1){
							item=db.getItem(obj.id);
							item.num=obj.n;
							item.price=obj.price;
							goods.push(item);
						}
					}
					
					shop.goods=goods;
					dispatcher.dispatchEvent(new WindowEvent(WindowEvent.OPEN,WindowConst.SHOP));
					
					
					break;
			}
			
		}
		
		
		
	}
}