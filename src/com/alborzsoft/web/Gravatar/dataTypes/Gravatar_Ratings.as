package com.alborzsoft.web.Gravatar.dataTypes
{
	public class Gravatar_Ratings
	{
		/** suitable for display on all websites with any audience type. */
		public static const G:String = 'g';
		
		/** may contain rude gestures, provocatively dressed individuals, the lesser swear words, or mild violence.*/
		public static const PG:String = 'pg';
		
		/** may contain such things as harsh profanity, intense violence, nudity, or hard drug use.*/
		public static const R:String = 'r';
		
		/** may contain hardcore sexual imagery or extremely disturbing violence.*/
		public static const X:String = 'x';
		
		/** */
		public function Gravatar_Ratings()
		{
		}
		
		/** <p>All Values in a Array<p/> */
		public static function get values():Array 
		{
			return [Gravatar_Ratings.G, Gravatar_Ratings.PG, Gravatar_Ratings.R, Gravatar_Ratings.X];
		}
	}
}