package com.alborzsoft.web.microsoft.types
{
	public class BingWebResult
	{
		public var title:String;
		public var description:String;
		public var displayUrl:String;
		public var url:String;
		public var cacheUrl:String;
		public var dateTime:Date;
		
		
		public function BingWebResult()
		{
		}
		
		
		/** it is returning description */
		public function get content():String 
		{
			return this.description;
		}
		
		/** it is returning displayUrl */
		public function get visibleUrl():String 
		{
			return this.displayUrl;
		}
		
		/** it is returning displayUrl */
		public function get unescapedUrl():String 
		{
			return this.url;
		}
		
		
	}
}