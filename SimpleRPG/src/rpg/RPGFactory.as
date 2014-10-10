package mk.rpg
{
	
	
	public final class RPGFactory
	{
		
		public var skills:XML,troops:XML,states:XML;
		public var monsters:XML;
		
		
		private var loadIndex:int;
		
		public function RPGFactory()
		{
			loadIndex=-1;
			dataLoader=new URLLoader();
			
			dataLoader.addEventListener(Event.COMPLETE,loadedHandler)
			dataLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

		}
		
		private function get curURL():String{
			return urlList[loadIndex];
		}
		
		public function loadData():void{
			loadIndex++;
			if (curURL!=null){
				dataLoader.load(new URLRequest(curURL));
			}else{
				
			}
			
		}
		
		private function loadedHandler(event:Event):void{
			var xmlData:XML=XML(dataLoader.data);
			var dataURL:String=curURL;
			switch (dataURL){
				case "skill.xml":
					skills=xmlData;
					break;
				case "state.xml":
					states=xmlData;
					break;
				case "monster.xml":
					monsters=xmlData;
					break;
				case "troop.xml":
					troops=xmlData;
					break;
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void {
           
        }

	}
}