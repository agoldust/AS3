package com.alborzsoft.controls.HTML.events
{
	import flash.events.KeyboardEvent;
	
	public class HTMLKeyboardEvent extends KeyboardEvent
	{
		
		//========================== LINK EVENTS =============================
		public static const LINK_KEY_DOWN:String = 'linkKeyDown';
		public static const LINK_KEY_UP:String = 'linkKeyUp';
		public static const LINK_KEY_PRESS:String = 'linkKeyPress';
		
		
		//========================== IMAGE EVENTS =============================
		public static const IMAGE_KEY_DOWN:String = 'imageKeyDown';
		public static const IMAGE_KEY_UP:String = 'imageKeyUp';
		public static const IMAGE_KEY_PRESS:String = 'imageKeyPress';
		
		
		public var target2:Object;
		
		
		public function HTMLKeyboardEvent(type:String, target:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.target2 = target;
		}
	}
}