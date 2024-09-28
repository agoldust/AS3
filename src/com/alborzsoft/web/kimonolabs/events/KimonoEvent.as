package com.alborzsoft.web.kimonolabs.events
{
	import com.alborzsoft.web.kimonolabs.KimonoObject;
	
	import flash.events.Event;
	
	public class KimonoEvent extends Event
	{
		public static const RESULT:String = 'result';
		
		/**Loaded data from kimono server*/
		public var data:KimonoObject;
		
		public function KimonoEvent(type:String, data:KimonoObject=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
	}
}