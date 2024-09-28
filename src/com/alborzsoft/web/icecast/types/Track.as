package com.alborzsoft.web.icecast.types
{
	import com.alborzsoft.utils.StringUtils;

	/**<p>Track Calss of Icecast Server</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Apr 25, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, Flash 10
	 */
	public class Track
	{
		public var info:String;
		public var name:String;
		public var location:String;
		
		public var type:String;
		public var genre:String;
		public var currentlyPlayingTitle:String;
		public var description:String;
		
		public var bitrate:int;
		public var peakListeners:int;
		public var currentListeners:int;
		
		
		private var _title:String;
		
		
		
		public function Track()
		{
		}
		
		
		/** <p>Setter for settting the most of Properties of this class<p/>
		 * 
		 * @param Value - String Value of annotation child <p/><strong> Something like this:</strong><p/> 
		 * Stream Title: Always Hot Country<br/> Stream Description: Country Music<br/> Content Type:audio/mpeg<br/> Bitrate: 56<br/> Current Listeners: 75<br/> Peak Listeners: 133<br/> Stream Genre: Country<p/>
		 * 
		 * 
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function set annotation(str:String):void 
		{
			// Strings
			var s1:String = 'Stream Title:';
			var s2:String = 'Stream Description:';
			var s3:String = 'Content Type:';
			var s4:String = 'Bitrate:';
			var s5:String = 'Current Listeners:';
			var s6:String = 'Peak Listeners:';
			var s7:String = 'Stream Genre:';
			
			// Begin Postion of Parameters
			var bof1:int = 0;
			var bof2:int = str.search(s2);
			var bof3:int = str.search(s3);
			var bof4:int = str.search(s4);
			var bof5:int = str.search(s5);
			var bof6:int = str.search(s6);
			var bof7:int = str.search(s7);
			
			
			//setting the Values
			name		= StringUtils.removeExtraWhitespace(str.slice(bof1+s1.length, bof2));
			description = StringUtils.removeExtraWhitespace(str.slice(bof2+s2.length, bof3));
			type		= StringUtils.removeExtraWhitespace(str.slice(bof3+s3.length, bof4));
			
			bitrate			 = int(StringUtils.removeExtraWhitespace(str.slice(bof4+s4.length, bof5)));
			currentListeners = int(StringUtils.removeExtraWhitespace(str.slice(bof5+s5.length, bof6)));
			peakListeners	 = int(StringUtils.removeExtraWhitespace(str.slice(bof6+s6.length, bof7)));
			
			genre		= StringUtils.removeExtraWhitespace(str.slice(bof7+s7.length));
		}
		
		
		/** <p>Returns Current Singer<p/>
		 * 
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function get singer():String 
		{
			var arr:Array = title.split(' - ');
			
			return arr[0];
		}
		
		
		/** <p>Returns Current Title of Song<p/>
		 * 
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function get currentTitle():String 
		{
			var arr:Array = title.split(' - ');
			
			return arr[1];
		}
		
		
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
				
		
	}
}