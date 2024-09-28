package com.alborzsoft.air.filesystem
{
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.coltware.commons.zip.ZipEntry;
	import com.coltware.commons.zip.ZipEvent;
	import com.coltware.commons.zip.ZipFileReader;
	import com.coltware.commons.zip.ZipFileWriter;
	import com.coltware.commons.zip.zip_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.collections.ArrayList;
	
	
	
	
	/** <p>Spacifies the percent Amount of Created Zip file and fires each time that a file will be added<p/> */
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	/** <p>When Zip File is Opened<p/> */
	[Event(name="open", type="flash.events.Event")]
	
	/** <p>When Zip File is Created<p/> */
	[Event(name="complete", type="flash.events.Event")]
	
	
	
	
	public class ZipManager extends EventDispatcher
	{
		
	//====================================== VARRIABELS ==================================
		//----------- PUBLIC
		public var fileList:ArrayList;
		public var timer:Timer;
		
		[Bindable] public var isSaving:Boolean = false;
		[Bindable] public var isPaused:Boolean = false;
		
		
		//----------- PRIVATE
		private var file:File;
		public  var saveFile:File
		private var iFiles:Vector.<File>;
		private var writer:ZipFileWriter;	


		
		
		
		
	//====================================== METHODS ==================================

		/** <p>ZIP CLASS constructor<p/>
		 * 
		 * @param file - File of the folder or file that need to be saved 
		 * @param file - File of the file that need to be saved </br>
		 * if you don't spacify this parameter, a save dialog window whill show up to get the save location and wil add <code>.zip</code> to the end of name of file
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function ZipManager(file:File, saveFile:File=null)
		{
			this.file = file;
			this.saveFile = saveFile;
			this.fileList = new ArrayList;
			this.iFiles = new Vector.<File>;
		}
		
		
		/** <p>Extracting Files from ZIP file<p/>
		 * 
		 * @param <b>destenitionFolder</b> - A Folder that extracted files needs to be saved
		 * @param <b>delay</b> - miliseconds delay between reading from zip file to Buy some time to Update the UI
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function extractZIPFile(destenitionFolder:File=null, delay:uint=50):void
		{
			var loadedBytes:uint = 0;
			var zipReader:ZipFileReader = new ZipFileReader();
			zipReader.open(file);
			
			
			// getting the list of files
			var entries:Array = zipReader.getEntries();
			
			
			// saving the file when is laoded
			zipReader.addEventListener(ZipEvent.ZIP_DATA_UNCOMPRESS, function(event:ZipEvent):void
			{
				ti.stop(); // stopping the Timer
				
				var ba:ByteArray = event.data;
				var entry:ZipEntry = event.entry;
				var dir:File = destenitionFolder.clone();
				var f:File = dir.resolvePath(entry.getFilename());
				
				if(entry.isDirectory())
				{
					f.createDirectory();
				}
				else {
					var fs:FileStream = new FileStream();
					fs.open(f,FileMode.WRITE);
					fs.writeBytes(ba);
					fs.close();
				}
				
				loadedBytes += entry.getCompressSize(); 														// adding the Written file size to the total
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, loadedBytes, file.size)); // dispatvhing the progress event
				
				ti.start(); // running the Timer after saving and dispatching the Event
			});
			
			
			
			// generating the file and ProgressEvent
			var ti:Timer = new Timer(delay, entries.length);
			ti.start();
			ti.addEventListener(TimerEvent.TIMER, function():void
			{
				if(ti.currentCount <= entries.length)
					zipReader.unzipAsync(entries[ti.currentCount-1] as ZipEntry); // unziping the file
				else
				{
					dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, 1, 1)); // dispatvhing the progress event
					dispatchEvent(new Event(Event.COMPLETE)); // dispatvhing the Comlete event
				}
			});
			
		}
		
		
		/** <p>Saving Files on HDD<p/>
		 * 
		 * @param <b>extention</b> - Extention of saved zip file
		 * @param <b>delay</b> - miliseconds delay between adding to zip file to Buy some time to Update the UI
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function saveZIPFile(extention:String='zip', delay:uint=50):void
		{
			writer = new ZipFileWriter;			
			
			
			// loading the list if List is Not loaded
			if(!fileList.length) getFiles();
			
			
			// saving the file
			if(fileList.length)
			{
				isSaving = true;
				
				
				// cerate a new File to save zip file when it's not defined
				if(!saveFile)
				{
					saveFile = new File;
					saveFile.browseForSave('Saving the ZIP File');
					saveFile.addEventListener(Event.SELECT, function():void
					{
						compressFile(saveFile);
					});
				}
				else {
					compressFile(saveFile);
				}
				
			}
			
			
		}
		
		
		
		/**compress and save*/
		private function compressFile(saveFile:File, extention:String='zip', delay:uint=50):void
		{
			// getting the uncompressed size
			var usize:Number = uncompressedSize('B'); // getting total size of bytes on this folder or file
			var bytesLoaded:Number = 0;
			
			
			// adding extention to the name of file
			if(!saveFile.extension)
				saveFile.nativePath += '.' + extention;
			
			
			//opening the Zip file
			writer.open(saveFile);
			dispatchEvent(new Event(Event.OPEN));	 // dispatching the OPEN event
			
			
			
			
			
			// generating the file and ProgressEvent
			timer = new Timer(delay, fileList.length+1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, function():void
			{
				// Adding file to Zip File
				if(timer.currentCount <= fileList.length)
				{
					// making the path strings to be used on adding files to zip file
					var f:File = fileList.getItemAt(timer.currentCount-1) as File;
					var fileBase:String = StrUtils.replaceAll(f.nativePath, file.nativePath, '').slice(1);
					fileBase = StrUtils.replaceAll(fileBase,'%20', ' ');
					
					
					// adding Directories
					if(f.isDirectory) 
					{
						writer.addDirectory(fileBase); // adding Folder
					}
					else{
						// making url to be ready for 
						var filePath:String = fileBase.replace(f.name, '');
						filePath = filePath.slice(0, filePath.length-1);
						
						// stopping the Timer
						timer.stop(); 
						
						// writing the zip file
						if(StringUtils.hasText(filePath)){
							writer.addFile(f, filePath + '/' + f.name);
						}
						else{
							writer.addFile(f, f.name);
						}
						
						
						bytesLoaded += f.size; 																		// adding the Written file size to the total
						dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, bytesLoaded, usize)); // dispatvhing the progress event
						
						timer.start(); // running the Timer after saving and dispatching the Event
					}
				}
					
				// When the file is created
				else {
					writer.close();
					dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, bytesLoaded, usize)); // dispatvhing the progress event
					dispatchEvent(new Event(Event.COMPLETE)); // dispatvhing the progress COMPELETE event
					
					trace(fileList.length, ((fileList.length>1)?'Files':'File') + ' Added to ' + saveFile.name + ' -  Size: ' + uncompressedSize().toFixed(2) + ' MB (' + uncompressedSize('B').toString() + ' bytes)');
					isSaving = false;
				}
				
				
			});
		}
		
		
		
		
		
		
		
		/** <p>Pausing the running Save Process<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function pause():void
		{
			if(timer)
				if(timer.running)
				{
					isPaused = true;
					timer.stop();
				}
		}
		
		/** <p>Continuing the paused Saving Process<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function Continue():void
		{
			if(timer)
				if(!timer.running)
				{
					isPaused = false;
					timer.start();
				}
		}
		
		
		/** <p>canceling the Save Process </br>
		 * and zip file will be deleted<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function cancel(deleteFile:Boolean=true):void
		{
			// removing the timer
			if(timer){
				timer.stop();
				timer = null;
			}
			
			// closing the czip file
			writer.close();
			isPaused = false;
			isSaving = false;
			
			
			// deleting file
			if(deleteFile && saveFile.exists)
				saveFile.deleteFile();
			
			// dispatching the empty progress
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS)); // dispatvhing the progress event
		}
		
		
		
		
		

		/** <p>Uncompressed Size of Archive in Bytes <p/>
		 * 
		 * @param <strong>type</strong> - the Return Type </br>
		 * there is 5 type - B & KB & MB & GB & TB </br>
		 * Default is MB thet presents return type in MegaBytes 
		 * 
		 * @return Number - of size data based on type
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function uncompressedSize(type:String='MB'):Number 
		{
			var bytes:Number = 0;
			
			// loading the list if List is Not loaded
			if(!fileList.length) getFiles();
			
			
			// calculationg the size of all files
			for each(var file:File in fileList.source) 
				if(!file.isDirectory && file.exists)
					bytes += file.size;
			
			
			// changinf the type of return file
			switch(type.toLocaleUpperCase())
			{
				case 'TB': bytes = bytes / 1024;
				case 'GB': bytes = bytes / 1024;
				case 'MB': bytes = bytes / 1024;
				case 'KB': bytes = bytes / 1024;
			}	
			
			return bytes;
		}
		
		
		/** addinf files to the root of */
		public function ignoreFile(fi:File):void
		{
			iFiles.push(fi);
		}
		
		
		
		/** Getting All Files of directory */
		private function getFiles():void
		{
			// putting selected files on vector varriable
			if(file)
			{
				if(file.isDirectory){
					var fu:FileUtil = new FileUtil(file);
					fileList.source = fu.getFiles(null, iFiles);
				}
				else{
					fileList.addItem(file);
				}
			}
			
		}
		
	}
}