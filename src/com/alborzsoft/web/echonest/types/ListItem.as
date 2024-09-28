package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;
	
	public class ListItem
	{
		public var id:String;
		public var name:String;
		
		public function ListItem(data:Object=null)
		{
			Util.copyDataClass(data, this);
		}
	}
}