package com.alborzsoft.web.google.types
{
	import com.alborzsoft.utils.StrUtils;

	
	public class YoutubeResult
	{
	//======================= PRIVATE VARRIALE ===========================
		public var logURL:String;
		
		public var itemsPerPage:uint;
		public var startIndex:uint;
		public var totalResults:uint;
		
		public var author:YoutubeAuthor;
		public var results:Vector.<YoutubeEntry>;
		public var updated:Date;
		
		
	//======================= PRIVATE VARRIALE ===========================
		private var _title:String;
		
		
		
		
	//======================= PRIVATE VARRIALE ===========================
		public function YoutubeResult()
		{
			author = new YoutubeAuthor;
			results = new Vector.<YoutubeEntry>;
		}
		
		
		/** title of Search */
		public function set title(value:String):void 
		{
			_title = StrUtils.replaceAll(value, 'YouTube Videos matching query: ', '');
		}
		public function get title():String 
		{
			return _title;
		}
		
	}
}