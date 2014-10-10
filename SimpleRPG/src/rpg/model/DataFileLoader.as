package rpg.model
{
	import br.com.stimuli.loading.BulkLoader;
	
	import flash.events.ProgressEvent;
	
	import rpg.DataBase;
	//不使用了
	public class DataFileLoader
	{
		 private var dataURL:String="data/"
		private var bulkLoader:BulkLoader
		public var urlList:Array=["skill.xml","monster.xml","troop.xml","state.xml"];
		public function DataFileLoader()
		{
			bulkLoader= new BulkLoader("RPGFactory")
			 bulkLoader.add(dataURL+"skills.xml");
			 bulkLoader.add(dataURL+"states.xml");
   			 bulkLoader.add(dataURL+"monsters.xml");
   			 bulkLoader.add(dataURL+"troops.xml");
   			  bulkLoader.add(dataURL+"items.xml");
   			 bulkLoader.addEventListener(BulkLoader.COMPLETE, onCompleteHandler);
   
   			 bulkLoader.addEventListener(BulkLoader.PROGRESS, onProgressHandler);

   			
		}
		
		public function load():void{
			 bulkLoader.start();
		}
		public function addCompleteHandler(handler:Function):void{
			
			 bulkLoader.addEventListener(BulkLoader.COMPLETE, handler);
			  
		}
		
		private function onProgressHandler(evt : ProgressEvent) : void{
		        trace("Loaded" , evt.bytesLoaded," of ",  evt.bytesTotal);
		 }

   		private function onCompleteHandler(evt : ProgressEvent) : void{
            trace("All items are loaeded and ready to consume");
            DataBase.skills  = bulkLoader.getXML(dataURL+"skills.xml");
            DataBase.states = bulkLoader.getXML(dataURL+"states.xml");
            DataBase.monsters  = bulkLoader.getXML(dataURL+"monsters.xml");
            DataBase.troops = bulkLoader.getXML(dataURL+"troops.xml");
            DataBase.items  = bulkLoader.getXML(dataURL+"items.xml");
           	
    	}

	}
}