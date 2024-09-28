package com.alborzsoft.string
{
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.utils.Validators;

	public class EmailUtil
	{
		public function EmailUtil()
		{
		}
		
		
		
		/**Cleaning The Emails from csv string<br/>
		 * this function will remove:<br/>
		 * 01.Non valid emails<br/>
		 * 02.douplicate emails<br/><br/>
		 * 
		 *@param str - CSV String
		 *@return Array - array of valid email addresses
		 */
		public static function cleanEmails(str:String):Array
		{
			var d:Date = new Date;
			
			var arr:Array = getValidEmails(str); // getting valid emails
			//trace(arr.length);
			trace(new Date().time - d.time);
			
			
			var d2:Date = new Date;
			arr = removeDouplicate(arr); // removing the douplicate emails
			//trace(arr.length);
			trace(new Date().time - d2.time);

			
			return arr;
		}
		
		
		
		
		/**Getting Valid Emails from csv string
		 *@param str - CSV String
		 *@return Array - array of valid email addresses
		 */
		public static function getValidEmails(str:String):Array
		{
			// removing the Carriage return
			str = StrUtils.replaceAll(str, '\r\n', ',');
			
			// removing the double, triple, etc. comma
			str = str.replace(/,+/g, ',');

			
			var parts:Array = str.split(',');
			var validEmails:Array = new Array;
			var email:String;

			for(var i:uint=0; i<parts.length; i++)
			{
				email = parts[i];
				
				if(email.length > 0)
				if(StringUtils.hasText(email))
				if(Validators.isValidEmail(email))
					validEmails.push(email);
			}
			
			return validEmails;
		}
		
		
		
		/**Removing the douplicate emails*/
		private static function removeDouplicate(arr:Array):Array
		{
			arr = arr.filter(function(item:String, index:int, array:Array):Boolean {
				return array.indexOf(item) == index;
			});
			
			return arr;
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}