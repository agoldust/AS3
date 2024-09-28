package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.utils.Util;

	public class ArtistNews
	{
		public var id:String;
		public var name:String;
		public var summary:String;
		public var url:String;
		public var date_found:String;
		public var date_posted:String;

		public function ArtistNews(data:Object)
		{
			Util.copyDataClass(data, this);
		}
		
		public function get date_founded():Date 
		{
			return StringUtils.hasText(date_found) ? TimeConvertor.YYYYMMDD_HHMMSS__2__Date(date_found) : null;
		}
		
		
		public function get date_posted2():Date 
		{
			return StringUtils.hasText(date_posted) ? TimeConvertor.YYYYMMDD_HHMMSS__2__Date(date_posted) : null;
		}
		
	}
}