package com.alborzsoft.web.facebook.types
{
	public class FB_Comment
	{
		public var id:String;
		public var message:String;
		public var from:FB_Person;
		public var created_time:Date;
		
		public function FB_Comment(id:String, message:String, from:FB_Person, created_time:Date)
		{
			this.id = id;
			this.from = from;
			this.message = message;
			this.created_time = created_time;
			
		}
	}
}