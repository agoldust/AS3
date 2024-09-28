package com.alborzsoft.web.Gravatar.dataTypes
{
	public class Gravatar_Account
	{
		public var domain:String;
		public var userid:String;
		public var display:String;
		public var url:String;
		public var verified:Boolean;
		public var shortname:String;
		
		
		public function Gravatar_Account(userid:String='', shortname:String='', display:String='', url:String='', domain:String='', verified:Boolean=false)
		{
			this.domain = domain;
			this.userid = userid;
			this.display = display;
			this.url = url;
			this.verified = verified;
			this.shortname = userid;
		}
		
	}
}