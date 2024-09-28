package com.alborzsoft.web.google
{
	import com.alborzsoft.database.dataTypes.Rating;
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.web.google.types.YoutubeAuthor;
	import com.alborzsoft.web.google.types.YoutubeEntry;
	import com.alborzsoft.web.google.types.YoutubeResult;
	import com.alborzsoft.web.google.types.YoutubeThumbnail;
	
	import flash.debugger.enterDebugger;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.sampler.NewObjectSample;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	/**==================== EVENTS ========================*/	
	[Event(name="result",	type="mx.rpc.events.ResultEvent")]
	[Event(name="fault",	type="mx.rpc.events.FaultEvent")]
	[Event(name="ioError",	type="flash.events.IOErrorEvent")]
	
	
	
	
	public class YoutubeSearch extends EventDispatcher
	{
		/**========================= CONST & VARRIABLES ===========================*/
		// ==================== CONST ========================
		private const API_URL:String = "http://gdata.youtube.com/feeds/api/videos/";
		private const YOUTUBE_URL:String = API_URL + "videos/?vq=";
		
		
		
		/**========================= FUNCTIONS ====================================*/
		public function YoutubeSearch()
		{
		}
		
		
		// get the Data form Server
		public function search(keyword:String):void
		{
			var urlVar:URLVariables = new URLVariables;
			urlVar.vq = keyword;
			urlVar['start-index'] = 1;
			urlVar['max-results'] = 30;
			
			var urlR:URLRequest = new URLRequest(API_URL);
			urlR.data = urlVar;
			
			var loader:URLLoader = new URLLoader(urlR);
			loader.addEventListener(Event.COMPLETE, onResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
		}
		
		
		
		// searching Keyword form YouTube
		private function onResult(event:Event):void
		{
			var arrRemoves:Array = ["app:", "media:", "openSearch:", "gd:", "yt:", "<hd/>",
									" xmlns='http://www.w3.org/2005/Atom'",
									" xmlns:app='http://purl.org/atom/app#'",
									" xmlns:media='http://search.yahoo.com/mrss/'",
									" xmlns:openSearch='http://a9.com/-/spec/opensearchrss/1.0/'",
									" xmlns:gd='http://schemas.google.com/g/2005'",
									" xmlns:yt='http://gdata.youtube.com/schemas/2007'"];
			
			var xml:XML = XML(StrUtils.replaceAll2(String(event.target.data), arrRemoves));
			
			
			var result:YoutubeResult = new YoutubeResult;
			result.title = xml.title;
			result.logURL = xml.logo;
			
			result.startIndex = xml.startIndex;
			result.totalResults = xml.totalResults;
			result.itemsPerPage = xml.itemsPerPage;

			result.author = new YoutubeAuthor(xml.author.name, xml.author.uri);
			result.updated = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(xml.updated);
			
			
			
			
			// adding the Enteries of Youtube Result
			for each(var xmls:XML in xml.entry)
			{
				var entry:YoutubeEntry = new YoutubeEntry;
				
				entry.id = xmls.id;
				entry.title	= xmls.title;
				entry.description = xmls.content;
				entry.page = xmls.group.player.@url;
				entry.entryCommentCount = uint(xmls.comments.feedLink.@countHint);

				entry.author = new YoutubeAuthor(xmls.author.name, xmls.author.uri);
				entry.rating = new Rating(xmls.rating.@average, xmls.rating.@min, xmls.rating.@max, xmls.rating.@numRaters);

				entry.published = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(xmls.published);
				entry.updated	= TimeConvertor.YYYYMMDD_HHMMSS__2__Date(xmls.updated);
				
				
				// addingd Category and keywords
				for each(var category:XML in xmls.category)
				{
					if(category.@scheme == 'http://gdata.youtube.com/schemas/2007/categories.cat')
						entry.category = category.@term;
					
					else if(category.@scheme == 'http://gdata.youtube.com/schemas/2007/keywords.cat')
						entry.keywords.push(category.@term);
				}
				
				// statistics
				entry.viewCount = xmls.statistics.@viewCount;
				entry.favoriteCount = xmls.statistics.@favoriteCount;
				
				// adding Groups data
				entry.player = xmls.group.content.@url;
				entry.duration = xmls.group.duration.@seconds;
				entry.thumbnail = new YoutubeThumbnail(entry.id);

				
				
				
				// adding the Entry data to the main Result
				result.results.push(entry);
			}
			
			dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, true, result));
		}
		
		
		
	}
}