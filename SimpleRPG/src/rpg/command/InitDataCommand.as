package rpg.command
{
	
	
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mk.util.TxtUtil;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.Cache;
	import rpg.DataBase;
	
	public class InitDataCommand extends Command
	{
		
		[Embed("/../data/equip.txt",mimeType="application/octet-stream")]
		private var equipData:Class;
		
		[Embed("/../data/item.txt",mimeType="application/octet-stream")]
		private var itemData:Class;
		
		[Embed("/../data/monsters.xml",mimeType="application/octet-stream")]
		private var monsterData:Class;
		
		[Embed("/../data/actors.xml",mimeType="application/octet-stream")]
		private var actorData:Class;
		
		[Embed("/../data/troops.xml",mimeType="application/octet-stream")]
		private var troopData:Class;
		
		[Embed("/../data/states.xml",mimeType="application/octet-stream")]
		private var stateData:Class;
		
		[Embed("/../data/skills.xml",mimeType="application/octet-stream")]
		private var skillData:Class;
		
		[Embed("/../data/acts.xml",mimeType="application/octet-stream")]
		private var actData:Class;
		
		[Embed("/../swf/sound.swf",mimeType="application/octet-stream")]
		private var sounds:Class;
		
		public function InitDataCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			DataBase.actors=XML(new actorData);
			DataBase.monsters=XML(new monsterData);
			DataBase.troops=XML(new troopData);
			DataBase.states=XML(new stateData);
			DataBase.skills=XML(new skillData);
			DataBase.acts=XML(new actData);
			
			DataBase.dicts["item"]=new itemData;
			DataBase.dicts["equip"]=new equipData;
			
			
			var data:String=DataBase.dicts["item"]
			DataBase.dicts["item"]=parse(data);
			
			data=DataBase.dicts["equip"]
			DataBase.dicts["equip"]=parse(data);
			
			Cache.ant_xml=DataBase.dicts["ants"];
			
			var loader:Loader=new Loader();
			var swf:ByteArray=new sounds
			loader.loadBytes(swf,new LoaderContext(false,ApplicationDomain.currentDomain));
		}
		
		private function parse(data:String):Dictionary{
			var dict:Dictionary=new Dictionary;
			var arr:Array=TxtUtil.parseTxtObj(data);
			for each (var obj:Object in arr){
				dict[obj.id]=obj
			}
			return dict;
		}
	}
}