package com.alborzsoft.sound
{
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	

	
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="ioError",  type="flash.events.IOErrorEvent")]
	
	 

	
	
	[Bindable]
	public class MP3File extends EventDispatcher
	{
		public var name:String;
		public var url:String;
		
		public var sound:Sound;
		public var soundChannel:SoundChannel;
		
		public var isPlaying:Boolean;
		public var playedPercent:Number=0;
		public var loadedPercent:Number=0;
		public var currentMilisecons:Number=0;
		
		public var totalTime:String = '00:00';
		public var currentTime:String = '00:00';
		public var volume:Number = 0.75;
		
		
		private var timer:Timer = new Timer(500);
		private var Volume:SoundTransform	= new SoundTransform();

		
		
		
		
		public function MP3File(name:String='', url:String='')
		{
			this.name = name;
			this.url = url;
			
			
			//timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function makeSound():void
		{
			if(sound==null)
			{
				isPlaying = false;
				currentMilisecons = 0;
				playedPercent=0;
				loadedPercent=0;
				
				sound = new Sound();
				sound.addEventListener(Event.ID3, onOpen);
				sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
			}
		}
		
		
		/** <p>Playing the MP3 file<p/>
		 * 
		 * @param url - Url of mp3 file
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function play(url2:String=''):void
		{
			makeSound();
			
			// changing the URL of file if prvided
			if(StringUtils.hasText(url2)) url = url2; 
			
			// stopping the Music befor next Play
			//if(isPlaying) pause();
			
			
			// loading if it's empty
			if(StringUtils.isEmpty(sound.url) || sound.url != url){
				sound.load(new URLRequest(url));
			}
			
			// playing
			isPlaying = true;
			soundChannel = sound.play(currentMilisecons);
			
			// update Volume
			changeStreamVolume(volume);
			
			
			// timer for setting the current time
			timer.start();
		}
		
		
		
		/** <p>Stopping the Music<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function stop():void
		{
			if(soundChannel)
			{
				currentMilisecons = 0;
				
				soundChannel.stop();
				soundChannel = null;
				
				//sound.close();
				sound = null;
				
				isPlaying = false;
				timer.stop();
			}
		}
		
		
		
		
		/** <p>Stopping the Music<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function pause():void
		{
			if(soundChannel)
			{
				currentMilisecons = soundChannel.position;
				soundChannel.stop();
				isPlaying = false;
				timer.stop();
			}
		}
		
		
		
		/** <p>Changing the Volume of Music - Range is 0~1<p/>
		 * 
		 * @param val - Number between 0 to 1
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function changeStreamVolume(val:Number):void
		{
			volume = val;
			
			if(isPlaying)
			{
				Volume.volume = volume;
				soundChannel.soundTransform	= Volume; 
			}
		}
		
		
		
		// when a part of mp3 file loaded
		private function onOpen(event:Event):void
		{
			totalTime = (sound) ? TimeConvertor.getTimecode(event.target.length/1000) : '00:00';
		}
		
		
		
		// when a part of mp3 file loaded
		private function onProgress(event:ProgressEvent):void
		{
			loadedPercent = event.bytesLoaded / event.bytesTotal;
			
			dispatchEvent(event);
		}
		
		// when error accured
		private function onIOError(event:IOErrorEvent):void
		{
			dispatchEvent(event);
		}
		
		
		// Timer
		private function onTimer(event:TimerEvent):void
		{
			if(sound){
				currentTime = (sound) ? TimeConvertor.getTimecode(soundChannel.position/1000) : '00:00';
				
				var total_seconds:int = Math.round(sound.length/1000);
				var play_seconds:int = Math.round(soundChannel.position/1000);
				
				playedPercent = (play_seconds / total_seconds);
				
				
				
				trace(total_seconds);
				trace(playedPercent);
			}
		}
		
		
		
		
	}
}