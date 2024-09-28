package com.alborzsoft.net
{
	/**<p>[[ UNFINISHED ]]  a Downloader Class</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Nov 15, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9, AIR 1.0
	 */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.ResultEvent;
	
	
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="ioError ", type="flash.events.IOErrorEvent")]
	[Event(name="securityError ", type="flash.events.SecurityErrorEvent")]

	
	
	public class Downloader extends EventDispatcher
	{
		private var savedFile:File;
		private var urlStream:URLStream = new URLStream();
		private var fileStream:FileStream = new FileStream();
		
		
		public function Downloader(url:String, savedFile:File)
		{
			this.savedFile = savedFile;
			downloadAFile(url, savedFile);
		}
		
		
		private function downloadAFile(url:String, savePlace:File):void
		{
			if(urlStream.connected == false)
			{
				fileStream.openAsync(savePlace, FileMode.WRITE);
				
				urlStream.load(new URLRequest(url));
				urlStream.addEventListener(Event.COMPLETE, onComplete);
				urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
				
				urlStream.addEventListener(IOErrorEvent.IO_ERROR, onError);
				urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			}
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			//writeCurrentData(); // this line will cause the unfinished file
			dispatchEvent(event);
		}
		
		private function onComplete(event:Event):void
		{
			writeCurrentData();
			dispatchEvent(new ResultEvent('result', false, false, savedFile));
		}
		
		private function onError(event:IOErrorEvent):void
		{
			fileStream.close();
			savedFile.deleteFile();
			
			dispatchEvent(event);
		}
		
		private function onSecurityError(event:SecurityErrorEvent):void
		{
			fileStream.close();
			savedFile.deleteFile();
			
			dispatchEvent(event);
		}
		
		
		private function writeCurrentData():void
		{
			if(urlStream.bytesAvailable > 51200)
			{
				var dataBuffer:ByteArray = new ByteArray;
				
				urlStream.readBytes(dataBuffer);
				fileStream.writeBytes(dataBuffer, 0, dataBuffer.bytesAvailable);
				fileStream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, closeFile);
			}
		}
		
		private function closeFile(event:OutputProgressEvent):void
		{
			fileStream.close();
			
			if(urlStream.connected)
				urlStream.close();
		}
		
	}
}