package com.alborzsoft.web.geo.types
{
	public class LocationData
	{
		public var ip:String;
		public var city:String;
		public var country_name:String;
		public var country_code:String;
		
		private var _rawData:String;
		
		
		private static const SERVER_FLAG:String = 'http://api.hostip.info/images/flags/';
		
		
		
		
		public function LocationData(ip:String='', city:String='', country_name:String='', country_code:String='')
		{
			this.ip = ip;
			this.city = city;
			this.country_name = country_name;
			this.country_code = country_code;
		}
		
		
		/**URL address to the Flag of Country*/
		public function get flagURL():String 
		{
			return SERVER_FLAG + country_code.toLocaleLowerCase() + '.gif';
		}
		
		
		/** <p>Setting Data Withd JSON String data<p/>*/
		public function set rawData(json:String):void
		{
			_rawData = json;
			var obj:Object = JSON.parse(json);
			
			this.ip = obj.ip;
			this.city = obj.city;
			this.country_name = obj.country_name;
			this.country_code = obj.country_code;
		}
		public function get rawData():String 
		{
			return _rawData;
		}
	}
}