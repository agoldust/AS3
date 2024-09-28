package com.alborzsoft.controls
{
	/**<p>Favicon Image component</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Oct 8, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Lite 4, Flash 9, AIR 1.5
	 */
	import com.adobe.images.PNGEncoder;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import spark.components.Image;
	
	
	
	
	[IconFile("Favicon.png")]
	
	
	public class Favicon extends Image
	{
	//=============================== VARRIABLES =================================
		//----------- CONSTS
		private static const API_URL:String = 'https://plus.google.com/_/favicon?domain=';
		
		private static const ICON_FOLDER:String = '/cach/image/favicon/';
		
		
		private var domain:String;
		private var cacheImage:Boolean;
		
		
		

	//=============================== METHODS =================================
		public function Favicon(location:String='', cacheImage:Boolean=true)
		{
			super();
			super.width = 16;
			super.height = 16;
			//super.smoothBitmapContent = true;
			super.smooth = true;
			super.setStyle('smoothingQuality', 'high');
			
			this.cacheImage = cacheImage;
			
			// setting the location of favicon
			if(StringUtils.hasText(location))
				this.location = location;
		}
		

		
		/** <p>Location of Favicon Image<p/> */
		public function set location(url:String):void 
		{
			domain = StrUtils.siteDomain(url);
			
			
			// checking if icon is saved
			var file:File = File.applicationStorageDirectory;
			file.nativePath += (ICON_FOLDER + domain + '.png');
			
			if(file.exists && cacheImage) {
				super.source = file.nativePath;
			}
			
			// when the icon isn't saved
			else {
				if(StringUtils.hasText(domain) && super.source != domain)
				{
					super.source = API_URL + domain;
					
					if(cacheImage) 
						super.addEventListener(Event.COMPLETE, onFaviconLoad);
				}
				else if(StringUtils.isEmpty(domain))
				{
					super.source = '';
				}
			}
		}
		
		
		
		private function onFaviconLoad(event:Event):void
		{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += (ICON_FOLDER + domain + '.png');
			
			var fs:FileStream = new FileStream;
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(PNGEncoder.encode(this.bitmapData));
			fs.close();
			
			// removing the event Listener
			super.removeEventListener(Event.COMPLETE, onFaviconLoad);
		}
		
		
		
		
		
		
	}
}