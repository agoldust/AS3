package com.alborzsoft.web.google.types
{
	import com.adobe.utils.XMLUtil;
	import com.alborzsoft.utils.StringUtils;

	public class CardResult
	{
		public var title:String;
		public var url:String;
		public var description:String;
		public var cite:String;
		
		
		public function CardResult()
		{
		}
		
		/**Formating string data to MapListingResult
		 * 
		 * @param tag - String that is containing the <li> or <div> of google result
		 * $return MapListingResult
		 */
		public static function formatRawData(tag:String):CardResult
		{
			var cr:CardResult;
			
			if(XMLUtil.isValidXML(tag))
			{
				var xml:XML = new XML(tag);
				cr = new CardResult;
				
				cr.title		= xml..h3.a;
				cr.url			= xml..h3.a.@href.toString();
				cr.cite			= stripTags(xml..cite).replace(" ", "");
				cr.description	= stripTags(xml..span);
			}
			else {
				trace("XML is not valid for MapListingResult class");
				
				// checking Possiblities
				for(var i:int=0; i<4; i++){
					tag += '</div>';
					
					if(XMLUtil.isValidXML(tag))
						cr = formatRawData(tag);
				}
				
			}
			
			return cr;
		}
		
		
		public static function stripTags(tag:String):String
		{
			var regExp:RegExp =  /<[^<]+?>/gim;

			tag = tag.replace(regExp, "");
			tag = tag.replace("\n", "");
			
			return StringUtils.removeExtraWhitespace(tag);
		}
		
		
		
		
		
		
	}
}