package com.alborzsoft.database
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	
	/**==================== EVENTS ========================*/	
	[Event(name="complete", type="flash.events.Event")]
	
	
	
	
	public class xmlClass extends EventDispatcher
	{
		private var _xml:XML;
		private var url:String;
		
		
		/** <p>Loading and Saving XML file from HDD<p/>
		 * 
		 * @param 
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function xmlClass(url:String=null)
		{
			this.url = url;
			
			if(url!=null)
				loadXML(url);
		}
		
		
		
		/** <p>actual XML data<p/>
		 */
		public function get xmlData():XML 
		{
			return _xml;
		}
		
		
		/** <p>Loading XML file<p/>
		 * 
		 * @param url - String of address if XML file
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 10, AIR 1.0
		 */
		public function loadXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader(new URLRequest(url));
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		/** when xml loaded, Event.COMPLETE will be dispatched */
		private function xmlLoaded(event:Event):void
		{
			_xml = XML(event.target.data);
			
			dispatchEvent(new Event('complete'));
		}
		
		
		
		/** <p>Saving XML file<p/>
		 * 
		 * @param xml - XML of new file
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.0
		 */
		public function saveXML(xml:XML, target:String='/database/setting.xml'):void
		{
			_xml = xml; // setting the mail property
			
			// saving into HDD
			var file:File = File.applicationDirectory;
			file.nativePath += '/' + url;

			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(_xml.toXMLString());
			fs.close();
			
			trace('xml file saved!');
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}