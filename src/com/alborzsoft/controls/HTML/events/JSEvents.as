package com.alborzsoft.controls.HTML.events
{
	import flash.events.Event;
	
	public class JSEvents extends Event
	{
		public static const JS_JQUERY_ADDED:String = 'jquery_added';
		public static const JS_HILITOR_ADDED:String = 'hilitor_added';

		
		
		public function JSEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}