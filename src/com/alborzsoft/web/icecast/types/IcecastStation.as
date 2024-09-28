package com.alborzsoft.web.icecast.types
{
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	
	/**<p>Icecast Station Class</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Apr 29, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, Flash 10
	 */
	
	
	public class IcecastStation extends Track
	{
		
	//==================== PROPERTIES ====================
		//~~~~~~~~ PUBLIC
		public var audio_info:AudioInfo;
		
		public var mount:String;
		public var server_url:String;
		public var source_ip:String;
		public var stream_start:String;		
		public var isPublic:Boolean;
		public var max_listeners:int = 0;
		public var slow_listeners:int;
		public var total_bytes_read:String;
		public var total_bytes_sent:String;
		
		public var bannerRectangleURL:String;
		public var bannerLeaderboardURL:String;
		
		public var ed:EventDispatcher = new EventDispatcher;
		
		public var isTitleChanged:Boolean = false;
		
		
		//~~~~~~~~ PRIVATE
		private var _title:String;
		
		
		
		
		
	//==================== METHODS ====================
		public function IcecastStation()
		{
		}
		
		
		
		/** <p>Title of Station<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		override public function get title():String 
		{
			return _title;
		}
		
		
		/** <p>overriding Title of Station to extract the advertising data<p/>
		 * 
		 * @param value - String of Title
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */  
		override public function set title(value:String):void 
		{
			var regx:RegExp  = new RegExp( /[-a-zA-Z0-9@:%_\+.~#?&\/\/=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?/gi);
			var regx2:RegExp = new RegExp(/\[[^<]+?\]/g);
			
			// getting banner information
			var banners:Array = value.match(regx);
			
			
			// when the new banner Arrived
			if(StringUtils.hasText(banners[0]) || StringUtils.hasText(banners[1]))
			{
				bannerLeaderboardURL = banners[0];
				bannerRectangleURL	 = banners[1];
				
				isTitleChanged = true;
			}
			
			// removing banner form Title
			value = value.replace(regx2, '');
			_title = StringUtils.removeExtraWhitespace(value);
		}
		
		
		
		
		
		
		
		
	}
}