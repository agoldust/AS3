package com.alborzsoft.web.google
{
	import com.alborzsoft.web.google.types.CardResult;
	import com.alborzsoft.web.google.types.MapListingResult;
	import com.alborzsoft.web.google.types.SERPResult;
	import com.alborzsoft.web.google.types.SearchType;
	
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	import mx.rpc.events.ResultEvent;
	
	import org.flexunit.runner.Result;
	
	
	/**When rank is Received!!*/
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	
	[Event(name="progress", type="flash.events.ProgressEvent")]

	
	public class GoogleSERP_Rank extends EventDispatcher
	{
		public var google_serp:GoogleSERP;
		
		public function GoogleSERP_Rank()
		{
			
		}
		
		/**Getting the rank of Keyword in Google SERP
		 * @param search - SearchType containing Keyword and URL
		 * @param checkHTTPS - if true, it will search HTTPS version of URLs too
		 */
		public function getRank(search:SearchType, checkHTTPS:Boolean=false):void
		{
			google_serp = new GoogleSERP(search);
			google_serp.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
			
			google_serp.addEventListener(ResultEvent.RESULT, function(e:ResultEvent):void
			{
				var result:SERPResult = findRankExtended(search, e.result as Array, checkHTTPS);
				result.url = search.url;
				result.keyword = search.keyword;
				
				dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, result)); // dispatching result
			});
		}
		
		public function pause():void
		{
			google_serp.close();
		}
		
		public function resume():void
		{
			google_serp.reloadData();
		}
		
		
		public function get loading():Boolean 
		{
			return google_serp.loading;
		}
		
		
		/**Finding the Rank of Keyword and URL in SERP
		 * 
		 * @param search - SearchType containing Keyword and URL
		 * @param results - Array of SERP
		 * @param checkHTTPS - if true, it will search HTTPS version of URLs too
		 * @return Rank - uint between 0 to 100
		 */
		public function findRank(search:SearchType, results:Array, checkHTTPS:Boolean=false):uint
		{
			for(var i:int=0; i<results.length; i++) 
			{
				// checking the existance of it
				if(results[i])
				if(search.isSameURL(results[i].url))
					return i+1;
			}
			
			return 0;
		}
		
		
		/**Extended Search for Rank of Keyword and URL in SERP with Root URL search
		 * 
		 * @param search - SearchType containing Keyword and URL
		 * @param results - Array of SERP
		 * @param checkHTTPS - if true, it will search HTTPS version of URLs too
		 * @return SERPResult - rank of main and root urls
		 */
		public function findRankExtended(search:SearchType, results:Array, checkHTTPS:Boolean=false):SERPResult
		{
			var result:SERPResult = new SERPResult();
			
			// getting rank for current link
			result.setCurrentDate();
			result.rank = findRank(search, results, checkHTTPS);
			result.root_results = new Array;
			
			
			// searching for extended results
			for(var i:int=0; i<results.length; i++) 
			{
				if(results[i] == null) continue;
				
				//escaping the founded rank
				if(result.rank == i+1) continue;
				
				
				// checking the existance of URL with Extended search
				if(results[i].hasOwnProperty("url"))
				{
					var obj:Object = results[i];
					
					if(search.hasSameRoot(obj.url))
						result.root_results.push(new SERPResult(search.keyword, i+1, obj.url, new Date, null, obj));
				}
				
			}
			
			
			return result;
		}
		
		
		
	}
}