package com.alborzsoft.web.google
{
	//import com.adobe.serialization.json.JSON;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.google.types.GwebResult;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	/**==================== EVENTS ========================*/	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="ioError",  type="flash.events.IOErrorEvent")]
	
	
	
	
	[Bindable]
	public class GoogleSearch extends EventDispatcher
	{

		/** ========================== GOOGLE SEARCH =============================== */
		// =========================== CONSTANTS  ===============================
		private const API_URL:String = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0";
		private const MAX_RESULT:int = 8;
		
		
		// =========================== PRIVATE VARRIABLES ===============================
		private var currentWebResultStart:int = 0;
		private var currentWebRequestPageIndex:int = 0;
		
		
		// =========================== PUBLIC VARRIABLES===============================
		/**API Key of your Application to use on Gogle API*/
		public var apiKey:String;
		
		/**Result of Search*/
		public var result:Array;
		
		/**Keyword of Search*/
		public var keyword:String;
		
		/** <p>Loading State - true when it's loading<p/>*/
		public var isLoading:Boolean;
		public var webSearchStatus:String;
		
		/**Estimated Result Count of this Query*/
		public var estimatedResultCount:int = 0;
		
		/**Estimated Page Count of this Query*/
		public var estimatedPageResultCount:int = 0;
		
		
		
		
		
		
		/** ========================== METHODS =============================== */
		public function GoogleSearch(apiKey:String)
		{
			result = new Array;
			isLoading = false;
			
			this.apiKey = apiKey;
		}
		
		
		
		//set the search keywords
		public function search(keyword:String, startIndex:int=0):void
		{
			if(StringUtils.isEmpty(keyword)) return; //return if there is no keyword
			
			// doing the search
			result = null;								// clearing previuse data's
			isLoading = true;
			this.keyword = keyword;						// set the KEYWORD parameter
			currentWebRequestPageIndex = startIndex ;	// set current search page 0
			currentWebResultStart = MAX_RESULT * currentWebRequestPageIndex + 1;
			
			
			var url:String = API_URL + 
							'&rsz=' + MAX_RESULT +
							'&q=' + keyword + 
							'&start=' + currentWebResultStart + 
							'&key=' + apiKey;
			
			
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(Event.COMPLETE, onGoogleSearchResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		// dispatching the io error
		private function onIOError(event:IOErrorEvent):void
		{
			dispatchEvent(event);
		}
		
		
		
		// Search Result of Google
		private function onGoogleSearchResponse(event:Event):void
		{
			// end og load section
			isLoading = false;

			// FORMING THE DATA
			try {
				// set the result varriables
				//var json:Object			 = JSON.decode(event.target.data as String);
				var json:Object			 = JSON.parse(event.target.data as String);
				var webResposePage:int	 = int(json.responseData.cursor.currentPageIndex);
				var arrTemp:Array 		 = json.responseData.results;
			} catch(ignored:Error) {
			}
			
			
			result = new Array;
			
			for each(var gw:Object in arrTemp)
				result.push(new GwebResult(gw.unescapedUrl, gw.url, gw.visibleUrl, gw.title, gw.titleNoFormatting, gw.content, gw.cacheUrl));
			
				
			
			// set the estimated page and result
			estimatedResultCount	 = int(json.responseData.cursor.estimatedResultCount);
			estimatedPageResultCount = int(estimatedResultCount / result.length) + 1
			
			webSearchStatus	= "Displaying "
							+ ((currentWebRequestPageIndex * MAX_RESULT) + 1)
							+ " - " 
							+((currentWebRequestPageIndex * MAX_RESULT) + json.responseData.cursor.pages.length)
							+ " of " + String(estimatedResultCount);	
			
			//dipatch event to set the Data of parent Component
			dispatchEvent(new Event('complete'));
		}
		
		
		public function get enablePreviuseButton():Boolean 
		{
			return (currentWebRequestPageIndex == 0) ? false : true;
		}
		
		public function get enableNextButton():Boolean 
		{
			return (currentWebRequestPageIndex >= estimatedPageResultCount) ? false : true;
		}
		
		
		
		public function nextWebResultPage():void
		{
			if(currentWebRequestPageIndex < estimatedPageResultCount)
			{
				search(keyword, ++currentWebRequestPageIndex);
			}
		}
		
		public function previousWebResultPage():void
		{
			if(currentWebRequestPageIndex > 0)
			{
				search(keyword, --currentWebRequestPageIndex);
			}
		}
		
		
		/**Avalblity of result data*/
		public function get hasResult():Boolean 
		{
			if(result == null) return false;
			
			return (result.length > 0);
		}
		
		
	}
}