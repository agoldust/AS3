package com.alborzsoft.web.kimonolabs
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.Util;
	
	import mx.utils.ObjectUtil;

	public dynamic class KimonoObject
	{
		/**unique 8 character identifier for the API*/
		public var id:String;
		
		/**user defined name for the API*/
		public var name:String;
		
		/**user defined name for the API*/
		public var count:String;
		
		/**Results*/
		public var result:Object;
		
		/**target url from which the API extracts data*/
		public var targeturl:String;
		
		/**frequency with which kimono fetches new data from the target url<br/>
		 * [fifteenminutely, halfhourly, hourly, daily, weekly, monthly]*/
		public var frequency:String;
		
		/**list of urls to visit during a targeted crawl<br/>
		 * note that the instructions property is only included when you retrieve one API, not when you list all APIs*/
		public var instructions_urls:Vector.<String>;
		
		/**maximum number of pages to visit during a pagination crawl<br/>
		 * note that the instructions property is only included when you retrieve one API, not when you list all APIs*/
		public var instructions_limit:uint;
		
		/**An ISO date string for the current time kimono attempted to fetch data from the target url*/
		public var thisversionrun:Date;
		
		/**result status for the current attempted run*/
		public var thisversionstatus:String;
		
		/**An ISO date string for the last time kimono attempted to fetch data from the target url*/
		public var lastrun:Date;
		
		/**result status for the last attempted run*/
		public var lastrunstatus:String;
		
		/**An ISO date string for the last time kimono successfully fetched data from the target url*/
		public var lastsuccess:Date;
		
		/**version number*/
		public var version:Number;
		
		/**version number of this particular result set. Find out more in by reading about Historical data*/
		public var lastversion:Number;
		
		/**whether or not the most recent fetch of this data returned results different from the last time you called this API*/
		public var newdata:Boolean;
		
		/**An ISO date string for the next time kimono will attempt to fetch data from the target url*/
		public var nextrun:Date;
		
		/**whether or not the API is set to run on automatically on a schedule*/
		public var online:Boolean;
		
		/**list of urls to which the API posts successfully fetched of new data*/
		public var webhookuris:Vector.<String>;
		
		/**list of email address to which the API posts successfully fetched of new data*/
		public var alertemails:Vector.<String>;
		
		/**list of names of the collections contained in the results object when calling the API endpoint*/
		public var collectionNames:String;
		
		
		/**Kimono Object for Storing result data*/
		public function KimonoObject()
		{
		}
		
		
		/**Kimono Object for Storing result data
		 * @param json_str - String - Returned JSON data from Server
		 * @return KimonoObject
		 */
		public static function getKimonoObject(json_str:String=''):KimonoObject
		{
			var json:Object = new JSONDecoder(json_str, true).getValue();
			var kim:KimonoObject = new KimonoObject;
			
			
			if(json)
			{
				var att:Object = ObjectUtil.getClassInfo(json);
				
				for each(var qn:QName in att.properties) 
				{
					if(qn.localName == 'lastsuccess' || qn.localName == 'thisversionrun' ||
						qn.localName == 'lastrun'	 || qn.localName == 'nextrun')
					{
						kim[qn.localName] = TimeConvertor.MMM_DD_HHMMSS_GMT_YYYY__2__Date(json[qn.localName]);
					}
					else{
						kim[qn.localName] = ObjectUtil.copy(json[qn.localName]);
					}
				}
			}			
			
			return kim;
		}
		
		
	}
}
















