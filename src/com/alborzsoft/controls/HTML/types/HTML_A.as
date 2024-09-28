package com.alborzsoft.controls.HTML.types
{
	import com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent;
	import com.alborzsoft.controls.HTML.events.HTMLMouseEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	
 //=============================== MOUSE EVENTS =================================
	[Event(name="linkClick",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkDoubleClick",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseDown",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseMove",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseOut",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseOver",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseUp",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	
	[Event(name="linkKeyUp",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	[Event(name="linkKeyDown",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	[Event(name="linkKeyPress",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]

	
 //=============================== METHODS =================================--
	public class HTML_A extends EventDispatcher
	{
		/** Link tag data*/
		public var tag:Object;
		
		
		
		public function HTML_A(tag:Object = null)
		{
			this.tag = tag;
			
			tag.click(function():void		{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_CLICK));			});
			tag.dblclick(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_DOUBLE_CLICK));	});
			tag.mousedown(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_DOWN));	});
			tag.mousemove(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_UP));		});
			tag.mouseout(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_OUT));		});
			tag.mouseover(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_OVER));	});
			tag.mouseup(function():void		{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_UP));		});
			
			tag.keyup(function():void		{ dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.LINK_KEY_UP));	});
			tag.keydown(function():void		{ dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.LINK_KEY_DOWN));});
			tag.keypress(function():void	{ dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.LINK_KEY_PRESS));});
		}
		
		
		/** Location of Link */
		public function get location():String 
		{
			return tag[0].href;
		}
		
		/** Type of Page */
		public function get target():String 
		{
			return tag[0].target;
		}
		
		/** Title of Link */
		public function get title():String 
		{
			return tag[0].title;
		}
		
		
		/** Text of Link */
		public function get text():String 
		{
			if(String(tag[0].innerText).length) return tag[0].innerText;
			if(String(tag[0].outerText).length) return tag[0].outerText;
			
			return '';
		}
		
		
		/** HTML Content of Link */
		public function get html():String 
		{
			if(String(tag[0].innerText).length) return tag[0].outerHTML;
			if(String(tag[0].outerText).length) return tag[0].innerHTML;
			
			return '';
		}
		
		
		/** dispatching the Click Event on A element*/
		public function click():* 
		{
			return tag.click();
		}
		
	}
}