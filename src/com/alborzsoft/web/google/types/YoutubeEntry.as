package com.alborzsoft.web.google.types
{
	import com.alborzsoft.database.dataTypes.Rating;
	import com.alborzsoft.date.TimeConvertor;

	public class YoutubeEntry
	{
		//======================= CONSTANTS ======================
		private const API_GDATA:String = 'http://gdata.youtube.com/feeds/api/videos/';
		

		//======================= VARRIABLES ======================*/
		//-------- PRIVATE
		private var _id:String;
		
		
		//-------- PUBLIC
		/** the <b>title</b> of video */
		public var title:String;
		
		/** the <b>entery page</b> of video */
		public var page:String;
		
		/** <b>flash video player</b> of youtube*/
		public var player:String;
		
		/** duration of video in seconds */
		public var duration:uint;
		
		/** description*/
		public var description:String;
		
		/** reponses*/
		public var entryResponses:Vector;
		
		/** Related Enteries*/
		public var entryRelated:YoutubeEntry;
		
		/** the URL of XML feed of this video*/
		public var entryFeed:String;
		
		/** the total comments */
		public var entryCommentCount:uint;
		
		/** the total views */
		public var viewCount:uint;
		
		/** the total favorite count*/
		public var favoriteCount:uint;
		
		/** Rating amount - that is between 0~5 */
		public var rating:Rating;
		
		/** Category */
		public var category:String;
		
		/** keywords of this video */
		public var keywords:Vector.<String>;
		
		/** High and low quality Thumbnails */
		public var thumbnail:YoutubeThumbnail;
		
		/** Author of this video*/
		public var author:YoutubeAuthor;
		
		/** Updated at*/
		public var updated:Date;
		
		/** Published at*/
		public var published:Date;

		
		
		//======================= FUNCTIONS ======================*/
		public function YoutubeEntry()
		{
			keywords = new Vector.<String>;
		}
		
		//======= ID =======
		public function set id(idString:String):void {
			_id = idString.slice(42);
		}
		public function get id():String	{
			return _id;
		}
		
		
		/** the URL of XML feed of <b>Related</b> Enteries */
		public function get entryRelatedURL():String 
		{
			return 'http://gdata.youtube.com/feeds/api/videos/' + id + '/related';
		}
		
		/** the URL of XML feed of <b>Responses</b> of this Video */
		public function get entryResponsesURL():String 
		{
			return 'http://gdata.youtube.com/feeds/api/videos/' + id + '/responses';
		}
		
		/** the URL of XML feed of <b>Comments</b> of this Video */
		public function get entryCommentsURL():String 
		{
			return 'http://gdata.youtube.com/feeds/api/videos/' + id + '/comments';
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}