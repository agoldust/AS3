package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;

	public class Location
	{
		public var latitude:Number;
		public var longitude:String;
		public var location:Number;
		
		public function Location(data:Object=null)
		{
			Util.copyDataClass(data, this);
		}
	}
}