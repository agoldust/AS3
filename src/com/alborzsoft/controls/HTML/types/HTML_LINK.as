package com.alborzsoft.controls.HTML.types
{
	public class HTML_LINK
	{
		/** this Type is for RSS Link tag which is <code>application/rss+xml</code> */
		public static const RSS_TYPE:String = 'application/rss+xml';
		
		/** this Type is for CSS Link tag which is <code>text/css</code> */
		public static const CSS_TYPE:String = 'text/css';
		
		/** Link tag data*/
		public var tag:Object;
		
		
		
		public function HTML_LINK(tag:Object = null)
		{
			this.tag = tag;
		}
		
		
		
		
		public function get id():String 
		{
			return tag[0].id;
		}
		
		/** Title of Link */
		public function get title():String 
		{
			return tag[0].title;
		}
		
		public function get name():String 
		{
			return tag[0].name;
		}
		
		public function get localName():String 
		{
			return tag[0].localName;
		}
		
		
		
		//============================== CONTENTS ============================
		public function get text():String 
		{
			return tag[0].text;
		}
		
		public function get textContent():String 
		{
			return tag[0].textContent;
		}
		
		public function get innerHTML():String 
		{
			return tag[0].innerHTML;
		}
		
		public function get innerText():String 
		{
			return tag[0].innerText;
		}
		
		public function get outerHTML():String 
		{
			return tag[0].outerHTML;
		}
		
		public function get outerText():String 
		{
			return tag[0].outerText;
		}
		
		
		
		
		//============================== URLS ============================
		public function get baseURI():String 
		{
			return tag[0].baseURI;
		}
		
		public function get host():String 
		{
			return tag[0].host;
		}
		
		public function get hostname():String 
		{
			return tag[0].host;
		}
		
		public function get href():String 
		{
			return tag[0].href;
		}
		
		public function get hreflang():String 
		{
			return tag[0].hreflang;
		}
		
		public function get namespaceURI():String 
		{
			return tag[0].namespaceURI;
		}
		
		public function get pathName():String 
		{
			return tag[0].pathName;
		}
		
		public function get port():uint 
		{
			return tag[0].pathName;
		}
		
		/**protocol of the Page -  HTTP: or HTTPS: , etc*/
		public function get protocol():uint 
		{
			return tag[0].protocol;
		}
		
		
		
		//==============================  ============================
		public function get isContentEditable():String 
		{
			return tag[0].isContentEditable;
		}
		
		public function get lang():String 
		{
			return tag[0].lang;
		}
		
		public function get type():String 
		{
			return tag[0].type;
		}
		
		/** Relation */
		public function get rel():String 
		{
			return tag[0].rel;
		}
		
		public function get rev():String 
		{
			return tag[0].rev;
		}
		
		public function get draggable():Boolean 
		{
			return tag[0].draggable;
		}
		
		public function get hash():String 
		{
			return tag[0].hash;
		}
		
		
		
	}
}