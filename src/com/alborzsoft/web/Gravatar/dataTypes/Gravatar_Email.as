package com.alborzsoft.web.Gravatar.dataTypes
{
	public class Gravatar_Email
	{
		public var value:String;
		public var primary:Boolean;
		
		public function Gravatar_Email(value:String='', primary:Boolean=false)
		{
			this.value = value;
			this.primary = primary;
		}
	}
}