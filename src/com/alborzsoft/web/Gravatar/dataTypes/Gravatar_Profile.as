package com.alborzsoft.web.Gravatar.dataTypes
{
	public class Gravatar_Profile
	{
		public var id:uint;
		public var hash:String;
		public var requestHash:String;
		public var profileUrl:String;
		public var preferredUsername:String
		public var thumbnailUrl:String;
		public var displayName:String;
		public var aboutMe:String;
		public var currentLocation:String;
		
		
		
		public var name:Gravatar_Name;
		public var emails:Vector.<Gravatar_Email>;
		
		public var ims:Vector.<Gravatar_IMs>;
		public var urls:Vector.<Gravatar_URL>;
		public var accounts:Vector.<Gravatar_Account>;

		public var photos:Vector.<Gravatar_Photo>;
		public var profileBackground:Gravatar_ProfileBackground;
		public var phoneNumbers:Vector.<Gravatar_PhoneNumbers>;
		
		
		
		public function Gravatar_Profile()
		{
			name = new Gravatar_Name;
			emails = new Vector.<Gravatar_Email>;
			
			ims = new Vector.<Gravatar_IMs>;
			urls = new Vector.<Gravatar_URL>;
			accounts = new Vector.<Gravatar_Account>;
			
			photos = new Vector.<Gravatar_Photo>;
			profileBackground = new Gravatar_ProfileBackground;
			phoneNumbers = new Vector.<Gravatar_PhoneNumbers>;

		}
		
	}
}