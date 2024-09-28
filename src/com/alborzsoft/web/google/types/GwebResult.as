package com.alborzsoft.web.google.types
{
	[Bindable]
	public class GwebResult
	{
		/** Supplies the raw URL of the result.  */
		public var unescapedUrl:String;
		
		/** Supplies an escaped version of the above URL.  */
		public var url:String;
		
		/** Supplies a shortened version of the URL associated with the result. Typically displayed in green, stripped of a protocol and path.  */
		public var visibleUrl:String;
		
		/** Supplies the title value of the result.  */
		public var title:String;
		
		/** Supplies the title, but unlike .title, this property is stripped of html markup (e.g., <b>, <i>, etc.).  */
		public var titleNoFormatting:String;
		
		/** Supplies a brief snippet of information from the page associated with the search result.  */
		public var content:String;
		
		/** Supplies a url to Google's cached version of the page responsible for producing this result. This property may be null indicating that there is no cache, and it might be out of date in cases where the search result has been saved and in the mean time, the cache has gone stale. For best results, this property should not be persisted.  */
		public var cacheUrl:String;
		
		
		
		public function GwebResult(unescapedUrl:String, url:String, visibleUrl:String, title:String, titleNoFormatting:String, content:String, cacheUrl:String)
		{
			this.url = url;
			this.title = title;
			this.content = content;
			this.visibleUrl = visibleUrl;
			this.unescapedUrl = unescapedUrl;
			this.cacheUrl = titleNoFormatting;
			this.titleNoFormatting = titleNoFormatting;
		}
	}
}