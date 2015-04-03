package rpg.command
{
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import mk.SLFile;
	import mk.util.ObjUtil;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.map.ZoneModel;
	import rpg.model.Party;
	
	public final class SaveFileCommand extends Command
	{
		private var so:SharedObject;
		[Inject]
		public var zone:ZoneModel;
		
		public function SaveFileCommand()
		{
			super();
		}
		
		
		override public function execute():void
		{
			SLFile.registerDataClass();
			so=SharedObject.getLocal("simrpg");
			var lastTime:Number = getTimer();
			var party:Party=Party.getInstance();
		//	so.data.party=ObjUtil.toBytes(party);
			so.data.scene=party.scene;
			so.data.gold=party.gold;
			so.data.hero=ObjUtil.toBytes(party.leader);
			so.data.bag=SLFile.toBagData(party.bag);
			so.data.zone=ObjUtil.toBytes(zone);
			var scripts:ByteArray=ObjUtil.toBytes(zone.scripts);
			so.data.scripts=scripts;
				
			//var arr:Array=script.readObject() as Array;
			
			
			var test:Object={1:"555",2:"666"};
			so.data.test=ObjUtil.toBytes(test);
			trace("已存储，TIME:", getTimer()-lastTime, "ms.\n");
		}
		
		
	}
}