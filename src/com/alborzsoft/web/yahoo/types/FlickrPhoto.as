package com.alborzsoft.web.yahoo.types
{
	/**<p>Fliker Photos container</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Nov 13, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9, AIR 1.0
	 */
	
	[Bindable]
	public class FlickrPhoto
	{
		public var id:String;
		public var owner:String;
		public var secret:String;
		public var server:String;
		public var farm:String;
		public var title:String;
		
		public var isPublic:Boolean;
		public var isFriend:Boolean;
		public var isFamily:Boolean;
		
		
		
		/**Size: <b>default URL of image</b> pixel*/
		public function get url():String 
		{
			return "http://farm" + farm + ".static.flickr.com/" + server + "/" + id + "_" + secret;
		}
		
		/**Size: <b>75 x 75</b> pixel*/
		public function get url_square():String
		{
			return  url + "_s.jpg";	//(75 x 75)
		}
		
		/**Size: <b>100 x 75</b> pixel*/
		public function get url_thumb():String
		{
			return  url + "_t.jpg"; //(100 x 75)
		}
		
		/**Size: <b>240 x 180</b> pixel*/
		public function get url_small():String
		{
			return  url + "_m.jpg"; //(240 x 180)
		}
		
		/**Size: <b>500 x 375</b> pixel*/
		public function get url_medium500():String
		{
			return  url + ".jpg"; 	//(500 x 375)
		}
		
		/**Size: <b>640 x 480</b> pixel*/
		public function get url_medium640():String
		{
			return  url + "_z.jpg";	//(640 x 480)
		}
		
		/**Size: <b>1024 x 768</b> pixel*/
		public function get url_large():String
		{
			return  url + "_b.jpg"; //(1024 x 768)
		}
		
		/**Size: <b>Original size</b>*/
		public function get url_Original():String
		{
			return  url + "_o.jpg"; //(1024 x 768)
		}
		
	}
}