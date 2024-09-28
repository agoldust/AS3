package com.alborzsoft.utils
{
	import spark.components.List;

	public class ContorlUtils
	{
		
		
		/** <p>Scrooling the List to the Bottom of its view port<p/>
		 * 
		 * @param lst - List (Spark)
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function List_scrollToBottom(lst:List):void
		{
			lst.scroller.viewport.verticalScrollPosition = lst.scroller.viewport.contentHeight;
		}
			
	}
}