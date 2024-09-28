package com.alborzsoft.web.google.types
{
	public class SERPResult extends SearchType
	{
		/**PageRank of Page*/
		public var rank:int;
		
		/**Date of Page that URL is checked on*/
		public var date:Date;
		
		/**URL of Page that URL is checked for*/
		public var root_results:Array;
		
		/**google result pbject*/
		public var data:Object;
		
		
		public function SERPResult(keyword:String="", rank:int=0, url:String='', date:Date=null, root_results:Array=null, data:Object=null)
		{
			super(keyword, url);
			
			this.rank = rank;
			this.date = date;
			this.root_results = root_results;
			this.data = data;
		}
		
		/**true if it has extended results*/
		public function get hasRootResults():Boolean 
		{
			if(root_results == null) return false;
			
			return (root_results.length > 0);
		}
		
		/**Label for messageField of ItemRenderer*/
		public function get label():String 
		{
			return "Rank = " + rank;
		}
		
		/**Setting current time as date value*/
		public function setCurrentDate():void
		{
			this.date = new Date;
		}
	}
}