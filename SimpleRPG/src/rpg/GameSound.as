package rpg
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import mx.core.SoundAsset;
	import mx.validators.EmailValidator;
	
	public class GameSound
	{
		//[Embed(source="Sound.swf",symbol="BTNsound")]//按钮
		
		private static var embed:SoundEmbed;
		public  var on:Boolean=true;
		private static var _instance:GameSound;
		public function GameSound()
		{
		}
		
		public static function getInstance():GameSound{
			if (!_instance) {
				
				_instance=new GameSound();
				embed=new SoundEmbed();
			}
			return _instance;
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
		
		public  function playHit():void{
			playSound("hit_mp3");
		}
		
		public  function playAtk():void{
			playSound("swing_mp3");
		}
		
	}
}