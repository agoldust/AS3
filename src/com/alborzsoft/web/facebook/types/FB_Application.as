package com.alborzsoft.web.facebook.types
{
	public class FB_Application
	{
		public var id:String;
		public var name:String;
		public var canvas_name:String;
		public var namespace:String;
		
		
		public function FB_Application(id:String, name:String, canvas_name:String, namespace:String)
		{
			this.id = id;
			this.name = name;
			this.namespace = namespace;
			this.canvas_name = canvas_name;
		}
	}
}