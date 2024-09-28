package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;

	public class AudioSummary
	{
		public var acousticness:Number;
		public var analysis_url:String;
		public var audio_md5:String;
		public var danceability:Number;
		public var duration:Number;
		public var energy:Number;
		public var key:Number;
		public var liveness:Number;
		public var loudness:Number;
		public var mode:Number;
		public var speechiness:Number;
		public var tempo:Number;
		public var time_signature:Number;
		public var valence:Number;
		
		
		public function AudioSummary(data:Object=null)
		{
			Util.copyDataClass(data, this);
		}
	}
}