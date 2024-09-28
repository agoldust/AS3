package com.alborzsoft.web.rdio.oauth
{
	import com.alborzsoft.web.rdio.Rdio;
	import com.alborzsoft.web.rdio.oauth.events.OAuthEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;
	
	import spark.components.Window;
	
	
	
	/**When I/O Error happend*/
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	/**When Re Token Received*/
	[Event(name="tokenReceived", type="com.alborzsoft.web.rdio.oauth.events.OAuthEvent")]
	
	/**When Token Verifier Received*/
	[Event(name="tokenVerifireReceived", type="com.alborzsoft.web.rdio.oauth.events.OAuthEvent")]
	
	/**When Access Token Received*/
	[Event(name="accessTokenReceived", type="com.alborzsoft.web.rdio.oauth.events.OAuthEvent")]
	

	
	public class RdioOAuth extends EventDispatcher
	{
		//======================= PUBLIC VARRIABLES ==============================
		public var token:TokenResult;
		public var access_token:OAuthToken;
		public var consumer:OAuthConsumer;
		public var oauth_callback:String;

		
		//======================= PRIVATE VARRIABLES ==============================
		private var openLoginPage:Boolean;
		
		
		
		public function RdioOAuth(consumer:OAuthConsumer, oauth_callback:String, auto:Boolean=true)
		{
			this.consumer = consumer;
			this.oauth_callback = oauth_callback;
			
			if(auto)
				requestToken(auto);
		}
		
		
		
		
		/** <p>Requesting the Token for App<p/>
		 * 
		 * @param openLoginPage - if true, it will open Login Window after receiving the token
		 */
		public function requestToken(openLoginPage:Boolean=false):void
		{
			this.openLoginPage = openLoginPage;
			
			var req:URLRequest = RdioOAuth.getURLRequest(consumer, Rdio.API_REQUEST_TOKEN, {oauth_callback:this.oauth_callback});
			var urll:URLLoader = new URLLoader(req);
			urll.addEventListener(Event.COMPLETE, onTokenReceived);
			urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
		}
		
		
		/**On Token Result*/
		protected function onTokenReceived(event:Event):void
		{
			// setting data
			token = new TokenResult(event.target.data);
			token.oauth_callback_url = this.oauth_callback;
			dispatchEvent(new OAuthEvent(OAuthEvent.TOKEN_RECEIVED, false, false, token));
			
			
			// opening the login Window
			if(openLoginPage)
				handleRequestTokenReceived();
		}
		
		
		//When App Authorized and we will open a window for user to login*/
		protected function handleRequestTokenReceived():void
		{
			// making the HTML elements
			var isWindowOpened:Boolean;
			var swv:StageWebView = new StageWebView;
			swv.loadURL(token.login_url2);
			
			swv.addEventListener(LocationChangeEvent.LOCATION_CHANGE, function(event:Event):void
			{
				var loc:String = swv.location;
								
				if(loc.search('oauth_verifier=') >= 0)
				{
					var oc:OAuthConsumer = new OAuthConsumer
					var att:String = loc.split('\?')[1];
					
					for each(var str:String in att.split('&')) 
					{
						var name:String = str.split('=')[0];
						var value:String = str.split('=')[1];
						
						token[name] = value;
					}
					
					// getting token secret for user
					requestAccessToken();
					
					dispatchEvent(new OAuthEvent(OAuthEvent.SUCCESS));
					event.preventDefault();
					
					window.close();
					
					
				}
				
			});
			
			
			// making the login window
			var window:Window = new Window;
			window.showStatusBar = false;
			window.alwaysInFront = true;
			window.title = 'Log in  |  Rdio';
			window.minWidth = 600;
			window.minHeight = 400;
			window.maximizable = window.resizable = window.showStatusBar = false;
			
			window.open();
			
			swv.stage = window.stage;
			swv.viewPort = new Rectangle(0,0, 600, 400);
		}
		
		
		
		/** <p>Requesting the Access Token for User<p/> */
		public function requestAccessToken():void
		{
			var t:OAuthToken = new OAuthToken(token.oauth_token, token.oauth_token_secret);
			var req:URLRequest = RdioOAuth.getURLRequest(consumer, Rdio.API_ACCESS_TOKEN, {oauth_verifier:token.oauth_verifier}, t);
			var urll:URLLoader = new URLLoader(req);
			urll.addEventListener(Event.COMPLETE, onTokenSecretReceived);
			urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
		}
		
		protected function onTokenSecretReceived(event:Event):void
		{
			var key:String;
			var secret:String;
			
			for each(var str:String in event.target.data.split('&')) 
			{
				var name:String = str.split('=')[0];
				var value:String = str.split('=')[1];
				
					 if(name == 'oauth_token') 		  key = value;
				else if(name == 'oauth_token_secret') secret = value;
			}
			
			
			access_token = new OAuthToken(key, secret);
			dispatchEvent(new OAuthEvent(OAuthEvent.ACCESS_TOKEN_RECEIVED, false, false, access_token));
		}		
		
		
		
		
		
		//====================================== UTILS ===============================================
		/**Making URLRequest Ready to use
		 * @param requestParams - Params that needs to be sent via POST
		 * */
		public static function getURLRequest(consumer:OAuthConsumer, requestURL:String, requestParams:Object=null, token:OAuthToken=null):URLRequest
		{
			var signature:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1(); // making Signature
			var oAuthReq:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_MEHTOD_POST, requestURL, requestParams, consumer, token);
			
			var urlr:URLRequest = new URLRequest(requestURL);
			urlr.method = URLRequestMethod.POST;
			urlr.requestHeaders = [oAuthReq.buildRequest(signature, OAuthRequest.RESULT_TYPE_HEADER)];
			
			return urlr;
		}
		
	
		
		
	}
}