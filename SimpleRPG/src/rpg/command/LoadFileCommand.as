package rpg.command
{
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import mk.SLFile;
	import mk.util.ObjUtil;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.WindowConst;
	import rpg.events.MapEvent;
	import rpg.events.SceneEvent;
	import rpg.map.ScriptBuilder;
	import rpg.map.ZoneModel;
	import rpg.model.Actor;
	import rpg.model.ItemBag;
	import rpg.model.Party;
	
	public final class LoadFileCommand extends Command
	{
		[Inject]
		public var dispatcher:IEventDispatcher;
		[Inject]
		public var zone:ZoneModel;
		
		private var so:SharedObject;
		public function LoadFileCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var lastTime:Number = getTimer();
			so=SharedObject.getLocal("simrpg");
			var scene:String=WindowConst.SCENE_CITY;
			if (so.data){
				
				SLFile.registerDataClass();
				var party:Party=Party.getInstance();
				var hero:Actor=ByteArray(so.data.hero).readObject() as Actor;
				party.actors[0]=hero;
				party.gold=so.data.gold;
				SLFile.copyBattlerData(hero,hero);
				SLFile.copyBagData(party.bag,so.data.bag);
				var zoneData:Object=ByteArray(so.data.zone).readObject()
					zone.step=zoneData.step;
				var scripts:Array=ByteArray(so.data.scripts).readObject() as Array;
					zone.scripts=ScriptBuilder.getInstance().copy(scripts);
				var test:Object=ByteArray(so.data.test).readObject();
				trace(so.data.scene)
				scene=so.data.scene;
				trace("读取存档，TIME:", getTimer()-lastTime, "ms.\n");
			}
			dispatcher.dispatchEvent(new SceneEvent(SceneEvent.GOTO,scene));
			if (scene==WindowConst.SCENE_ZONE){
				zone.stepTo(zone.step);
				dispatcher.dispatchEvent(new MapEvent(MapEvent.TRANSFER));
			}
		}
		
		
	}
}