package com.alborzsoft.controls.HTML.events
{
	import flash.events.Event;

	public class HTMLEvents extends Event
	{
		public static const TITLE_CHANGED:String = 'titleChanged';
		
		
		public function HTMLEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return "[Event type=\""+type+"\"]";
		}
	}
}