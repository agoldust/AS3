package com.alborzsoft.web.rdio.oauth
{
	import org.iotashan.utils.URLEncoding;

	public class TokenResult
	{
		public var oauth_token:String;
		public var oauth_token_secret:String;
		
		public var login_url:String;
		public var oauth_callback_url:String;
		public var oauth_callback_confirmed:Boolean;
		
		public var oauth_verifier:String;

		
		
		public function TokenResult(data:String)
		{
			if(data)
			{
				for each(var str:String in data.split('&')) 
				{
					var name:String = str.split('=')[0];
					var value:String = str.split('=')[1];
					
					
					if(name == 'oauth_callback_confirmed') 
						oauth_callback_confirmed = (value == 'true') ? true : false;
					
					else if(name == 'login_url') 
						login_url = URLEncoding.decode(value);
					
					else
						this[name] = value;
				}
				
			}
		}
		
		
		/**The Actual Page that needs to be open to able use for giving access to app*/
		public function get login_url2():String 
		{
			return login_url + '?oauth_token=' + oauth_token;;
		}
		
		
	}
}