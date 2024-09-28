package com.alborzsoft.web.microsoft
{
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.microsoft.events.BingResultEvent;
	import com.alborzsoft.web.microsoft.types.BingWebResult;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import flexunit.utils.ArrayList;
	
	
	
	/**==================== EVENTS ========================*/	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="ioError",  type="flash.events.IOErrorEvent")]
	
	
	[Bindable]
	public class BingSearch extends EventDispatcher
	{
		
		/** ========================== GOOGLE SEARCH =============================== */
		// =========================== CONSTANTS  ===============================
		private const API_URL:String	= "http://api.search.live.net/xml.aspx?";
		private const sourceType:String = "web";
		private const MAX_RESULT:int	= 10;
		
		
		// =========================== PRIVATE VARRIABLES ===============================
		private var _appID:String;
		private var currentWebResultStart:int = 0;
		private var currentWebRequestPageIndex:int = 0;
		
		
		// =========================== PUBLIC VARRIABLES===============================
		public var result:Array;
		public var keyword:String;
		public var isLoading:Boolean;
		public var webSearchStatus:String;


		public var estimatedResultCount:int = 0;
		public var estimatedPageResultCount:int = 0;
		
		
		
		
		
		
		/**========================= Bing SEARCH FUNCTIONS ===========================*/
		/** Bing Constructor
		 * @param applicationID - String ID code of your Application
		 */
		public function BingSearch(applicationID:String)
		{
			result = new Array;
			isLoading = false;
			appID = applicationID
		}
		
		
		
		/** Searching a Keyword
		 * @param keyword - String of search Keyword
		 * 
		 * @langversion ActionScript 3.0
	     * @playerversion Flash 9.0
	     * @tiptext
		 */
		public function search(keyword:String, startIndex:int=0):void
		{
			if(StringUtils.isEmpty(keyword)) return; //return if there is no keyword
			
			// doing the search
			result = null;
			isLoading = true;
			this.keyword = keyword;
			currentWebRequestPageIndex = startIndex;
			currentWebResultStart = MAX_RESULT * currentWebRequestPageIndex;
			
			
			var loader:URLLoader = new URLLoader(new URLRequest(URL));
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(Event.COMPLETE, onBingSearchResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		
		// dispatching the io error
		private function onIOError(event:IOErrorEvent):void
		{
			dispatchEvent(event);
		}
		
		
		
		/** get the request URL for the webAPI
		 */
		public function get URL():String
		{
			var url:String;
			
			url  = API_URL;
			url += 'Appid='			+ appID;
			url += '&sources='		+ sourceType;
			url += '&query='		+ keyword;
			url += '&web.Offset='	+ currentWebResultStart;
			
			return url;
		}
		
		
		/** set the your Application ID for Bing Search
		 * @example here is the Home Page = http://www.bing.com/developers
		 *  you can get ID here   = http://www.bing.com/developers/createapp.aspx
		 * 
		 * @param id - the ID of Application for Bing Search
		 */
		public function set appID(id:String):void
		{
			_appID = id;
		}
		public function get appID():String
		{
			return _appID;
		}
		
		
		
		
		// Search Result of Yahoo
		private function onBingSearchResponse(event:Event):void
		{
			// end og load section
			isLoading = false;

			// removing Schema from XML
			var xml:XML = XML(event.target.data);
			var str:String = xml.toXMLString();
			
			str = StrUtils.replaceAll(str, ' xmlns="http://schemas.microsoft.com/LiveSearch/2008/04/XML/element"', '');
			str = StrUtils.replaceAll(str, ' xmlns:web="http://schemas.microsoft.com/LiveSearch/2008/04/XML/web"', '');
			str = StrUtils.replaceAll(str, 'web:', '');
			
			xml = XML(str);
			
			
			// using from formed XML file
			var response:Object = xml.Web;
			
			var total:int  = response.Total;
			var offset:int = response.Offset;
			var xmll:XMLList = response.Results.WebResult;
			
			

			result = new Array;
			var bingResult:BingWebResult;
			
			for each(var op:XML in xmll)
			{
				bingResult = new BingWebResult;
				bingResult.url = op.Url;
				bingResult.title = op.Title;
				bingResult.cacheUrl = op.CacheUrl;
				bingResult.dateTime = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(op.DateTime);
				bingResult.displayUrl = op.DisplayUrl;
				bingResult.description = op.Description;
				
				result.push(bingResult);
			}
			
			
			
			// set the estimated page and result
			estimatedResultCount	 = response.Total;
			estimatedPageResultCount = int(estimatedResultCount / result.length) + 1
			
			webSearchStatus	= "Displaying "
							+ String(currentWebResultStart)
							+ " - " 
							+ String(currentWebResultStart + result.length)
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
		
		
		

	}
}