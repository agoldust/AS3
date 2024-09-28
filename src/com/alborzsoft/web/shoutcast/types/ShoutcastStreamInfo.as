package com.alborzsoft.web.shoutcast.types
{
	import com.alborzsoft.utils.StrUtils;
	
	import flash.utils.ByteArray;

	[Bindable]
	public class ShoutcastStreamInfo
	{
		public var status:String;
		
		public var notice1:String;
		public var notice2:String;
		
		public var name:String;
		public var genre:String;
		public var url:String;
		public var contentType:String
		public var pub:Boolean;
		public var bitrate:uint;
		
		private var temp_ba:ByteArray;
		public var isSet:Boolean;
		
		
		
		public function ShoutcastStreamInfo()
		{
			temp_ba = new ByteArray;
		}
		
		
		
		public function set data(ba:ByteArray):void 
		{
			var str:String = ba.readUTFBytes(ba.bytesAvailable);
			str = StrUtils.replaceAll2(str, ['\r','icy-notice1:','icy-notice2:','icy-name:','icy-genre:','icy-url:','content-type:','icy-pub:','icy-br:']);
			
			
			var arr:Array = str.split('\n');
			
			if(arr.length > 8)
			{
				this.status		= arr[0];
				this.notice1	= arr[1];
				this.notice2	= arr[2];
				this.name		= arr[3];
				this.genre		= arr[4];
				this.url		= arr[5];
				this.contentType= arr[6];
				this.pub		= arr[7];
				this.bitrate	= arr[8];
				
				isSet = true;
			}
		}
		
		
		
		
	}
}