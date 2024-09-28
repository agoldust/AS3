package com.alborzsoft.web.bitly
{
	/**<p>URL Shortening Class for Bitly.com server</p>
	 * <p>Api Documentation : <b>http://code.google.com/p/bitly-api/wiki/ApiDocumentation</b>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Dec 12, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10, AIR 1.5
	 * @productversion Flex 4
	 */
	//import com.adobe.serialization.json.JSON;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	
	
	
	//==================================== EVENTS =======================================
	[Event(name="error",  type="flash.events.ErrorEvent")]
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]

	
	
	public class Bitly extends EventDispatcher
	{
		
	//==================================== CONSTANTS =======================================
		private const BITLY_API:String="http://api.bit.ly/shorten?version=2.0.1&longUrl=";
		
		
	//==================================== VARRIABLES =======================================
		private var username:String;
		private var apiKey:String;
		private var longURL:String;
		
		
	//==================================== METHODS =======================================
		/** <p>URL Shortening Class for Bitly.com server<p/>
		 * 
		 * @param username - your username of Bitly.com server
		 * @param apiLKey - API KEY of your application that is generated from <b>http://bit.ly/a/your_api_key/<b>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function Bitly(username:String, apiKey:String)
		{
			this.username = username;
			this.apiKey = apiKey;
		}
		
		
		/** <p>Getting Shorten url from server<p/>
		 * 
		 * @param longURL - The URL that we need to be shorten
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function getShortURL(longURL:String):void
		{
			this.longURL = longURL;
			
			var url:String = BITLY_API + longURL + "&login=" + username + "&apiKey=" + apiKey;
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			
			loader.addEventListener(Event.COMPLETE, onResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
		}
		
		//when data is back from server
		private function onResult(event:Event):void
		{
			var shortenURL:String;
			//var bitlyObj:Object = JSON.decode(event.target.data);
			var bitlyObj:Object = JSON.parse(event.target.data);
			
			if (bitlyObj.statusCode == "OK")
			{
				var result:BitlyResult = new BitlyResult;
				var res:Object = bitlyObj.results[longURL];
				
				result.longURL = longURL;
				result.hash = res.hash;
				result.userHash = res.userHash;
				result.shortCNAMEUrl = res.shortCNAMEUrl;
				result.shortKeywordURL = res.shortKeywordURL;
				result.ShortURL_dynamic = res.shortUrl;
				
				dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, result));
			} 
			else {
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, bitlyObj.errorMessage, bitlyObj.errorCode));
			}
		}
		
		
	}
}

