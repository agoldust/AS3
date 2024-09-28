package com.alborzsoft.web.yahoo
{
	/**<p>Searching Images from Flikr.com</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Nov 13, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9, AIR 1.0
	 */
	import com.alborzsoft.utils.TypeConvertion;
	import com.alborzsoft.web.yahoo.events.FlickrImageResultEvent;
	import com.alborzsoft.web.yahoo.types.FlickrPhoto;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	
	/**==================== EVENTS ========================*/	
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	[Event(name="fault",  type="mx.rpc.events.FaultEvent")]
	
	
	
	public class FlickrSearch extends EventDispatcher
	{
		/**========================= CONST & VARRIABLES ===========================*/
		// ==================== CONST ========================
		private const API_URL:String = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=";
		
		
		// ==================== PUBLC VAR ========================
		/**current page number of result*/
		public var page:int;
		
		/**total Pages of result*/
		public var pages:int;
		
		/**total result*/
		public var total:int;
		
		/**defins Maximum number of Results*/
		public var resultPerPage:int;

		
		// ==================== PRIVATE ========================
		private var API_KEY:String; 				// the Developper API Key is for Searching images Project
		
		
		
		
		
		/**========================= FUNCTIONS ====================================*/
		public function FlickrSearch(apiKey:String, resultPerPage:int=30)
		{
			super();
			
			this.API_KEY = apiKey;
			this.resultPerPage = resultPerPage;
		}
		
		
		
		
		// get the Data form Server
		public function search(keyword:String):void
		{
			var service:HTTPService  = new HTTPService;
			
			service.resultFormat = 'e4x';
			service.url = API_URL + API_KEY + "&text=" + keyword + "&per_page=" + resultPerPage;;
			service.addEventListener(ResultEvent.RESULT, search_resultHandler);
			service.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void{dispatchEvent(event);});
			
			service.send();
			
			// clearing the page details
			page = pages = total = 0;
		}
		
		// searching Keyword form google youtube
		private function search_resultHandler(event:ResultEvent):void
		{
			var result:Array = new Array;

			
			for each(var xml:XML in event.result..photo)
			{
				var fp:FlickrPhoto = new FlickrPhoto;
				
				fp.id = xml.@id;
				fp.owner = xml.@owner;
				fp.secret = xml.@secret;
				fp.server = xml.@server;
				fp.farm = xml.@farm;
				fp.title = xml.@title;
				
				fp.isPublic = TypeConvertion.string2boolean(xml.@ispublic);
				fp.isFriend = TypeConvertion.string2boolean(xml.@isfriend);
				fp.isFamily = TypeConvertion.string2boolean(xml.@isfamily);

				result.push(fp);
			}
			
			
			//making the return value
			var res:Object = new Object;
			var obj:Object = event.result.photos;
			
			res.images = result
			res.page   = int(obj.@page);  //current page number of result
			res.pages  = int(obj.@pages); //total Pages of result
			res.total  = int(obj.@total); //total result			
			
			// dispatching the event
			dispatchEvent(new ResultEvent('result', false, true, res));
		}
		
		
	}
}