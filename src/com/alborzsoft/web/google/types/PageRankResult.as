package com.alborzsoft.web.google.types
{
	public class PageRankResult
	{
		/**Returned data from google*/
		public var data:String;
		
		/**PageRank of Page*/
		public var page_rank:int;
		
		/**URL of Page that URL is checked for*/
		public var url:String;
		
		/**Request URL to Google Server for getting Pagerank*/
		public var url_query:String;
		
		
		
		public function PageRankResult(data:String, page_rank:int, url:String, url_query:String)
		{
			this.data = data;
			this.page_rank = page_rank;
			this.url = url;
			this.url_query = url_query;
		}
		
		
		
		/**Getting Pagerank String for Storing data as seting*/
		public function get page_rank_str():String 
		{
			if(page_rank == -1) return '';
			
			return page_rank.toString();
		}
		
	}
}