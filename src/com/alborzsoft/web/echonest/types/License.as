package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;
	
	import mx.utils.ObjectUtil;

	public class License
	{
		public var type:String;
		public var attribution:String;
		public var attribution_url:String;
		public var url:String;
		public var version:String;
		
		public function License(data:Object=null)
		{
			if(data)
			{
				var att:Object = ObjectUtil.getClassInfo(data);
				
				for each(var qn:QName in att.properties) 
				{
					if(qn.localName == 'attribution-url') 
						this.attribution_url = ObjectUtil.copy(data[qn.localName]) as String;
					
					else
						this[qn.localName] = ObjectUtil.copy(data[qn.localName]);
				}
			}
		}
	}
}