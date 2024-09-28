package com.alborzsoft.utils
{
	/**
	 * 	Validator class by Akbar Goldust, Jan 3 2011
	 */
	
	public class Validators
	{
		
		/**======================== CONSTANTS ===========================*/
		private static const EMAIL_REGEX:RegExp = /^[0-9a-zA-Z][-._a-zA-Z0-9]*@([0-9a-zA-Z][-._0-9a-zA-Z]*\.)+[a-zA-Z]{2,4}$/;
		
		
		
		/**======================== FUNCTIONS ===========================*/
		public function Validators()
		{
		}
		
		
		/**
		 *	will Check the Email adderrss to be be valid
		 *
		 *	@param emial - The string that the suffic will be checked.
		 *	@returns Boolean - it will be TRUE if it is a Valid email address
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function isValidEmail(email:String):Boolean
		{
			return (email.search(EMAIL_REGEX) != -1);
		}
		
		
		/**
		 *	will Check the A List of Emails adderrss to be be valid
		 *
		 *	@param emialList - The string that the emails will be checked.
		 *  @param seperator - The String that the emails will be pererated with.
		 *	@returns Boolean - it will be TRUE if it is a Valid email address.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		// Validate a List of Emails
		public static function isValidEmailList(emailList:String, separator:String = ","):Boolean
		{
			var addresses:Array = emailList.split(separator);
			
			for each (var email:String in addresses)
			{
				if (!isValidEmail(email.replace(/\s/, ""))) return false;
			}
			return true;
		}
		
	}
}