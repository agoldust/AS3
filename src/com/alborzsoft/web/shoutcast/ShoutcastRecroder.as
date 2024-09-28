package com.alborzsoft.web.shoutcast
{
	import com.alborzsoft.air.ApplicationDescriptor;
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.shoutcast.types.ShoutcastStreamInfo;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.ID3Info;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	
	[Event(name="id3", type="flash.events.Event")]
	
	
	public class ShoutcastRecroder extends URLStream
	{
		
		private var _streamURL:String;
		private var file_name:String;
		
		[Bindable] public var info:ShoutcastStreamInfo = new ShoutcastStreamInfo;
		[Bindable] public var isRecording:Boolean;
		[Bindable] public var recordTime:String = '00:00';

		
		private var file:File;
		private var fileStream:FileStream;
		private var buffer:ByteArray = new ByteArray;

		private var bytesLoaded:int;
		private var recordTimer:Timer = new Timer(1000);
		
		
		
		public function ShoutcastRecroder()
		{
			super();
			super.addEventListener(Event.OPEN, 				onOpen);
			super.addEventListener(ProgressEvent.PROGRESS,	onProgress);
			
			recordTimer.addEventListener(TimerEvent.TIMER, onTimer);
		}	
		
		
		
		/**Strem URL of Radio Channel*/
		public function get streamURL():String
		{
			return StrUtils.replaceAll(_streamURL, ';', '');
		}
		public function set streamURL(value:String):void
		{
			value = StrUtils.replaceAll(value, ';', '');
			_streamURL = value + ';';
		}
		
		

		protected function onTimer(event:TimerEvent):void
		{
			recordTime = TimeConvertor.getTimecode(recordTimer.currentCount);
		}
		
		
		/** <p>Strat Recording<p/>
		 * 
		 * @param url - URL of Radio Channel
		 * @param name - Name of File That is going to be saved
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function startRecording(url:String, file_name:String=''):void
		{
			isRecording = true;
			streamURL = url;
			super.load(new URLRequest(_streamURL)); //_streamURL have extra ; charater in it 
			
			recordTime
			this.file_name = (StringUtils.hasText(file_name)) ? file_name : null;
		}
		
		
		
		protected function onOpen(event:Event):void
		{
			bytesLoaded = 0;
			recordTimer.start();
			
			file = File.documentsDirectory;
			file.nativePath += '/Recorded Radio/' + fileName + '.mp3';
			
			fileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
		}		
		
		
		protected function onProgress(event:ProgressEvent):void
		{			
			var ba:int = super.bytesAvailable;

			buffer.position = 0;
			readBytes(buffer, 0, ba);
			
			buffer.position = 0;
			fileStream.writeBytes(buffer, 0, ba);
			
			bytesLoaded += ba;
			
			// getting infor of data
			if(!info.isSet){
				info.data = buffer;
				dispatchEvent(new Event(Event.ID3));
			}
		}
		
		
		
		
		/** <p>will Stop Recording<p/>
		 * 
		 * @param openDirectory - Boolean that detemins to open Folder of where MP3 File is saved
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function stopRecording(openDirectory:Boolean=false) : void
		{
			try {
				if(super.connected)
				{
					super.close();
				}
			}
			catch (error:Error) {		
			}
			
			
			
			if(fileStream)
			{
				if(openDirectory) 	//opening the Directory
				{
					var f:File = File.documentsDirectory;
					f.nativePath += '/Recorded Radio/';
					f.openWithDefaultApplication();
				}
				
				fileStream.close();
			}
			
			recordTimer.reset();
			isRecording = false;
			recordTime = '00:00';
		}
		
		
		
		
		/**Saved File Name*/
		public function get fileName():String
		{
			var ad:ApplicationDescriptor = new ApplicationDescriptor;
			var name:String = ad.name + ' - ' + TimeConvertor.styleDate(new Date, '-', '-', '#');
			
			
			// adding file name of user
			if(StringUtils.hasText(file_name))
				name += ' - ' + file_name;
			
			//replacing .mp3 extention, if there is any
			name = StrUtils.replaceAll(name, '.mp3', '');
			
			return name;
		}
		
		
		
		
		
	}
}