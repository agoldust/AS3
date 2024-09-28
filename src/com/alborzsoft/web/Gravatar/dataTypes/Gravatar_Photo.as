package com.alborzsoft.web.Gravatar.dataTypes
{
	public class Gravatar_Photo
	{
		public var url:String;
		public var type:String;
		
		public function Gravatar_Photo(url:String='', type:String='')
		{
			this.url = url;
			this.type = type;
		}
	}
}