package com.alborzsoft.database.dataTypes
{
	public class Comment
	{
		/** ID of comment*/
		public var id:uint;

		/** ID of Post or news*/
		public var postID:uint;
		
		/** reply ID of another comment */
		public var replyTo:uint;
		
		/**Title of Comment*/
		public var title:String;
		
		/**Text of Comment*/
		public var description:String;
		
		
		
		public function Comment()
		{
		}
	}
}