/**<p>Echo Nest API</p>
 * <p>Creatd By: Akbar Goldust</p>
 * <p>Last modification date: May 22, 2013</p>
 * 
 * @langversion 3.0
 * @playerversion AIR 1.5
 */
package com.alborzsoft.web.echonest
{
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.echonest.types.Artist;
	import com.alborzsoft.web.echonest.types.ArtistBiography;
	import com.alborzsoft.web.echonest.types.ArtistImage;
	import com.alborzsoft.web.echonest.types.ArtistNews;
	import com.alborzsoft.web.echonest.types.ArtistReview;
	import com.alborzsoft.web.echonest.types.ArtistSong;
	import com.alborzsoft.web.echonest.types.ArtistVideo;
	import com.alborzsoft.web.echonest.types.ListItem;
	import com.alborzsoft.web.echonest.types.Status;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.ResultEvent;
	
	
	[Event(name="complete", type="flash.events.Event")]
	
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	
	public class EchoNest extends EventDispatcher
	{
		//=========================================== STATIC CONSTS =========================================
		public static const SERVER:String = 'http://developer.echonest.com/api/v4/';
		
		public static const URL_SONG:String			= SERVER + 'song/';
		public static const URL_ARTIST:String		= SERVER + 'artist/';
		public static const URL_BIOGRAPHIES:String	= SERVER + 'biographies/';
		
		
		public static const URL_LIST_GENRES:String	= URL_ARTIST + 'list_genres';
		public static const URL_LIST_TERMS:String	= URL_ARTIST + 'list_terms';
		
		public static const URL_SONG_SEARCH:String		= URL_SONG + 'search';
		public static const URL_SONG_PROFILE:String		= URL_SONG + 'profile';
		public static const URL_SONG_IDENTIFY:String	= URL_SONG + 'identify';
		
		
		public static const URL_ARTIST_PROFILE:String		= URL_ARTIST + 'profile';
		public static const URL_ARTIST_SIMILAR:String		= URL_ARTIST + 'similar';
		public static const URL_ARTIST_SEARCH:String		= URL_ARTIST + 'search';
		public static const URL_ARTIST_IMAGES:String		= URL_ARTIST + 'images';
		public static const URL_ARTIST_VIDEO:String			= URL_ARTIST + 'video';
		public static const URL_ARTIST_BLOGS:String			= URL_ARTIST + 'blogs';
		public static const URL_ARTIST_BIO:String			= URL_ARTIST + 'biographies';
		public static const URL_ARTIST_FAMILIARITY:String	= URL_ARTIST + 'familiarity';
		public static const URL_ARTIST_HOTTTNESSS:String	= URL_ARTIST + 'hotttnesss';
		public static const URL_ARTIST_NEWS:String			= URL_ARTIST + 'news';
		public static const URL_ARTIST_REVIEWS:String		= URL_ARTIST + 'reviews';
		public static const URL_ARTIST_EXTRACT:String		= URL_ARTIST + 'extract';
		public static const URL_ARTIST_SONGS:String			= URL_ARTIST + 'songs';
		public static const URL_ARTIST_SUGGEST:String		= URL_ARTIST + 'suggest';
		public static const URL_ARTIST_TERMS:String			= URL_ARTIST + 'terms';
		public static const URL_ARTIST_TOP_HOTTT:String		= URL_ARTIST + 'top_hottt';
		public static const URL_ARTIST_TOP_TERMS:String		= URL_ARTIST + 'top_terms';
		public static const URL_ARTIST_TWITTER:String		= URL_ARTIST + 'twitter';
		public static const URL_ARTIST_URLS:String			= URL_ARTIST + 'urls';

		
		
		
		
		
		//========================================= PRIVATE VARRIABLES ======================================
		protected var api_key:String;
		
		
		
		
		
		
		public function EchoNest(api_key:String)
		{
			this.api_key = api_key;
		}
		
		
		
		
		
		
		
		//================================== LIST GENRES AND TERMS =============================================
		// @see - http://developer.echonest.com/docs/v4/artist.html#list-genres
		//=====================================================================================================
		/** <p>Get a list of the available genres for use with search and playlisting. 
		 * This method returns a list of genres suitable for use in the artist/search call when searching by description and for the creation of genre-radio playlists. 
		 * The returned list of genres is inclusive of all supported genres.<p/>
		 */
		public function getGenres():void
		{
			// Requesting the data
			var urll:URLLoader = new URLLoader(new URLRequest(URL_LIST_GENRES + '?' + getKey));
			urll.addEventListener(Event.COMPLETE, onGenres);
		}
		
		protected function onGenres(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data).response;
			this.processResult(data, 'genres', ListItem);
		}		
		
		
		
		/** <p>Get a list of the best typed descriptive terms for use with search. 
		 * This method returns a list of descriptive terms suitable for use in the artist/search call when searching by description. 
		 * The returned list of terms is not necessarily inclusive of all supported terms, but does include terms that are known to return high quality results.<p/>
		 *
		 * @param type - values are <b>style</b> or <b>mood</b>
		 */
		public function getTerms(type:String='style'):void
		{
			// Requesting the data
			var urll:URLLoader = new URLLoader(new URLRequest(URL_LIST_TERMS + '?' + getKey + '&type=' + type));
			urll.addEventListener(Event.COMPLETE, onTerms);
		}
		
		protected function onTerms(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data).response;
			this.processResult(data, 'terms', ListItem);
		}		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//================================================ ARTIST =============================================
		// @see - http://developer.echonest.com/raw_tutorials/artist_api/raw_artist_01.html
		// @todo - Getting info by ID
		//
		// @see - http://developer.echonest.com/raw_tutorials/artist_api/raw_artist_02.html
		//
		// 
		//=====================================================================================================
		/** <p>Geting Artists profile by Name pr ID<p/>
		 * 
		 * @param name - The easiest way to search for an artist is by name. put in the full text of the artist name.</br>
		 * The first thing to notice is that this query will likely return multiple results. 
		 * In the case of Radiohead, we return 5 results. The API attempts to give the best match as the first result, 
		 * but for certainty, it is recommended to perform searches using the Echo Nest ID. 
		 * In each of the result rows above, the id parameter returns the Echo Nest ID that can be used for future calls.</p>
		 * 
		 * @param id - you can get the Artist's profile by id too
		 * @param buckets - array of Aritist information that you wanted
		 * 
		 * @param results - Number of results That you wants to get</p>
		 */
		public function getArtistProfile(name:String='', id:String='', bukets:Array=null, results:Number=-1):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				var bukets_p:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				//making bukets
				for each(var str:String in bukets) 
					bukets_p += Artist.val(str);
					
				
				
				// making the Number of results 
				var num:String = val('results', results); 
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_PROFILE + '?' + getKey + param + bukets_p + num));
				urll.addEventListener(Event.COMPLETE, onArtistResult);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		/** <p>Geting Artist by Name<p/>
		 * 
		 * @param name - The easiest way to search for an artist is by name. put in the full text of the artist name.</br>
		 * The first thing to notice is that this query will likely return multiple results. 
		 * In the case of Radiohead, we return 5 results. The API attempts to give the best match as the first result, 
		 * but for certainty, it is recommended to perform searches using the Echo Nest ID. 
		 * In each of the result rows above, the id parameter returns the Echo Nest ID that can be used for future calls.</p>
		 * 
		 * @param results - Number of results That you wants to get</p>
		 */
		public function searchArtist(name:String, results:Number=-1):void
		{
			if(StringUtils.hasText(name))
			{
				// making the Number of results 
				var num:String = val('results', results); 
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_SEARCH + '?' + getKey + '&name=' + encodeURI(name) + num));
				urll.addEventListener(Event.COMPLETE, onArtistResult);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error('Artist Name is Empty!!'); // when no parameter provided
		}
		
		/** <p>Geting Artist by Style, Descryption - it will get multiple results and By id will return one reult<p/>
		 * 
		 * @param description - Description of Artist - like 80s
		 * @param style       - Style of Artist - like jazz
		 * 
		 * @param results - Number of results That you wants to get</p>
		 * @param start   - this will be used for paging - getting results from this number</p>
		 */
		public function searchArtistBySD(description:String='', style:String='', results:int=-1, start:int=0):void
		{
			if(StringUtils.hasText(style) || StringUtils.hasText(description))
			{
				// making the parameters
				style = val('style', style);
				description = val('description', description);
				
				// making the Number and boundaries of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_SEARCH + '?' + getKey + description + style + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistResult);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error('atleast on parameter needs to be not Empty!!'); // when no parameter provided
		}
		
		
		/** <p>Finding similar artists<br/>The Echo Nest provides up-to-the-minute artist similarity and recommendations from our real-time musical and cultural analysis 
		 *  of what people are saying about music, and how it sounds. You can use the artist/similar API calls to access this data in a variety of ways.</p>
		 * 
		 * @param names - Array of Artist Names - You can provide up to 5 seed artists.
		 * @param IDs   - Array of Artist ID's - You can provide up to 5 seed id's.
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function searchArtistBySimilarity(names:Array=null, IDs:Array=null, results:int=-1, start:int=0):void
		{
			if(names || IDs)
			{
				var params:String = '';
				
				// making the parameters
				if(IDs) 
					for each(var id:String in IDs) params += val('id', id);
				else
					for each(var name:String in names) params += val('name', encodeURI(name));
				
				
				
				// making the Number and boundaries of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_SIMILAR + '?' + getKey + params + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistResult);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error('atleast on parameter needs to be not Null!!'); // when no parameter provided
		}
		
		
		
		
		
		//On Artist data received
		protected function onArtistResult(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			var status:Status = new Status(data.status);
			var ret:Array;
			
			if(status.message == Status.SUCCESS)
			{
				ret = new Array;
				
				// adding artist to array
				if('artist' in data){
					ret.push(new Artist(data.artist));
				}
				else if('artists' in data)
				{
					// adding artists to array
					for each(var obj:Object in data.artists) 
						ret.push(new Artist(obj));
				}
				
						
				dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, ret));
			}
			else
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, status.message, status.code));
		}
		
		
		
		
		
		
		//======================================= IMAGES =========================================
		/** <p>Get a list of artist images.<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getImages(name:String='', id:String='', results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_IMAGES + '?' + getKey + param  + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistImages);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistImages(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'images', ArtistImage);
		}		
		
		
		
		
		
		
		//======================================= VIDEOS =========================================
		/** <p>Get a list of artist images.<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getVideos(name:String='', id:String='', results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_VIDEO + '?' + getKey + param  + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistVideos);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistVideos(event:Event):void
		{			
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'video', ArtistVideo);
		}	
		
		
		
		
		
		
		//======================================= BLOGS =========================================
		/** <p>Get a list of artist BLOGS.<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getBlogs(name:String='', id:String='', results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_BLOGS + '?' + getKey + param  + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistBlogs);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistBlogs(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'blogs', ArtistNews);
		}	
		
		
		
		
		
		//======================================= NEWS =========================================
		/** <p>Get a list of artist News<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getNews(name:String='', id:String='', results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_NEWS + '?' + getKey + param  + num + startNum + '&high_relevance=true'));
				urll.addEventListener(Event.COMPLETE, onArtistNews);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistNews(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'news', ArtistNews);
		}	
		
		
		
		//======================================= SONGS =========================================
		/** <p>Get a list of artist Songs<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getSongs(name:String='', artist_id:String='', title:String='', bukets:Array=null, results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(artist_id))
			{
				var param:String = '';
				var bukets_p:String = '';
				
				//making param
					 if(StringUtils.hasText(artist_id))	param = '&artist_id=' + artist_id;
				else if(StringUtils.hasText(name))		param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				// making title ready
				title = val('title', title);
				
				//making bukets
				for each(var str:String in bukets) 
					bukets_p += Artist.val(str);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_SONG_SEARCH + '?' + getKey + param + title + bukets_p + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistSongs);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistSongs(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'songs', ArtistSong);
		}	
		
		
		
		
		
		
		//======================================= Biograpy =========================================
		/** <p>Get a list of artist Biography<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getBiography(name:String='', id:String='', results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_BIO + '?' + getKey + param  + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistBio);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistBio(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'biographies', ArtistBiography);
		}	
		
		
		
		
		
		//======================================= Reviews =========================================
		/** <p>Get a list of artist Reviews<p/>
		 * 
		 * @param names - the artist name
		 * @param IDs   - the artist ID. An Echo Nest ID or a Rosetta ID (See Project Rosetta Stone)
		 * 
		 * @param results - Number of results That you wants to get
		 * @param start   - this will be used for paging - getting results from this number
		 */
		public function getReviews(name:String='', id:String='', results:Number=-1, start:int=0):void
		{
			if(StringUtils.hasText(name) || StringUtils.hasText(id))
			{
				var param:String = '';
				
				//making param
					 if(StringUtils.hasText(id))   param = '&id=' + id;
				else if(StringUtils.hasText(name)) param = '&name=' + encodeURI(name);
				
				
				// making the Number of results 
				var num:String = val('results', results);
				var startNum:String = val('start', start);
				
				
				// Requesting the data
				var urll:URLLoader = new URLLoader(new URLRequest(URL_ARTIST_REVIEWS + '?' + getKey + param  + num + startNum));
				urll.addEventListener(Event.COMPLETE, onArtistReviews);
				urll.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent)
			}
			else
				throw new Error("Your have to provide Artist's Name or ID"); // when no parameter provided
		}
		
		
		protected function onArtistReviews(event:Event):void
		{
			var data:Object = JSON.parse(event.target.data as String).response;
			processResult(data, 'reviews', ArtistReview);
		}	
		
		
		
		
		//======================================= UTILITIES =========================================
		/**Getting API Key Parameter*/
		public function get getKey():String 
		{
			return 'api_key=' + api_key;
		}
		
		
		/**getting Value of parameter*/
		private function val(name:String, value:*):String
		{
			if(value is int)	return (value>0)				  ? ('&' + name + '=' + value) : '';
			if(value is String) return StringUtils.hasText(value) ? ('&' + name + '=' + encodeURI(value)) : '';
			
			return '';
		}
		
		
		private function processResult(data:Object, att:String, resultItemClass:*):void
		{
			var status:Status = new Status(data.status);
			var ret:Array;
			
			if(status.message == Status.SUCCESS)
			{
				ret = new Array;
				
				// adding artists to array
				for each(var obj:Object in data[att]) 
					ret.push(new resultItemClass(obj))
				
				dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, ret));
			}
			else
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, status.message, status.code));
			
		}
		
		
		
		
		
	}
}