package com.alborzsoft.web.google.events
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class FaviconEvent extends Event
	{
		public static const COMPLETE:String	= "complete";
		public static const FAILED:String	= "failed";
		
        public var response:Bitmap;	//An Array filled with Data Object returned after a succesful twitter request
        public var info:String;			//A Text Message containing information when a request fails or the status of your http request
		
		public function FaviconEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, responseArray:Bitmap=null, info:String=null)
		{
			super(type, bubbles, cancelable);
			this.response = response;
			this.info = info;
		}
		
		
		override public function toString():String
        {
        	return "[Event type=\""+type+"\"]";
        }

	}
}