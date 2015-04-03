package rpg
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	
	import mk.LibUtil;
	
	public class GameSound
	{
		public static var CLICK:String="Click";
		public static var EQUIPT:String="Equipt1";
		public static var OPEN:String="Open1";
		
		
		
		public  var on:Boolean=true;
		private static var _instance:GameSound;
		public function GameSound()
		{
		}
		
		public static function getInstance():GameSound{
			if (!_instance) {
				
				_instance=new GameSound();
			}
			return _instance;
		}
		
		public  function play(name:String,vol:Number=1):void{
			try {
				if (on){
					var sound:Sound=LibUtil.newClass("sounds."+name) as Sound;
					
				var channel:SoundChannel=sound.play();
					channel.soundTransform.volume=vol;
				}
			}catch(err:TypeError){
				trace("GameSound未完成"+err);
			}catch(err:Error){
				trace("无法找到"+name+"音效",err.getStackTrace());
			}
		}
		
		public  function playSound(soundName:String,vol:Number=1):void{
			try {
				if (on){
					//					var domain : ApplicationDomain = soundLoader.contentLoaderInfo.applicationDomain;
					//					var mp3:Class=domain.getDefinition(soundName) as Class;
					//					var sound:Sound=new mp3() as Sound;
					//					sound.play();
//					var sound:SoundAsset = SoundAsset(new embed[soundName]());
					//var sound:SoundAsset = SoundAsset(new this[soundName+"_mp3"]());
					
//					var channel:SoundChannel=sound.play();
//					channel.soundTransform.volume=vol;
				}
			}catch(err:TypeError){
				trace("GameSound未完成"+err);
			}catch(err:Error){
				trace("无法找到"+soundName+"音效",err.getStackTrace());
			}
			
			
		}
		
		public  function playClick():void{
			play(CLICK);
		}
		
		public  function playChest():void{
			play(OPEN);
		}
		
		
	}
}