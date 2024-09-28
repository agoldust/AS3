package com.alborzsoft.web.microsoft.events
{
	import flash.events.Event;
	
	
	public class BingResultEvent extends Event
	{
		// An Array filled with Data Object returned after a succesful twitter request */
		public var total:int;
		public var offset:int;
		public var result:Array;
		
		// CONSTANTS
		public static const RESULT:String = "result";
		public static const FAILED:String = "failed";
		
		
		public function BingResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, result:Array = null, total:int=0, offset:int=0)
		{
			super(type, bubbles, cancelable);
			
			this.result = result;
			this.total = total;
			this.offset = offset;
		}
		
		
		
		// Override the inherited clone() method.
		override public function clone():Event
		{
			return new BingResultEvent(type, false, false, result, total, offset);
		}
		
		override public function toString():String
		{
			return "[Event type=\""+ type +"\"]";
		}
		
	}
}