package com.alborzsoft.web.wiki
{
	/**<p>[[UN FINISHED!!]]</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Nov 18, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9, AIR 1.0
	 */
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.wiki.types.WikiMediaData;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.ResultEvent;
	
	
	
	[Event(name="error", type="flash.events.ErrorEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	
	
	
	public class WikiMedia extends EventDispatcher
	{
	//=========================== CONSTS ==============================
		private const SITE_URL:String = 'http://en.wikipedia.org';
		private const API_URL:String = SITE_URL + '/wiki/Special:Export/';
		private const FILE_URL:String = SITE_URL + '/wiki/File:';
		
		
		private const RegEx_INFO:RegExp = /<table class="infobox .*>.*<\/tr><\/table><p>/g;
		private const RegEx_SECT:RegExp =  /<tr/;
		
		private const extentions:Array = ['(singer)', '(entertainer)'];
		
		private var wikiArtist:WikiMediaData
		private var isImageSet:Boolean = false;
		
		
		
		
		
		public function WikiMedia(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		/** <p>Loading the Information of Singer<p/>
		 * 
		 * @param name - Name of Artist
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9, AIR 1.5
		 */
		public function search(name:String):void
		{
			if(StringUtils.hasText(name))
			{
				name = StrUtils.replaceAll(name, ' ', '_'); // replacing the white spaces with under line
				
				var loader:URLLoader = new URLLoader(new URLRequest(API_URL + name));
				loader.addEventListener(Event.COMPLETE, onLoaded);
				loader.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
				
				trace(API_URL + name);
			}
			else {
				trace('Wikimedia.as -> You are searhing an Empty Keyword!!');
			}
		}
		
		private function onLoaded(event:Event):void
		{
			if(event.target.data == null) return; //if there is no data
				
				
			var str:String = event.target.data as String;
			  
			str = StrUtils.replaceAll2(str,['xmlns="http://www.mediawiki.org/xml/export-0.6/"',
											'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"',
											
											'xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.7/',
											'xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.6/ http://www.mediawiki.org/xml/export-0.6.xsd"',
											'xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.8/ http://www.mediawiki.org/xml/export-0.8.xsd"',

											'xmlns="http://www.w3.org/XML/1998/namespace"',
											'xmlns="http://www.mediawiki.org/xml/export-0.7/"',
											'xmlns="http://www.mediawiki.org/xml/export-0.8/"',

											'http://www.mediawiki.org/xml/export-0.7.xsd"']);
			
			
			var mainXML:XMLList = XML(str).page.revision;
			
			
			
			// if the page is redirected
			if(mainXML.toString().length)
			if(String(mainXML[0].text).search('#REDIRECT') > -1 || String(mainXML[0].text).search('#redirect') > -1) 
			{
				str = mainXML[0].text;
				str = StrUtils.replaceAll2(str,['#REDIRECT', '#redirect'], '');
				str = StringUtils.removeExtraWhitespace(str);
				str = str.slice(2, str.search('\]\]'));
				search(str);
			}
			
			// if that is correct page
			else
			{
				var wikiArtist:WikiMediaData = new WikiMediaData;
				wikiArtist.id = mainXML.id; // id of page
				wikiArtist.timestamp = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(mainXML.timestamp); // time of page that is created
				wikiArtist.revisionText = mainXML.text;
				
				
				// dispatching error when there is no Artist Data
				if(!wikiArtist.id || (!wikiArtist.name && !wikiArtist.genre))
				{
					dispatchEvent(new ErrorEvent('error', false, false, 'no result'));
					return;
				}
				
				
				
				// getting the Image link
				if(wikiArtist.image)
				{
					var loader:URLLoader = new URLLoader(new URLRequest(FILE_URL + wikiArtist.image));
					loader.addEventListener(Event.COMPLETE, function(event:Event):void
					{
						var str:String = event.target.data as String;
						var bof:int = str.search('id="file"><a href="');
						var eof:int = str.search('"><img alt="File:');
						wikiArtist.image = decodeURIComponent('http:' + str.slice(bof+19, eof));
						
						dispatchEvent(new ResultEvent('result', false, true, wikiArtist));
					});
				}
				else {
					dispatchEvent(new ResultEvent('result', false, true, wikiArtist));
				}
				
			}
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}