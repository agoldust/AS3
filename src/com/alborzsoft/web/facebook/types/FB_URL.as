package com.alborzsoft.web.facebook.types
{
	public class FB_URL
	{
		/**https://graph.facebook.com/*/
		public static const URL:String		= "https://graph.facebook.com";
		
		public static const ME:String = "/me/";		
		
		public static const URL_HOME:String			= ME + "home/";

		public static const URL_FEED:String			= ME + "feed/";
		public static const URL_POSTS:String		= ME + "posts/";
		
		public static const URL_TAGGED:String		= ME + "tagged/";
		public static const URL_LINKS:String		= ME + "links/";
		public static const URL_NOTES:String		= ME + "notes/";
		public static const URL_PHOTOS:String		= ME + "photos/";
		public static const URL_EVENTS:String		= ME + "events/";
		public static const URL_VIDEOS:String		= ME + "videos/";
		public static const URL_OFFERSS:String		= ME + "offers/";
		public static const URL_MILESTONES:String	= ME + "milestones/";
		public static const URL_QUESTIONS:String	= ME + "questions/";
		public static const URL_FRIENDS:String		= ME + "friends/";
		public static const URL_ALBUMS:String		= ME + "albums/";
		public static const URL_STATUS:String		= ME + "statuses/";


		
		
		public function FB_URL()
		{
		}
	}
}