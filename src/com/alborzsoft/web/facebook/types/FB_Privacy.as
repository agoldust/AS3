package com.alborzsoft.web.facebook.types
{
	import com.alborzsoft.utils.StringUtils;

	public class FB_Privacy
	{
		public var value:String;
		public var description:String;
		
		
		//================= CONSTS
		public static const CUSTOM:String = 'CUSTOM';
		public static const ALL_FRIENDS:String = 'Friends';
		public static const FRIENDS_OF_FRIENDS:String = 'Friends of Friends';
		
		
		public function FB_Privacy(description:String, value:String)
		{
			this.value = value;
			this.description = description;
		}
		
		
		
		/** list of Name of Persons that can see this Post */
		public function get persons():Vector.<FB_Person>
		{
			var p:Vector.<FB_Person>;
			
			if(value == FB_Privacy.CUSTOM)
			{
				p = new Vector.<FB_Person>;
				
				for each(var str:String in description.split(','))
				{
					str = StringUtils.removeExtraWhitespace(str);
					p.push(new FB_Person('', str));
				}
			}
			
			
			return p;
		}
		
		
	}
}