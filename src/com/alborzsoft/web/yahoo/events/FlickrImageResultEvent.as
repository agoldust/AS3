package com.alborzsoft.web.yahoo.events
{
	import flash.events.Event;
	
	
	
	public class FlickrImageResultEvent extends Event
	{
		// An Array filled with Data Object returned after a succesful twitter request */
		public var page:int;
		public var pages:int;
		public var total:int;
		public var result:Array;
		
		// CONSTANTS
		public static const RESULT:String = "result";
		public static const FAILED:String = "failed";
		
		public function FlickrImageResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, result:Array = null, page:int=0, pages:int=0, total:int=0)
		{
			// Call the constructor of the superclass.
			super(type, bubbles, cancelable);
			
			this.result = result;
			this.page = page;
			this.pages = pages;
			this.total = total;
		}
		
		// Override the inherited clone() method.
		override public function clone():Event
		{
			return new FlickrImageResultEvent(type, false, false, result, page, pages, total);
		}
		
		override public function toString():String
		{
			return "[Event type=\""+ type +"\"]";
		}
		
		
		
	}
}