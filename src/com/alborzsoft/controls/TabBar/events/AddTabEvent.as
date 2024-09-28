package com.alborzsoft.controls.TabBar.events {
	import flash.events.Event;
	
	public class AddTabEvent extends Event {
		
		public static const ADD_NEW_TAB:String = "addTab";

	

		public function AddTabEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
		}

		

		override public function clone():Event {
			return new AddTabEvent(type,bubbles,cancelable);
		}
	}
}