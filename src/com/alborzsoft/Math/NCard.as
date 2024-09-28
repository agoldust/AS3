package com.alborzsoft.Math
{
	public class NCard
	{
		public static const MAX_CHAR_IRAN:uint = 10;

		
		public static const COUNTRY_USA:uint = 1;
		public static const COUNTRY_IRAN:uint = 98;
		
		
		/** <p>validating the National ID of a Person<p/>
		 * 
		 * @param id : String - National ID of person 
		 * @param country : uint - Country Code
		 * @return Boolean - true if it's valid code
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function isValid_NID(id:String, country:uint=98):Boolean
		{
			if(country == COUNTRY_IRAN) return checkIranNationalID(id);
			
			return false;
		}
		
		/** <p>Getting valid National ID<p/>
		 * 
		 * @param 
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getValid_NID(id:String, country:uint=98):String
		{
			if(country == COUNTRY_IRAN) return getIranNationalID(id);
			
			return id;
		}
		
		
		
		private static function getIranNationalID(id:String):String
		{
			var nid:String = id;
			
			// adding 1 or 2 missed zeros at the begining
			if(id.length == 8) nid = "00" + nid;
			if(id.length == 9) nid = "0"  + nid;
			
			return nid;
		}		
		
		
		
		private static function checkIranNationalID(id:String):Boolean
		{
			var nid:String = id;
			
			// adding missed 1 or 2 beginng zeros
			if(id.length == 8) nid = "00" + nid;
			if(id.length == 9) nid = "0"  + nid;
			
			
			// multipling the 9 last char of code to position of it
			var pos:uint;
			var max_val:uint=0;
			
			for(var i:int=0; i<id.length-1; i++) 
			{
				pos = MAX_CHAR_IRAN-i;
				max_val += uint(nid.charAt(pos)) * pos;
			}
			
			//deviding to 11
			var R:uint = max_val % 11;
			var control_num:uint = uint(nid.charAt(max_val-1));
			
			// checking the code
			if(R<2  && control_num == R) return true;
			if(R>=2 && control_num == 11-R) return true;
			
			return false;
		}
	}
}