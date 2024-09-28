package com.alborzsoft.controls.HTML.types
{
	import com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent;
	import com.alborzsoft.controls.HTML.events.HTMLMouseEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	
 //=============================== MOUSE EVENTS =================================
	[Event(name="imageClick",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageDoubleClick",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseDown",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseMove",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseOut",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseOver",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseUp",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	
	[Event(name="imageKeyUp",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	[Event(name="imageKeyDown",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	[Event(name="imageKeyPress",	type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]

	
 //=============================== METHODS =================================
	public class HTML_IMG extends EventDispatcher
	{
		/** IMG tag data*/
		public var tag:Object;
		
		
		
		
		public function HTML_IMG(tag:Object = null)
		{
			this.tag = tag;
			
			
			tag.click(function():void		{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_CLICK));		});
			tag.dblclick(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_DOUBLE_CLICK));	});
			tag.mousedown(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_DOWN));	});
			tag.mousemove(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_MOVE));	});
			tag.mouseout(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_OUT));	});
			tag.mouseover(function():void	{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_OVER));	});
			tag.mouseup(function():void		{ dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_UP));		});
			
			tag.keyup(function():void		{ dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.IMAGE_KEY_UP));		});
			tag.keydown(function():void		{ dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.IMAGE_KEY_DOWN));	});
			tag.keypress(function():void	{ dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.IMAGE_KEY_PRESS));	});
		}
		
		/** The URL of the image.
			<p>Possible values:</p>
			<ul>
				<li>An absolute URL - points to another web site (like src=&quot;http://www.example.com/image.gif&quot;)</li>
				<li>A relative URL - points to a file within a web site (like src=&quot;image.gif&quot;)</li>
			</ul>
		*/
		public function get src():String 
		{
			return tag[0].src;
		}
		
		
		/** <a>The alt attribute provides alternative information for an image if a user for some reason cannot view it </br>
		   (because of slow connection, an error in the src attribute, or if the user uses a screen reader).  </a>*/
		public function get alt():String 
		{
			return tag[0].alt;
		}
		
		
		public function get width():String 
		{
			return tag[0].width;
		}
		
		public function get height():String 
		{
			return tag[0].height;
		}
		
		public function get x():String 
		{
			return tag[0].x;
		}
		
		public function get y():String 
		{
			return tag[0].y;
		}
		
		
		
		/** Specifies extra information about an element */
		public function get title():String 
		{
			return tag[0].title;
		}
		
		
		
	}
}