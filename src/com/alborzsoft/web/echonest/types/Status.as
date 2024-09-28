package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;

	public class Status
	{
		public var code:int;
		public var message:String;
		public var version:Number;
		
		
		
		public static const SUCCESS:String = 'Success';
		
		
		public function Status(data:Object=null)
		{
			Util.copyDataClass(data, this);
		}
		
		
	}
}