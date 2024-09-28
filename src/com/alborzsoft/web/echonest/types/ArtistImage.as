package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;

	public class ArtistImage
	{
		public var url:String;
		public var license:License;
		
		public function ArtistImage(data:Object=null)
		{
			this.url = data.url;
			this.license = new License(data.license);
		}
	}
}