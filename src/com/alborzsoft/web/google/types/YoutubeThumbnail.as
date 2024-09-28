package com.alborzsoft.web.google.types
{
	/**<p>Toutube Thumbnail URL Creator</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Nov 25, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9, AIR 1.0
	 */
	import com.alborzsoft.Math.Math2;

	public class YoutubeThumbnail
	{
		private var id:String;
		
		
		public function YoutubeThumbnail(videoID:String)
		{
			this.id = videoID;
		}
		
		public function get url():String 
		{
			return 'http://i.ytimg.com/vi/' + id + '/0.jpg';
		}
		
		/** <p>Array of High Quality Thumbnails of Video that is from <b>default<b> and from <b>first<b> and <b>middle<b> and <b>end<b> of Video<p/>
		 */
		public function get highQuality():Array 
		{
			var server:String = 'http://i1.ytimg.com/vi/';

			return [server + id + '/hq1.jpg',
					server + id + '/hq2.jpg',
					server + id + '/hq3.jpg',
					server + id + '/hq4.jpg'];
		}
		
		/** <p>Array of High Quality Thumbnails of Video that is from <b>default<b> and from <b>first<b> and <b>middle<b> and <b>end<b> of Video<p/>
		 */
		public function get lowQuality():Array 
		{
			var serverLow:String = 'http://i.ytimg.com/vi/';
			
			return [serverLow + id + '/1.jpg',
					serverLow + id + '/2.jpg',
					serverLow + id + '/3.jpg',
					serverLow + id + '/4.jpg'];
		}
		
	}
}