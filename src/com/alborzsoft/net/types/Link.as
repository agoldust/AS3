package com.alborzsoft.net.types
{
	/**<p>Link Class</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Dec 6, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10, AIR 1.5
	 */
	
	[Bindable]
	public class Link
	{
		
		/** <p><p/>
		 * 
		 * @param href - location of link
		 * @return title - Title of link
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function Link(href:String='', title:String='')
		{
			this.href = href;
			this.title = title;
		}
		
		
		/**
		 *	Constant for the "alternate" value of the rel property.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */			
		public static const REL_ALTERNATE:String = "alternate";
		
		/**
		 *	Constant for the "related" value of the rel property.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */			
		public static const REL_RELATED:String = "related";
		
		/**
		 *	Constant for the "self" value of the rel property.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */			
		public static const REL_SELF:String = "self";
		

		/**
		 *	A String that specifies the link's advisory media type.
		 *
		 *	This is a hint about the type of the representation that is expected
		 *	to be returned when the value of the href attribute is dereferenced.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */	
		public var type:String;
		
		/**
		 *	Describes the language of the resource pointed to by the href 
		 *	attribute.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */	
		public var hreflang:String;
		
		/**
		 *	An URI that identifies a categorization scheme.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */	
		public var href:String;
		
		/**
		 *	The IRI that the link represents.
		 * 
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 10
		 *	@tiptext
		 */	
		public var title:String;
	}
}