package com.alborzsoft.web.shoutcast.events
{
	import flash.events.Event;
	
	
	public class ShoutcastResultEvent extends Event
	{
		// CONSTANTS
		public static const RESULT:String = "result";
		public static const FAILED:String = "failed";
		public static const NO_MAMTCH:String = "no_match"
		
		
		// VARRIABLES
		public var result:Array;
		
		
		//FUNCTIONS
		public function ShoutcastResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, result:Array = null)
		{
			// Call the constructor of the superclass.
			super(type, bubbles, cancelable);
			
			this.result = result;
		}
		
		// Override the inherited clone() method.
		override public function clone():Event
		{
			return new ShoutcastResultEvent(type, false, false, result);
		}
		
		override public function toString():String
		{
			return "[Event type=\""+ type +"\"]";
		}
		
	}
}