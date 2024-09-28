package com.alborzsoft.web.google
{
	import com.adobe.utils.XMLUtil;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.Util;
	import com.alborzsoft.web.google.types.CardResult;
	import com.alborzsoft.web.google.types.GwebResult;
	import com.alborzsoft.web.google.types.MapListingResult;
	import com.alborzsoft.web.google.types.SearchType;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.ResultEvent;
	
	
	/**When data is Received!!*/
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	

	/**Loading Google Search Engine Results Pages*/
	public class GoogleSERP extends EventDispatcher
	{
		/** ========================== GOOGLE SEARCH =============================== */
		// =========================== CONSTANTS  ===============================
		public static const MAX_RESULT:int = 100;
		private const API_SERVER:String = "https://www.google.com/search?hl=en&q=";
		private const API_URL:String = API_SERVER + "&num=" + MAX_RESULT + "&gws_rd=ssl";
		
		
		// =========================== PUBLIC VARRIABLES===============================
		[Bindable] public var loading:Boolean = false;
		
		public var urll:URLLoader = new URLLoader;
		public var currentSearch:SearchType;
		
		public var paused:Boolean = false;
		private var urlRequest:URLRequest;
		
		
		public function GoogleSERP(search:SearchType=null)
		{
			if(search){
				load(search);
			}
			
			// adding events of loader
			urll.addEventListener(Event.COMPLETE,			onHtmlComplete);
			urll.addEventListener(Event.OPEN,				onOpen);
			urll.addEventListener(ProgressEvent.PROGRESS,	onProgress);
			
			urll.addEventListener(IOErrorEvent.IO_ERROR,	function():void
			{
				loading = false;
				
				if(paused == false)
				{
					trace('I/O Error!! trying to load again');
					Util.doIn(2000, reloadData);
				}
			});
		}
		
		protected function onProgress(event:ProgressEvent):void
		{
			loading = true;
			dispatchEvent(event);
		}
		
		/**Getting URL that needs to be loaded*/
		public function getURL(search:SearchType):String 
		{
			return API_SERVER + search.keyword + "&num=" + search.limit + "&gws_rd=ssl&sourceid=chrome";
		}
		
		
		/**Loading search Results*/
		public function load(search:SearchType):void
		{
			currentSearch = search;
			urlRequest = new URLRequest(getURL(currentSearch))
				
			reloadData();
		}
		
		/**Loading current search*/
		public function reloadData():void
		{
			if(currentSearch == null){
				trace("currentSearch is null");
				return;
			}
			
			paused = false;
			
			// malinh URLLoader
			urll.load(urlRequest);
		}
		
		protected function onOpen(event:Event):void
		{
			trace("opened!");
			loading = true;
			paused = false;
		}
		
		
		public function close():void
		{
			paused = true;
			
			if(loading)
				urll.close();
			else
				trace("it's not loading");
			
			loading = false;
		}
		
		
		protected function onHtmlComplete(e:Event):void
		{
			loading = false;
			var ret:Array = new Array;
			var html_str:String = e.target.data;
			
			//----------- stripping the unsable tags
			html_str = StrUtils.replaceAll2(html_str, ["<!--m-->", "<!--n-->"], "");	// removing the comments
			html_str = html_str.replace(/\sonmousedown=\"(.*?)\"/gim, "");				// removing the onmousedown events
			html_str = html_str.replace(/<img[^<]+?>/g, "");							// removing image tags
			
			trace(html_str);
			
			
			//------------- GETTING ADS LISTINGS
			
			
			//------------- GETTING REGULAR RESULT LISTINGS
			var arr_ads:Array = html_str.match(/<div class="g tler_result[^(<div)](.*?)><\/div><\/div><\/div><\/div>/gim);
			
			for each(var div_ads:String in arr_ads) 
				ret.push(MapListingResult.formatRawData(div_ads));
			
			//------------- GETTING REGULAR RESULT LISTINGS
			var arr:Array = html_str.match(/<div class="g card-section[^(<div)](.*?)>((<\/div><\/div><\/div><\/div><\/div><\/div>)|(<\/div><\/div><\/div><\/div>))/gim);
			
			for each(var div:String in arr) 
				ret.push(CardResult.formatRawData(div));
			
			
			
			/*
			for each(var div:String in arr) 
			{
				//------------- GETTING ADS LISTINGS
				//------------- GETTING MAP LISTINGS
				if(div.match('<div class="g tler_result'))
					ret.push(MapListingResult.formatRawData(div));
				
				//------------- GETTING REGULAR RESULT LISTINGS
				else if(div.match('<div class="g card-section'))
					ret.push(CardResult.formatRawData(div));
			}*/
			
			
			// dispatching result
			dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, ret));
		}
		
		
		
	}
}