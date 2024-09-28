package com.alborzsoft.web.google.events
{
	import com.alborzsoft.web.google.types.PageRankResult;
	
	import flash.events.Event;
	
	public class PREvent extends Event
	{
		public static const RESULT:String = 'result';
		public static const NOT_FOUND:String = 'norank';
		
		public var result:Object;
		
		public function PREvent(type:String, result:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.result = result;
		}
	}
}