package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.utils.Util;

	public class Track
	{
		public var id:String;
		public var foreign_id:String;
		public var foreign_release_id:String;
		public var catalog:String;
		public var preview_url:String;
		public var preview_image:String;
		public var release_image:String;
		
		
		public function Track(data:Object=null)
		{
			Util.copyDataClass(data, this);
		}
		
		public function get hasImage():Boolean 
		{
			return StringUtils.hasText(image);
		}
		
		
		public function get hasMP3():Boolean 
		{
			return StringUtils.hasText(preview_url);
		}
		
		public function get image():String 
		{
			if(StringUtils.hasText(preview_image)) return preview_image;
			if(StringUtils.hasText(release_image)) return release_image;
			
			return null;
		}
	}
}