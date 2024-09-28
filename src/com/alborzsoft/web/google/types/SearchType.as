package com.alborzsoft.web.google.types
{
	import com.alborzsoft.net.URL;

	/**Search Phrase Type containing url and keyboard*/
	public class SearchType extends URL
	{
		/**Keyword Phrase of search*/
		public var keyword:String;
		
		/**Limit search result pages*/
		public var limit:int;
		
		
		public function SearchType(keyword:String, url:String="", limit:int=100)
		{
			super(url);
			
			this.keyword = keyword;
			this.limit = limit;
		}
		
		
		
		/**Determining that it's the same URL
		 * 
		 * @param address - url of site
		 * @return Bolean - true of its the same url
		 */
		public function isSameURL(address:String):Boolean
		{
			// fixing the Forward slash missing
			var hasSlash2:Boolean = (address.charAt(address.length-1) == "/");
			
			if(hasSlash && !hasSlash2) address += "/";
			if(!hasSlash && hasSlash2) url += "/";
			
			
			// cheking the URL without HTPP or HTTPS
			address = address.toLowerCase();
			
			return (url_noWWW  == address || url_plain  == address ||
					url_http   == address || url_http2  == address ||
					url_https  == address || url_https2 == address)
		}
		
		
		/**Determining that the URL is in the root of address
		 * 
		 * @param address - url of site
		 * @return Bolean - true of its the same url
		 */
		public function hasSameRoot(address:String):Boolean
		{
			var url2:URL = new URL(address.toLowerCase());
			
			return (url_root == url2.url_root || url_root_noWWW == url2.url_root_noWWW)
		}
		
		
	}
}