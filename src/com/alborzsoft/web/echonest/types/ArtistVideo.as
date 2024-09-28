package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.Util;

	public class ArtistVideo
	{
		public var id:String;
		public var title:String;
		public var site:String;
		public var url:String;
		public var image_url:String;
		public var date_found:String;

		public function ArtistVideo(data:Object)
		{
			Util.copyDataClass(data, this);
		}
		
		public function get date_founded():Date 
		{
			return TimeConvertor.YYYYMMDD_HHMMSS__2__Date(date_found);
		}
		
	}
}