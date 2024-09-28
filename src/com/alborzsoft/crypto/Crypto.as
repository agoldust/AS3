package com.alborzsoft.crypto
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;

	public class Crypto
	{
		/**Encyption Mode*/
		protected static const TYPE:String = "simple-des-ecb";
		
		
		/** <p>Encrypting the String With a Key<p/>
		 * 
		 * @param txt - String the needs to be encoded
		 * @param key - key that will be used in encryption
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function encrypt(txt:String = '', key:String=''):String
		{
			var data:ByteArray = Hex.toArray(Hex.fromString(txt));
			
			var pad:IPad = new PKCS5;
			var mode:ICipher = com.hurlant.crypto.Crypto.getCipher(TYPE, Hex.toArray(key), pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);
			return Base64.encodeByteArray(data);
		}
		
		
		/** <p>Decrypting the String With a Key<p/>
		 * 
		 * @param txt - String the needs to be encoded
		 * @param key - key that used in encryption
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function decrypt(txt:String = '', key:String=''):String
		{
			var data:ByteArray = Base64.decodeToByteArray(txt);
			var pad:IPad = new PKCS5;
			var mode:ICipher = com.hurlant.crypto.Crypto.getCipher(TYPE, Hex.toArray(key), pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.decrypt(data);
			return Hex.toString(Hex.fromArray(data));
		}
		
	}
}