package com.alborzsoft.web.kimonolabs
{
	import com.alborzsoft.web.kimonolabs.events.KimonoEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.managers.CursorManager;

	
	/**When Data Loaded From Server*/
	[Event(name="result", type="com.alborzsoft.web.kimonolabs.KimonoEvent")]
	
	
	public class KimonoLabs extends EventDispatcher
	{
		public static const URL_SERVER:String = "https://www.kimonolabs.com/api/";
		
		[Bindable] public var isLoading:Boolean;	
		
		public var api_id:String;
		public var api_key:String;
		
		private var showCurserBusy:Boolean;
		
		
		/**Constrauctor
		 * @param api_id - String - Your API_ID
		 * @param api_key - String API_Key of your pplication
		 */
		public function KimonoLabs(api_id:String, api_key:String)
		{
			this.api_id = api_id;
			this.api_key = api_key;
		}
		
		
		
		/**URL of result data*/
		public function get url():String 
		{
			var url:String = URL_SERVER + api_id + '?apikey=' + api_key;
			
			return url;
		}
		
		/**Loading Current URL's Data in JSON Format
		 * @param params - String - Params of request
		 * @showCurserBusy - if true, it will change cursor to busy when it's loading data*/
		public function loadJSON(params:String='', showCurserBusy:Boolean=false):void
		{
			isLoading = true;
			this.showCurserBusy = showCurserBusy;
			
			var urll:URLLoader = new URLLoader(new URLRequest(url+params));
			urll.addEventListener(Event.COMPLETE,					 onJSONLoaded);
			urll.addEventListener(IOErrorEvent.IO_ERROR,			 removeLoadingStatus);
			urll.addEventListener(SecurityErrorEvent.SECURITY_ERROR, removeLoadingStatus);
			
			if(this.showCurserBusy)
				CursorManager.setBusyCursor();
		}
		
				
		
		/**When JSON data loaded*/
		protected function onJSONLoaded(event:Event):void
		{
			removeLoadingStatus();
			
			var kimObj:KimonoObject = KimonoObject.getKimonoObject(event.target.data);
			dispatchEvent(new KimonoEvent(KimonoEvent.RESULT, kimObj));
		}
		
		/**When Loading JSON data failed*/
		protected function removeLoadingStatus(e:*=null):void
		{
			isLoading = false;
			
			if(this.showCurserBusy)
				CursorManager.removeBusyCursor();
		}
		
	}
}