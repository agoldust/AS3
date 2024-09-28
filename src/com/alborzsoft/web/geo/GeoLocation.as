package com.alborzsoft.web.geo
{
	import com.alborzsoft.web.geo.types.LocationData;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.rpc.events.ResultEvent;
	
	
	
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	
	
	
	public class GeoLocation extends EventDispatcher
	{
	//==================================== CONSTS =========================================
		public static const SERVER:String = 'http://api.hostip.info/';
		public static const SERVER_JSON:String = SERVER + 'get_json.php';
		public static const SERVER_COUNTRY:String = SERVER + 'country.php';
		
		
		
		
	//==================================== VARRIABLES =========================================

		
		
		
		
	//==================================== METHODS =========================================
		public function GeoLocation()
		{
		}
		
		
		
		/** <p>Loading Data of User's Location<p/>
		 * 
		 * @param ip - IP of user, this can be null to detecet IP automatically
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function getCity(ip:String=null):void
		{
			var url:String = SERVER_JSON;
			
			// adding parameter to loader when therte was an IP
			if(ip != null) 
				url += '?ip=' + ip; 
			
			
			
			var urlReq:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader(urlReq);
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, locationLoaded);
		}
		
		
		// when location JSON data loaded
		private function locationLoaded(event:Event):void
		{
			if(event.target.data)
			{
				var location:LocationData = new LocationData;
				location.rawData = event.target.data;
			}
			
			dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, location));
		}
		
		
		
		
		
		
		
		
	}
}