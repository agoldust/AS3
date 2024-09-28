package com.alborzsoft.web.icecast.types
{
	/**<p>XSPF file of Icecast Server</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Apr 25, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, Flash 10
	 */
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	
	
	
	
	//================================ EVENTS ======================================
	/** Will be dispatched when XSPF file loaded and all propeties setted */
	[Event(name="complete", type="flash.events.Event")]

	
	
	
	
	
	
	public class IcecastXSPF extends EventDispatcher
	{
		//================================ VARRIABLES ======================================
		/** URL of Icecast Station */
		public var XSPF_URL:String;
		
		/** Station Title */
		public var title:String;
		
		/** Owner of Icecast Station */
		public var creator:String;
		
		/** List of Icecast Track s */
		public var trakList:Vector.<Track>;
		
		
		
		
		//================================ FUNCTIONS ======================================
		public function IcecastXSPF(XSPF_URL:String)
		{
			this.XSPF_URL = XSPF_URL;
			load(XSPF_URL);
		}
		
		
		/** <p>Loading XSPF file<p/>
		 * 
		 * @param url - String value of XSPF URL, default=XSPF_URL
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function load(url:String):void 
		{
			XSPF_URL = url; // set the XSPF_URL value
			
			// loading the XSPF file
			var loader:URLLoader = new URLLoader(new URLRequest(XSPF_URL));
			loader.addEventListener(Event.COMPLETE, fileLoaded);
		}
		
		/** <p>Reloading XSPF file<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function reload():void 
		{
			if(XSPF_URL != null) load(XSPF_URL);
			else {
				throw Error('You have to Configure XSPF_URL first.');
			}
		}
		
		
		/** forming data when it loaded */
		private function fileLoaded(event:Event):void
		{
			// removing the Namespace form XML string
			var str:String = String(event.target.data);
			var bof:int = str.search('xmlns');
			var eof:int = str.search('/0/');
			
			str = str.slice(0, bof-1) + str.slice(eof+4);
			
			
			// creating the TrakList
			var xml:XML = XML(str);
			trakList = new Vector.<Track>; // creating the List Varriale
			
			for each(var xml2:XML in xml.trackList.track)
			{
				var track:Track = new Track;
				
				track.title = xml2.title;
				track.location = xml2.location;
				track.annotation = xml2.annotation;
				
				trakList.push(track);
			}
			
			// dispatching Event.COMPLETE event
			dispatchEvent(new Event('complete'));
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}