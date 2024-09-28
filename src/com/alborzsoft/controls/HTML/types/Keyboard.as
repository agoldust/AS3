package com.alborzsoft.controls.HTML.types
{
	import flash.events.KeyboardEvent;

	public class Keyboard
	{
		public var altKey:Boolean;
		public var shiftKey:Boolean;
		public var ctrlKey:Boolean;
		public var controlKey:Boolean;
		public var commandKey:Boolean;
		public var keyCode:uint;
		public var keyLocation:uint;
		
		
		public function Keyboard(event:KeyboardEvent)
		{
			if(event) {
				altKey 		= event.altKey;
				shiftKey	= event.shiftKey;
				ctrlKey		= event.ctrlKey;
				controlKey	= event.controlKey;
				commandKey	= event.commandKey;
				keyCode		= event.keyCode;
				keyLocation = event.keyLocation;
			}
			else{
				altKey = shiftKey = ctrlKey = controlKey = commandKey = false;
				keyCode	= keyLocation = 0;
			}

		}
	}
}