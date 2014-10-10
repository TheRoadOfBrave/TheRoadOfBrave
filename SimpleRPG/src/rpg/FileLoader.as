package rpg
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	import org.osmf.events.LoadEvent;
	

	public class FileLoader extends EventDispatcher
	{
		 private var dataURL:String="data/"
		private var queue:LoaderMax
		private var loader:Loader;
	//	public var urlList:Array=["skill.xml","monster.xml","troop.xml","state.xml"];

		private var docLoader:XMLLoader;
		public function FileLoader()
		{
			LoaderMax.activate([ImageLoader, SWFLoader, DataLoader, MP3Loader]);
			
			//create an XMLLoader
			docLoader = new XMLLoader("data/doc.xml", {name:"xmlDoc",  estimatedBytes:6400,onSecurityError:errorHandler});
			
						
			//Or you could put the XMLLoader into a LoaderMax. Create one first...
			queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onSecurityError:errorHandler,onError:errorHandler});
			queue.append( docLoader );
			//queue.append( new DataLoader("data/troops.xml", {name:"p1"}) );


   			
		}
		
		public function load():void{
			try{
				queue.load();
			}catch (e:SecurityError){
				Alert.show("加载数据失败！请检查并设置");
			}
			
		}
		public function addCompleteHandler(handler:Function):void{
			
			// bulkLoader.addEventListener(BulkLoader.COMPLETE, handler);
			  
		}
		
		private function getXML(key:String):XML{
			return XML(LoaderMax.getContent(key))
		}
		
		private function getTxt(key:String):String{
			return String(LoaderMax.getContent(key))
		}
		
		function progressHandler(event:LoaderEvent):void {
			trace("data progress: " + event.target.progress);
		}
		
		function completeHandler(event:LoaderEvent):void {
			trace("load complete. XML content: " + LoaderMax.getContent("xmlDoc"));
			//trace("load complete. TXT " + LoaderMax.getContent("animation"));
			
			trace("All datas are loaeded and ready to consume");
//			DataBase.skills  = getXML("skill");
//			DataBase.states = getXML("state");
//			DataBase.actors  =getXML("actor");
//			DataBase.monsters  =getXML("monster");
//			DataBase.troops = getXML("troop");
			DataBase.dicts["item"]  =getTxt("item");
			DataBase.dicts["equip"]  =getTxt("equip");
			DataBase.dicts["ants"]  =getXML("animation");
			DataBase.dicts["map"]  =getXML("map");
			DataBase.getInstance();
			loadSwf();
			
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handler);
			
			//dispatchEvent(new Event(Event.COMPLETE));
			
//			trace("XML content1: " + LoaderMax.);
//			trace("XML content2: " + LoaderMax.getContent("10"));
		}
		
		
		private var index:int=0;
		private var ldrArr:Array;
		private function loadSwf():void{
			var binary:ByteArray 
			loader=new Loader();
			ldrArr=[];
			for each (var ldr:DataLoader in docLoader.getChildren()) 
			{
				if (ldr.url.slice(-3)=="swf"){
					ldrArr.push(ldr);
				}
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handler);
			loadSwfBytes();			
			
		}
		
		private function loadSwfBytes():void{
			var ldr:DataLoader=ldrArr[index];
			if (ldr.url.slice(-3)=="swf"){
				
				var binary:ByteArray  = LoaderMax.getContent(ldr.name);
				loader.loadBytes(binary,new LoaderContext(false,ApplicationDomain.currentDomain));
				
			}
		}
		
		protected function handler(event:Event):void
		{
			
			index++;
			if (index<ldrArr.length){
				loadSwfBytes();
			}else{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,handler);
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
			
		}		
		
		private function errorHandler(event:LoaderEvent):void {
			Alert.show("缺少或不支持加载外部数据！");
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		
		



	}
}