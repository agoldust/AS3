package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.utils.Util;

	public class ArtistReview
	{
		public var id:String;
		public var name:String;
		public var release:String;
		public var summary:String;
		public var url:String;
		public var image_url:String;
		
		public var date_found:String;
		public var date_reviewed:String;
		
		
		
		public function ArtistReview(data:Object)
		{
			Util.copyDataClass(data, this);
		}
		
		public function get date_found2():Date 
		{
			return StringUtils.hasText(date_found) ? TimeConvertor.YYYYMMDD_HHMMSS__2__Date(date_found) : null;
		}
		
		public function get date_reviewed2():Date 
		{
			return StringUtils.hasText(date_reviewed) ? TimeConvertor.YYYYMMDD_HHMMSS__2__Date(date_reviewed) : null;
		}
	}
}