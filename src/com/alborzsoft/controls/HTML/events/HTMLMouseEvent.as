package com.alborzsoft.controls.HTML.events
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	public class HTMLMouseEvent extends MouseEvent
	{
	//========================== EVENTS =============================
		public static const MOUSE_CLICK:String = 'onclick';
		public static const MOUSE_DOUBLE_CLICK:String = 'ondblclick';
		public static const MOUSE_DOWN:String = 'onmousedown';
		public static const MOUSE_MOVE:String = 'onmousemove';
		public static const MOUSE_OUT:String = 'onmouseout';
		public static const MOUSE_OVER:String = 'onmouseover';
		public static const MOUSE_UP:String = 'linkMouseUp';
		public static const MOUSE_WHEEL:String = 'linkMouseWheel';
		
		
		
		
		
	//========================== LINK EVENTS =============================
		public static const LINK_CLICK:String = 'linkClick';
		public static const LINK_DOUBLE_CLICK:String = 'linkDoubleClick';
		public static const LINK_MOUSE_DOWN:String = 'linkMouseDown';
		public static const LINK_MOUSE_MOVE:String = 'linkMouseMove';
		public static const LINK_MOUSE_OUT:String = 'linkMouseOut';
		public static const LINK_MOUSE_OVER:String = 'linkMouseOver';
		public static const LINK_MOUSE_UP:String = 'linkMouseUp';
		public static const LINK_MOUSE_WHEEL:String = 'linkMouseWheel';

		
		
	//========================== IMAGE EVENTS =============================
		public static const IMAGE_CLICK:String = 'imageClick';
		public static const IMAGE_DOUBLE_CLICK:String = 'imageDoubleClick';
		public static const IMAGE_MOUSE_DOWN:String = 'imageMouseDown';
		public static const IMAGE_MOUSE_MOVE:String = 'imageMouseMove';
		public static const IMAGE_MOUSE_OUT:String = 'imageMouseOut';
		public static const IMAGE_MOUSE_OVER:String = 'imageMouseOver';
		public static const IMAGE_MOUSE_UP:String = 'imageMouseUp';
		public static const IMAGE_MOUSE_WHEEL:String = 'imageMouseWheel';
		
		
		
		
	//========================== VARRIABLES =============================
		/** A tag properties of HTML content */
		public var target2:Object;
		
		
	//========================== METHODS =============================
		public function HTMLMouseEvent(type:String, target:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.target2 = target;
		}
	}
}