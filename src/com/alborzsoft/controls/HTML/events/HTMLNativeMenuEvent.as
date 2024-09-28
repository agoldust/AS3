package com.alborzsoft.controls.HTML.events
{
	import flash.events.MouseEvent;

	public class HTMLNativeMenuEvent extends MouseEvent
	{
	//========================== LINK EVENTS =============================
		public static const LINK_NEW_TAB:String = 'linkNewTab';
		
		
	//========================== IMAGE EVENTS =============================
		public static const IMAGE_NEW_TAB:String = 'imageNewTab';
		
		
	//========================== VARRIABLES =============================
		/** A tag properties of HTML content */
		public var target2:Object;
		
		
		public function HTMLNativeMenuEvent(type:String, target:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.target2 = target;
		}
	}
}