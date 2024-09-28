package com.alborzsoft.web.facebook.types
{
	public class FB_StatusVideo extends FB_StatusText
	{
		/** ID of this Video*/
		public var object_id:String;
		
		
		/** URL of Icon that is Related to this link*/
		public var icon:String;
		

		public function FB_StatusVideo(obj:Object)
		{
			
		}
		
		
		override public function get type():String 
		{
			return FB_Status.VIDEO;
		}
	}
}