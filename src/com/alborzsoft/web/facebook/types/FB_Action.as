package com.alborzsoft.web.facebook.types
{
	public class FB_Action
	{
		/** Name Of Action */
		public var name:String;
		
		/** Link of action */
		public var link:String;
		
		
		/** <p>Facebook Action - Storing Action data<p/>
		 * 
		 * @param name - String that is <b>Name</b> Of Action
		 * @return link - String that is <b>Link</b> of action
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function FB_Action(name:String, link:String)
		{
			this.name = name;
			this.link = link;
		}
	}
}