package com.alborzsoft.net
{
	/** URL class is for making and getting diffrent values of a URL address 
	 * <p>Last modification date: 2015/07/01</p>
	 * @author Akbar Goldust
	 */	
	public class URL
	{
		/**URL of Site*/
		public var url:String;
		
		
		
		public function URL(url:String)
		{
			this.url = url;
		}
		
		
		/** url like <strong>www.site.com</strong>*/
		public function get url_root():String 
		{
			return 'www.' + url_root_noWWW;
		}
		
		/** url like <strong>site.com</strong>*/
		public function get url_root_noWWW():String 
		{
			return siteDomain(url_noWWW);
		}
		
		
		/** url like <strong>site.com/keyword</strong>*/
		public function get url_noWWW():String 
		{
			var str:String = new String(url.toLocaleLowerCase());
			
			// removing HTTP and HTTPS
			str = str.replace(/htt(ps:\/\/|p:\/\/)/g, "");
			
			// removing www. from begining og url
			if(str.substr(0, 4) == "www.")
				str = str.substr(4);
			
			return str;
		}
		
		/** url like <strong>www.site.com/keyword</strong>*/
		public function get url_plain():String
		{
			return "www." + url_noWWW;
		}
		
		/** url like <strong>http://www.site.com/keyword</strong>*/
		public function get url_http():String 
		{
			return "http://" + url_plain;
		}
		
		/** url like <strong>http://site.com/keyword</strong>*/
		public function get url_http2():String 
		{
			return "http://" + url_noWWW;
		}
		
		/** url like <strong>https://www.site.com/keyword</strong>*/
		public function get url_https():String 
		{
			return "https://" + url_plain;
		}
		
		/** url like <strong>https://site.com/keyword</strong>*/
		public function get url_https2():String 
		{
			return "https://" + url_noWWW;
		}
		
		
		/**True if it has protocol*/
		public function get hasProtocol():Boolean 
		{
			return (url.substr(0,7) == "http://" || url.substr(0,8) == "https://")
		}
		
		
		public function get hasSlash():Boolean 
		{
			return (url.charAt(url.length-1) == "/");
		}
		
		
		
		/** get's the Main Domain name of a Full addreess URL    ,like http://google.com/ddf  >>  google.com
		 * @param site - String of Full Path URL
		 * @return String - of domain name
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function siteDomain(site:String):String
		{
			// removing HTTP and HTTPS
			site = site.replace(/htt(ps:\/\/|p:\/\/)/g, "");
			
			if(site.search('#') != -1) site = site.substr(0, site.search('#'));
			if(site.search('?') != -1) site = site.substr(0, site.search('?'));
			if(site.search('/') != -1) site = site.substr(0, site.search('/'));
			
			return site;
		}
	}
}