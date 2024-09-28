package com.alborzsoft.workers.zip
{
	import com.alborzsoft.air.filesystem.ZipManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.system.MessageChannel;
	import flash.system.Worker;

	
	public class WorkerZipManager extends Sprite
	{
		protected var wtm:MessageChannel;
		protected var mtw:MessageChannel;
		
		protected var zip_manager:ZipManager;
		
		
		public function WorkerZipManager()
		{
			wtm = Worker.current.getSharedProperty('wtm');
			mtw = Worker.current.getSharedProperty('mtw');
			
			mtw.addEventListener(Event.CHANNEL_MESSAGE, onMessage);
		}
		
		protected function onMessage(event:Event):void
		{
			var data:Object = mtw.receive();
			
			if(data is Array)
				zip_manager = new ZipManager(data[0], data[1]);
				
			else if(data is File)
				zip_manager = new ZipManager(data as File);
				
			else
				throw Error("Your Have to send File to ZipManagerWorker");
			
			
			zip_manager.addEventListener(ProgressEvent.PROGRESS, onZipProgress);
			zip_manager.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				wtm.send({type:e.type, file:zip_manager.saveFile});
				trace('zip finished');
			});
			
			zip_manager.saveZIPFile();
		}
		
		
		
		protected function onZipProgress(e:ProgressEvent):void
		{
			var percent:Number = e.bytesLoaded/e.bytesTotal;
			wtm.send({type:e.type, percent:percent});
		}
	}
}