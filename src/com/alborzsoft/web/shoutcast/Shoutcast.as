package com.alborzsoft.web.shoutcast
{
	/**<p>SHOUTCAST class for interacting with Shoutcast server</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Apr 25, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, Flash 10
	 */
	
	import com.alborzsoft.sound.Playlist;
	import com.alborzsoft.web.shoutcast.events.ShoutcastResultEvent;
	import com.alborzsoft.web.shoutcast.types.ShoutcastStation;
	import com.alborzsoft.web.shoutcast.types.Shoutcast_Genre;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectProxy;
	
	
	
	/**==================== EVENTS ========================*/	
	[Event(name="result", type="com.alborzsoft.web.shoutcast.events.ShoutcastResultEvent")]
	[Event(name="failed", type="com.alborzsoft.web.shoutcast.events.ShoutcastResultEvent")]
	[Event(name="no_match", type="com.alborzsoft.web.shoutcast.events.ShoutcastResultEvent")]

	
	[Bindable]
	public class Shoutcast extends EventDispatcher implements IEventDispatcher
	{
		/**========================= CONST & VARRIABLES ===========================*/
		// ==================== CONST ========================
		private var DEV_ID:String = ''; //"ak1GsUSTzGf3ObKA";
		protected const API_URL:String = "http://api.shoutcast.com/legacy/";
		
		// ==================== PRIVATE ========================
		private var genreList_url:String;
		private var genrePList_url:String;		// Primary Geners
		private var genreSList_url:String;		// Secondary Genres
		private var genreAList_url:String;		// All Geners with and without children
		private var genreSearch_url:String;
		private var stationSearch_url:String;
		private var tuneinStation_url:String;

		
		
		/** Constructor and Set the Develloper ID for getting Data form SHoutcast API. this value must be set form the begining of Application
		 * @param devID - String value of your AOL.com Developper ID  for your current Application
		 */
		public function Shoutcast(devID:String)
		{
			super();
			
			developerID = devID;
		}
		
		
		/** Set the Develloper ID for getting Data form SHoutcast API. this value must be set form the begining of Application
		 * @param devID - String value of your AOL.com Developper ID  for your current Application
		 */
		public function set developerID(devID:String):void
		{
			DEV_ID = devID;
			
			genreList_url		= API_URL + 'genrelist?k='		+ DEV_ID;
			genreSearch_url		= API_URL + 'genresearch?k='	+ DEV_ID + '&genre=';
			stationSearch_url	= API_URL + 'stationsearch?k='	+ DEV_ID + '&search=';
			
			/*
			genreSearch_url		= API_URL + 'genresearch?k='	+ DEV_ID + '&mt=audio/mpeg&genre=';
			stationSearch_url	= API_URL + 'stationsearch?k='	+ DEV_ID + '&mt=audio/mpeg&search=';
			*/
			
			tuneinStation_url	= 'http://yp.shoutcast.com/sbin/tunein-station.pls?k=' + DEV_ID + '&id=';
			
			genrePList_url		= 'http://api.shoutcast.com/genre/primary?f=json&k=' + DEV_ID;
			genreSList_url		= 'http://api.shoutcast.com/genre/secondary?f=json&k=' + DEV_ID + '&parentid=';
			genreAList_url		= 'http://api.shoutcast.com/genre/secondary?f=json&k=' + DEV_ID + '&haschildren=';
		}
		
		
		
		/** Searching a List of Channels based on Genre 
		 * @param genre - String of Genere's name
		 */
		public function getStations(genre:String):void
		{
			var service:HTTPService  = new HTTPService;
			
			service.resultFormat = 'e4x';
			service.url = genreSearch_url + genre;
			service.addEventListener(ResultEvent.RESULT, search_resultHandler);
			service.addEventListener(FaultEvent.FAULT,   faultHandler);
			
			trace(service.url);
			service.send();
		}
		
		
		/** Search Stations by Keyword
		 * @param keyword - String of Search keyword
		 */
		public function searchStation(keyword:String):void
		{
			var service:HTTPService  = new HTTPService;
			
			service.resultFormat = 'e4x';
			service.url = stationSearch_url + keyword;
			service.addEventListener(ResultEvent.RESULT, search_resultHandler);
			service.addEventListener(FaultEvent.FAULT,   faultHandler);
			
			trace(service.url);
			service.send();
		}
		
		
		
		/** request All of Genres */
		public function getGenres():void
		{
			var service:HTTPService  = new HTTPService;
			
			service.resultFormat = 'e4x';
			service.url = genreList_url;
			service.addEventListener(ResultEvent.RESULT, genre_resultHandler);
			service.addEventListener(FaultEvent.FAULT,   faultHandler);
			
			trace(service.url);
			service.send();
		}
		
		
		
		/** <p>Get All Genres genres<p/>
		 * 
		 * @param hasChildren - loading Genres data<br/>
		 * true == will load only sub Genres that has Childeren<br/>
		 * false == will load only sub Genres that hasn't Children - Old Version<br/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function getAllGenres(hasChildren:Boolean=false):void
		{
			var url:String = genreAList_url;
			
			if(hasChildren)
				url += ((hasChildren == 1) ? 'true' : 'false')
			
			var urll:URLLoader = new URLLoader(new URLRequest(url));
			urll.addEventListener(Event.COMPLETE, genre_All_resultHandler);
			urll.addEventListener(IOErrorEvent.IO_ERROR, faultHandler);
		}
		
		
		/** <p>Get Primary genres<p/>*/
		public function getPrimaryGenres():void
		{
			var urll:URLLoader = new URLLoader(new URLRequest(genrePList_url));
			urll.addEventListener(Event.COMPLETE, genre_primary_resultHandler);
		}
		
		
		
		/** <p>Get Secondary Genres<p/>
		 * 
		 * @param parentID - ID of Parent Genre to load sub Genres
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function getSecondaryGenres(parentID:int):void
		{
			var urll:URLLoader = new URLLoader(new URLRequest(genreSList_url + parentID));
			urll.addEventListener(Event.COMPLETE, genre_primary_resultHandler);
		}
		
		
		
		public function getPLS(station_id:uint):void
		{
			var loader:URLLoader = new URLLoader();
			var url:String = tuneinStation_url + station_id.toString();
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, onPLS_Data);
		}
		
		
		// when PLS file 
		private function onPLS_Data(event:Event):void
		{
			var radioStation:String = event.target.data as String;
			
			// Converting PLS Data to Actual Channel Data
			var pls:Playlist = new Playlist;
			var res:Array= pls.PLS_to_AC(radioStation).source;
			
			dispatchEvent(new ShoutcastResultEvent(ShoutcastResultEvent.RESULT, false, false, res));
		}
		
		
				
		
		// searching Keyword form google youtube
		private function genre_resultHandler(event:ResultEvent):void
		{
			var result:Array = new Array;
			
			for each(var xml:XML in event.result..genre)
			{
				result.push(xml.@name.toString());
			}
			
			broadcastEvent(ShoutcastResultEvent.RESULT, result);
		}
		
		//when Primary Genres data arrives
		protected function genre_All_resultHandler(event:Event):void
		{
			var result:Array = new Array;
			var res:Object = JSON.parse(event.target.data).response;
			
			if(res.statusCode == 200)
			{
				for each (var obj:Object in res.data.genrelist.genre) 
				{
					// adding Primary Genres
					var genre:Shoutcast_Genre = new Shoutcast_Genre(obj.id, obj.name, obj.haschildren, obj.parentid);
					
					
					// adding sub Genres
					if(genre.haschildren) {
						genre.children = new ArrayCollection

						for each (var obj2:Object in obj.genrelist.genre) 
							genre.children.addItem(new Shoutcast_Genre(obj2.id, obj2.name, obj2.haschildren, obj2.parentid));
					}
					
					result.push(genre);
				}
			}
			
			broadcastEvent(ShoutcastResultEvent.RESULT, result);
		}
		
		
		//when Primary Genres data arrives
		protected function genre_primary_resultHandler(event:Event):void
		{
			var result:Array = new Array;
			var res:Object = JSON.parse(event.target.data).response;
			
			if(res.statusCode == 200)
			{
				for each (var obj:Object in res.data.genrelist.genre) 
				{
					result.push(new Shoutcast_Genre(obj.id, obj.name, obj.haschildren, obj.parentid));
				}
			}
			
			broadcastEvent(ShoutcastResultEvent.RESULT, result);
		}
		
		
		// searching Keyword form google youtube
		public function search_resultHandler(event:ResultEvent):void
		{
			var result:Array = new Array;
			var ss:ShoutcastStation;
			
			var op:ObjectProxy;
			var Stations:ArrayCollection;
			var obj:XML = event.result as XML;
			
			
			if(obj)
			if(obj.hasOwnProperty("station"))
			{
				for each(var xml:XML in obj.station)
				{
					ss = new ShoutcastStation;
					ss.id = int(xml.@id);
					ss.lc = int(xml.@lc);
					ss.br = int(xml.@br);
					
					ss.name = xml.@name;
					ss.genre = xml.@genre;
					
					ss.mt = xml.@mt;
					ss.ct = xml.@ct;
					
					if(ss.mt == "audio/mpeg") result.push(ss);
				}

				broadcastEvent(ShoutcastResultEvent.RESULT, result);
			}
			else
			{
				broadcastEvent(ShoutcastResultEvent.NO_MAMTCH);
			}
		}
		
		// on loading failior
		public function faultHandler(event:*):void
		{
			broadcastEvent(ShoutcastResultEvent.FAILED);
		}
		
		// Dispatching the Event
		private function broadcastEvent(type:String, result:Array=null):void
		{
			dispatchEvent(new ShoutcastResultEvent(type, false, false, result));
		}
		
		
		
	}
}