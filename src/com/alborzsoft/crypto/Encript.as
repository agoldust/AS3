package com.alborzsoft.crypto
{	
	import com.adobe.crypto.SHA1;
	import com.adobe.crypto.SHA224;
	import com.adobe.crypto.SHA256;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	public dynamic class Encript
	{
		
		/** Encripting the String with SHUP1
		 * @param str - String
		 * @return String - Encripted String
		 */
		public static function encryptString(str:String):String
		{
			var strResult:String = '';
			
			if(str != null)
			{
				for(var i:int=0; i<str.length; i++)
				{
					strResult += String.fromCharCode(Number(str.charCodeAt(i)*((i+2))));
				}
			}
			
			return strResult;
		}
		
		/** Decripting the String with SHUP1
		 * @param str - String
		 * @return String - Decripted String
		 */
		public static function decryptString(str:String):String
		{
			var strTemp:String = '';
			
			if(str != null)
			{
				for(var i:int=0; i<str.length; i++)
				{
					strTemp += String.fromCharCode(str.charCodeAt(i)/(((i)+2)));
				}
			}
			
			return strTemp;
		}
		
		
		
		
		/** Encripting the Base64 String
		 * @param str - String
		 * @return String - Encripted String
		 */
		public static function encryptBase64(str:String):String
		{
			var enc:Base64Encoder = new Base64Encoder;
			enc.encodeUTFBytes(str);
			return enc.flush();
		}
		
		/** Decripting the Base64 String
		 * @param str - String
		 * @return String - Decripted String
		 */
		public static function decryptBase64(str:String):String
		{
			var dec:Base64Decoder = new Base64Decoder;
			dec.decode(str);
			return dec.flush().toString();
		}
		
		
		
		
		
		
		
		
		/** <p>Encoding the String to be competible with SQL Database throw AIR<p/>
		 *  <p>removing COMMA and DOUBL COMMA and inserting the HEX value of that charachters<p/>
		 * 
		 * @param sqlString - String of SQL String
		 * @return String - Encoded SQL String
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function encodeSqlCompetible(sqlString:String):String
		{
			sqlString = StrUtils.replaceAll(sqlString, "'", "0x2C");
			sqlString = StrUtils.replaceAll(sqlString, '"', "0xE2");
			
			return sqlString;
		}
		
		/** <p>Decoding the Encoded String to use on App<p/>
		 * 
		 * @param String - Encoded SQL String
		 * @return sqlString - String of SQL String
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function decodeSqlCompetible(sqlString:String):String
		{
			sqlString = StrUtils.replaceAll(sqlString, "0x2C", "'");
			sqlString = StrUtils.replaceAll(sqlString, "0xE2", '"');
			
			return sqlString;
		}
		
		
		
		/** Encripting the String with SHUP1 & SHA1 & SHA224 & SHA256 and cutting information
		 * @param str - String
		 * @return String - Encripted and lossed information String
		 */
		public static function encryptAndCutString(str:String, type:uint=0):String
		{
			str = str.toUpperCase();
			
			var enc:String = Encript.encryptString(str); // my custom encryption CLASS
			enc = SHA1.hash(enc);	// SHA1 encryption CLASS
			enc = SHA256.hash(enc);	// SHA256 encryption CLASS
			
			if(type == 0) enc = enc.charAt(1) + enc.charAt(7) + enc.charAt(13) + enc.charAt(17) + enc.charAt(27) + enc.charAt(37) + enc.charAt(43) + enc.charAt(57) + enc.charAt(63); // removing some texts
			if(type == 1) enc = enc.charAt(3) + enc.charAt(12) + enc.charAt(44) + enc.charAt(60) + enc.charAt(22); // removing some texts
			
			enc = enc.toLocaleUpperCase(); // making UpperCase
			
			return enc;
		}
		
		
	}
}









