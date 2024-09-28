package com.alborzsoft.web.rdio
{
	import com.adobe.crypto.HMAC;
	import com.adobe.crypto.MD5;
	import com.adobe.crypto.SHA1;
	import com.adobe.utils.DateUtil;
	import com.alborzsoft.web.rdio.oauth.RdioOAuth;
	import com.alborzsoft.web.rdio.oauth.TokenResult;
	import com.alborzsoft.web.rdio.oauth.events.OAuthEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import mx.utils.UIDUtil;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthSignatureMethod_PLAINTEXT;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.utils.URLEncoding;
	
	import spark.components.Window;
	
	
	
	//======================= EVENTS ==============================
	/**When I/O Error happend*/
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	
	public class Rdio extends EventDispatcher
	{
		//======================= PUBLIC CONSTANTS ==============================
		public static const SERVER:String = 'http://api.rdio.com/';
		
		public static const API_REQUEST_TOKEN:String = SERVER + 'oauth/request_token';
		public static const API_ACCESS_TOKEN:String  = SERVER + 'oauth/access_token';
		
		public static const API_REQUESTS:String = SERVER + '1/';

		
		
		//======================= PUBLIC VARRIABLES ==============================
		public var oauth:RdioOAuth;

		
		//======================= METHODS ==============================
		
		/** <p>Rdio Class<p/>
		 * 
		 * @param consumer  - OAuthConsumer
		 * @param oauth_callback  - CallBack URL to your site
		 * @param auto - if true, it will request the token, and after that will open 
		 */
		public function Rdio(consumer:OAuthConsumer, oauth_callback:String, auto:Boolean=true)
		{
			oauth = new RdioOAuth(consumer, oauth_callback, auto);
		}
		
		
		
		public function currentUser(extras:String=''):void
		{
			var params:Object = new Object;
			params.method = "currentUser";
			
			var req:URLRequest = getURLRequestPOST(oauth.consumer, Rdio.API_REQUESTS, params, oauth.access_token);
			var urll:URLLoader = new URLLoader(req);
			urll.addEventListener(Event.COMPLETE, onUser);
			urll.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		protected function onUser(event:Event):void
		{
			trace('on user');
		}		
		
		
		/** <p>Get all of the tracks by this artist. 
		 * Does not require user authentication<p/>
		 * 
		 * @param artist 	 - required — the artist — a key
		 * @param appears_on - optional — returns tracks that the artist appears on rather than tracks credited to the artist — a boolean as either "true" or "false"
		 * @param extras 	 - optional — a list of additional fields to return — a list, comma separated
		 * @param start		 - optional — the offset of the first result to return — an integer
		 * @param count		 - optional — the maximum number of results to return — an integer - required — the artist — a key
		 */
		public function getTracksForArtist(artist:String, appears_on:Boolean=false, extras:String='', start:int=-1, count:int=-1):void
		{
			var params:Object = new Object;
			params.method = "getTracksForArtist";
			params.artist = artist;
			
			var req:URLRequest = getURLRequestPOST(oauth.consumer, Rdio.API_REQUESTS, params, oauth.access_token);
			var urll:URLLoader = new URLLoader(req);
			urll.addEventListener(Event.COMPLETE, onArtistTracks);
			urll.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
		
		protected function onArtistTracks(event:Event):void
		{
			trace(event.target.data);
		}		
		
		private function getParam(name:String, value:String):String
		{
			return name + "=" + URLEncoding.encode(value);
		}
		
		
		
		
		
		
		
		/**Making URLRequest Ready to use
		 * @param requestParams - Params that needs to be sent via POST
		 * */
		public static function getURLRequestPOST(consumer:OAuthConsumer, requestURL:String, requestParams:Object=null, token:OAuthToken=null):URLRequest
		{
			var signature:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1(); // making Signature
			var oAuthReq:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_POST, requestURL, requestParams, consumer, token);
			
			var urlr:URLRequest = new URLRequest(requestURL);
			urlr.method = URLRequestMethod.POST;
			urlr.url = oAuthReq.buildRequest(signature, OAuthRequest.RESULT_TYPE_URL_STRING);
			
			return urlr;
		}
		
		
		
		
		
		
		
		
		
		
	}
}