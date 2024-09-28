package com.alborzsoft.web.Gravatar.dataTypes
{
	public class Gravatar_DefaultImageTypes
	{
		public static const DEFAULT:String = 'default';
		public static const IDENTICON:String = 'identicon';
		public static const MONSTERID:String = 'monsterid';
		public static const WAVATAR:String = 'wavatar';
		
		
		public function Gravatar_DefaultImageTypes()
		{
		}
		
		
		/** <p>All Values in a Array<p/> */
		public static function get values():Array 
		{
			return [Gravatar_DefaultImageTypes.DEFAULT, Gravatar_DefaultImageTypes.IDENTICON, Gravatar_DefaultImageTypes.MONSTERID, Gravatar_DefaultImageTypes.WAVATAR];
		}
	}
}