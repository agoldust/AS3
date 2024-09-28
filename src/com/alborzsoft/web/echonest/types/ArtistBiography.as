package com.alborzsoft.web.echonest.types
{
	public class ArtistBiography
	{
		public var url:String;
		public var site:String;
		public var text:String;
		public var license:License;
		
		
		public function ArtistBiography(data:Object=null)
		{
			this.url = data.url;
			this.site = data.site;
			this.text = data.text;
			this.license = new License(data.license);
		}
	}
}