package com.alborzsoft.web.google
{
	import com.alborzsoft.utils.NumberUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.google.events.PREvent;
	import com.alborzsoft.web.google.types.PageRankResult;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**Whe it gets PageRank of URL*/
	[Event(name="result", type="com.alborzsoft.web.google.events.PREvent")]
	
	/**When Can't get the PageRank of URL*/
	[Event(name="norank", type="com.alborzsoft.web.google.events.PREvent")]
	
	/**When page rank of URLs are loading*/
	[Event(name="progress ", type="flash.events.ProgressEvent")]

	
	
	public class PageRank extends EventDispatcher
	{
		private const URL_SERVER:String = "http://toolbarqueries.google.com/tbr?client=navclient-auto&ch=";
		
		private var urls:Array;
		private static var pr:PageRank;
		
		
		public function PageRank()
		{
		}
		
		public static function instanceOf():PageRank
		{
			if(pr == null)
				pr = new PageRank;
			
			return pr;
		}
		
		
		
		/**Getting PageRank of URL from Google API
		 * @param url - url of page
		 */
		public function getPageRank(url:String):void
		{
			var query:String = getPageRankURL(url);
			var urll:URLLoader = new URLLoader(new URLRequest(query));
			
			urll.addEventListener(Event.COMPLETE, function onData(event:Event):void
			{
				var page_rank:int = -1;
				var str:String = StringUtils.removeExtraWhitespace(event.target.data as String);
				var pos:int = str.search('Rank_');
				
				if(pos > -1)
					page_rank = int(str.substr(pos+9, 1));
				
				// dispatching the result
				dispatchEvent(new PREvent(PREvent.RESULT, new PageRankResult(event.target.data, page_rank, url, query)));
			});
			
			urll.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
			{
				dispatchEvent(new PREvent(PREvent.NOT_FOUND, new PageRankResult(event.target.data, -1, url, query)));
			});
		}
		
		
		/**Getting PageRank of URL from Google API
		 * @param url - Vector.<String> - url of pages
		 */
		public function getPageRanks(urls:Array):void
		{
			var result:Array;
			
			if(urls)
			if(urls.length > 0)
			{
				var i:int = 0;
				var pr:PageRank = new PageRank;
				pr.getPageRank(urls[i]);
				pr.addEventListener(PREvent.RESULT, function(e:PREvent):void 
				{
					if(result == null) 
						result = new Array;
					
					result.push(e.result); // storing result on array
					
					
					// mew request
					if(i < urls.length-1)
					{
						dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, ++i, urls.length));
						pr.getPageRank(urls[i]); // requesting page rank for Next url
					}
					else{
						dispatchEvent(new PREvent(PREvent.RESULT, result));
					}
				});
				
				pr.addEventListener(PREvent.NOT_FOUND, function(e:PREvent):void 
				{
					if(result == null) 
						result = new Array;
					
					result.push(e.result); // storing result on array
					
					// mew request
					if(i < urls.length-1)
					{
						dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, ++i, urls.length));
						pr.getPageRank(urls[i]); // requesting page rank for Next url
					}
					else{
						dispatchEvent(new PREvent(PREvent.RESULT, result));
					}
				});
				
				
			}
		}
		
		
		
		
		
		
		/**Getting URL of PageRank API for getting PageRank Data
		 * @param url - url of page
		 * @return String - generated URL to API
		 */
		public function getPageRankURL(url:String):String
		{
			return URL_SERVER + checkHash(hashURL(url)) + "&features=Rank&q=info:" + url + "&num=100&filter=0";
		}
		
		
		/**Making String to Number*/
		public function str2num(str:String, check:uint, magic:uint):uint
		{
			var Int32Unit:uint = 4294967296; // 2^32
			
			for (var i:int=0; i<str.length; i++)
			{
				check *= magic;
				
				if(check >= uint.MAX_VALUE) {
					check = (check - uint.MAX_VALUE * (int) (check / uint.MAX_VALUE));
					check = (check < - int.MAX_VALUE) ? (check + uint.MAX_VALUE) : check;
				}
				check += str.charCodeAt(i);
			}
			
			return check;
		}
		
		/**hashing the URL to String Number*/
		private function hashURL(url:String):String
		{
			var check1:uint = str2num(url, 0x1505, 0x21);
			var check2:uint = str2num(url, 0,	  0x1003F);
			
			check1 = check1 >> 2;
			check1 = ((check1 >> 4) & 0x3FFFFC0 ) | (check1 & 0x3F);
			check1 = ((check1 >> 4) & 0x3FFC00 )  | (check1 & 0x3FF);
			check1 = ((check1 >> 4) & 0x3C000 )   | (check1 & 0x3FFF);
			
			var T1:* = ((((check1 & 0x3C0) << 4) | (check1 & 0x3C)) <<2 ) | (check2 & 0xF0F );
			var T2:* = ((((check1 & 0xFFFFC000) << 4) | (check1 & 0x3C00)) << 0xA) | (check2 & 0xF0F0000 );
			
			return int(T1 | T2).toString();
		}
		
		
		/**Checking the Hash*/
		private function checkHash(hash_str:String):String
		{
			var flag:uint = 0;
			var checkByte:uint = 0;
			hash_str = uint(hash_str).toString(); // Converting hash string Number to unsigned integer
			
			
			for(var i:int=hash_str.length-1; i>=0; i--)
			{
				var re:int = int(hash_str.charAt(i)); 
				
				if(1 === (flag % 2)){
					re += re;
					re = int((re / 10) + (re % 10));
				}
				checkByte += re;
				flag++;
			}
			
			checkByte %= 10;
			
			if (0 !== checkByte) {
				checkByte = 10 - checkByte;
				if (1 === (flag % 2) ) {
					if (1 === (checkByte % 2)) {
						checkByte += 9;
					}
					checkByte >>= 1;
				}
			}
			
			return '7' + checkByte + hash_str;
		}
		
		
		
		
	}
}