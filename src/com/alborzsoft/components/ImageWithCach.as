package com.alborzsoft.components
{
	/**<p>[[ UNFINISHED ]]  Image component with catch ability</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Oct 8, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash AIR 1.5
	 */
	import com.adobe.crypto.MD5;
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.alborzsoft.graphic.JPGEncoderProgressive;
	import com.alborzsoft.graphic.events.ImageResultEvent;
	import com.alborzsoft.net.Downloader;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.desktop.NativeApplication;
	import flash.display.BitmapData;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Image;
	
	
	
	//[IconFile("Favicon.png")]
	
	
	
	public class ImageWithCach extends Image
	{
		private var tryTimes:uint = 0;
		private const totalTryTimes:uint = 5;
		
		private var webURL:String;
		private var cachedFile:File;
		private var urlStream:URLStream;
		
		private var _enableSave:Boolean;
		private var menuItem:NativeMenuItem;
		
		[Bindable] public var isLoading:Boolean = false;
		
		
		
				
		//=============================== METHODS =================================
		public function ImageWithCach()
		{
			super();
			super.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		}

		protected function onLoadError(event:IOErrorEvent):void
		{
			if(cachedFile)
			{
				if(cachedFile.exists)
					super.source = cachedFile.nativePath;
				else
					load(this.webURL, this.cachedFile);
			}
		}		
		
		
		/** <p>Loading the Image and Saving on HDD and shoing on UI<p/>
		 * 
		 * @param <b>url</b> - location of file on web
		 * @param <b>catchFolder</b> - Catch Folder of Application Storage Directory
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9, AIR 1.5
		 */
		public function load(url:String, cachedFile:File=null):void 
		{
			if(url == null) return;
			
			
			this.webURL = url;
			
			
			// setting the place of Catch file
			if(cachedFile){
				this.cachedFile = cachedFile;
			}
			else
			{
				this.cachedFile = File.applicationStorageDirectory;
				this.cachedFile.nativePath += '/cach/image/public/' + MD5.hash(url) + '.jpg';
			}
			
			
			var urlr:URLRequest = new URLRequest(webURL);
			urlr.followRedirects = true;
			
			
			// checking if file is saved
			if(cachedFile.exists){
				super.source = cachedFile.nativePath; // getting file from HDD
				addSaveMenu();
			}
			else
				super.source = null;
			
			
			// checking if Image updated
			urlStream = new URLStream();
			urlStream.addEventListener(Event.COMPLETE		 , onStreamComplete);
			urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			urlStream.addEventListener(IOErrorEvent.IO_ERROR,  onStreamError);
			urlStream.load(urlr);
		}
		
		
		protected function onStreamComplete(event:Event):void
		{
			if(urlStream.connected)
			{
				var ba:ByteArray = new ByteArray
				urlStream.readBytes(ba);
				
				if(ba.bytesAvailable > 0)
					saveByteArray(ba); // saving file to the HDD
			}
			
			if(cachedFile.exists && super.bytesTotal != cachedFile.size)
			{
				super.source = cachedFile.nativePath;// showing the file
				super.dispatchEvent(event);
			}
			
			
			addSaveMenu();
		}
		
		
		protected function onProgress(event:ProgressEvent):void
		{
			if(cached)
				if(event.bytesTotal == super.bytesTotal)
					if(urlStream.connected){
						urlStream.close(); // closing stream
						urlStream.removeEventListener(ProgressEvent.PROGRESS, onProgress); // removing event Listener
					}
			
			// dispatching progress event
			if(!cached){
				isLoading = true;
				dispatchEvent(event);
			}
		}	
		
		
		protected function onStreamError(event:IOErrorEvent):void
		{
			if(tryTimes++ < totalTryTimes-1){
				urlStream.load(new URLRequest(this.webURL));
			}
				
			else{
				trace('image download error');
				dispatchEvent(event);
				tryTimes = 0;
				
				if(super.source == null)
					dispatchEvent(event);
			}
		}
		
		
		
		private function saveByteArray(ba:ByteArray):void
		{
			//Saving the JPG Image
			var fs:FileStream = new FileStream;
			fs.open(cachedFile, FileMode.WRITE);
			fs.writeBytes(ba);
			fs.close();
		}
				
		
		/** <p>True When image downloaded and saved to HDD<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function get cached():Boolean 
		{
			if(super.source == null) return false;
			
			var file:File = new File(super.source as String);
			
			return file.exists;
		}
		
		
		
		
		//==================================== COPY - SAVE IMAGE TO ANOTHER PLACE ===========================
		public function get enableSave():Boolean
		{
			return _enableSave;
		}
		
		/**if you set True, it enables users to save Image*/
		public function set enableSave(value:Boolean):void
		{
			_enableSave = value;
			
			if(value && cachedFile)
			{
				if(cachedFile.exists) addSaveMenu();
			}
			else {
				super.contextMenu = null;
			}
		}
		
		
		
		private function addSaveMenu():void
		{
			if(enableSave)
			{
				menuItem = new NativeMenuItem('Save image as...');
				menuItem.addEventListener(Event.SELECT, onSave);
				
				super.contextMenu = new NativeMenu;
				super.contextMenu.addItem(menuItem);
			}

		}		
		
		protected function onSave(event:Event):void
		{
			var file:File = File.documentsDirectory;
			file.nativePath += '/' + cachedFile.name; // filling base name
			
			file.browseForSave('Save As'); // selecting file name for save
			
			file.addEventListener(Event.SELECT, function():void 
			{
				if(file.extension.length == 0)
					file.nativePath += cachedFile.extension; // fixing the extention, if it's empty
				
				cachedFile.copyToAsync(file, true); // copying the file
				
				menuItem.checked = true; // making the Item checked
			});
		
		}
		
		
		
	}
}