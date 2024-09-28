package com.alborzsoft.web.google.types
{
	import com.adobe.utils.XMLUtil;

	public class MapListingResult
	{
		public var title:String;
		public var url:String;
		public var address:String;
		public var phone:String;
		public var cite:String;

		
		
		public function MapListingResult()
		{
		}
		
		
		/**Formating string data to MapListingResult
		 * 
		 * @param li - String that is containing the li of google result
		 * $return MapListingResult
		 */
		public static function formatRawData(li:String):MapListingResult
		{
			var mpr:MapListingResult;
			
			if(XMLUtil.isValidXML(li))
			{
				var xml:XML = new XML(li);
				mpr = new MapListingResult;
				
				mpr.title	= xml..h3.a;
				mpr.url		= xml..h3.a.@href.toString();
				mpr.address	= xml.div.div.div[1].div[0];
				mpr.phone	= xml.div.div.div[1].div[1];
				mpr.cite	= xml..cite;
			}
			else {
				trace("XML is not valid for MapListingResult class");
			}
			
			return mpr;
		}
	}
}