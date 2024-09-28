package com.alborzsoft.web.rdio.oauth.events
{
	import com.alborzsoft.web.rdio.oauth.TokenResult;
	
	import flash.events.Event;
	
	public class OAuthEvent extends Event
	{
		public static const SUCCESS:String = 'success';
		public static const TOKEN_RECEIVED:String = 'tokenReceived';
		public static const TOKEN_VERIFIRE_RECEIVED:String = 'tokenVerifireReceived';
		public static const ACCESS_TOKEN_RECEIVED:String = 'accessTokenReceived';
		
		
		public var data:*;
		
		
		public function OAuthEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:Object=null)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
	}
}