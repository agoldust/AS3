package com.alborzsoft.web.Gravatar
{
	import com.adobe.crypto.MD5;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_Account;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_DefaultImageTypes;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_Email;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_IMs;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_PhoneNumbers;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_Photo;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_Profile;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_Ratings;
	import com.alborzsoft.web.Gravatar.dataTypes.Gravatar_URL;
	
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.profiler.profile;

	
	
	
	
	//========================= EVENTS =======================================
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	
	
	
	
	/**<p>GRAvatar Class</p>
	 * <p><b>A Globally Recognized Avatar</b>
	 * Your Gravatar is an image that follows you from site to site appearing beside your name when you 
	 * do things like comment or post on a blog. Avatars help identify your posts on blogs and web forums,
	 * so why not on any site?</p>
	 * <a>http://en.gravatar.com/</a>
	 * 
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: May 23, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Lite 4, Flash 9, AIR 1.0
	 */
	public class Gravatar extends EventDispatcher
	{
		public static const API_URL:String = "http://en.gravatar.com/";
		public static const API_URL_Secure:String = "https://secure.gravatar.com/";
		
		
		private var _url:String;
		private var _email:String;
		private var _size:Number;			// default size of 80 pixels
		private var _rating:String;			// default rating of G
		private var _defaultImage:String;	// default to the blue 'G'
		private var _profile:Gravatar_Profile;	// user's loaded profile
		
		
		
		public function Gravatar(email:String, size:int=80, rating:String=Gravatar_Ratings.G, defaultImage:String=Gravatar_DefaultImageTypes.DEFAULT, useSecure:Boolean=false)
		{
			this.email = email;
			this.size = size;
			this.rating = rating;
			_defaultImage = defaultImage;
			this._url = (useSecure) ? API_URL_Secure : API_URL;
			
			// loading users information
			load();
		}
		
		
		
		
		//================================ SETTERS =================================
		/** <p>Email of User, if the email is invalid, a default image will be returned<p/> */
		public function set email(value:String):void
		{
			_email = value;
		}
		
		/** <p>size of image, must be between 1 and 512<p/> */
		public function set size(value:Number):void
		{
			if( value >= 1 && value < 512)  _size = value;
			else							_size = 80;
		}
		
		
		/** <p>Default Format of Image, must be a valide value of GRAvatar_DefaultImageTypes Class<p/> */
		public function set defaultFormat(value:String):void
		{
			if( Gravatar_DefaultImageTypes.values.indexOf(value.toLowerCase()) != -1) _defaultImage = value;
		}
		
		
		/** <p>Rating of Image, must be a valide value of GRAvatar_Ratings Class<p/> */
		public function set rating(value:String):void
		{
			if( Gravatar_Ratings.values.indexOf(value.toLowerCase()) != -1) _rating = value;
		}
		
		
		
		
		
		
		//===================================== GETTERS =======================================
		/** <b>Getting location of Avatar image<b/> */
		public function get avatarURL():String
		{
			var url:String = _url + "avatar/" + MD5.hash(_email).toString() + "?" +
									"size=" + _size +
									"&amp;rating=" + _rating +
									"&amp;d=" + _defaultImage;
			return url;
		}
		
		
		/** <b>Getting location of XML Profile Data<b/> */
		public function get xmlProfileURL():String
		{
			return _url + MD5.hash(_email).toString() + '.xml';
		}
		
		
		/** <b>Getting location of JSON Profile Data<b/> */
		public function get jsonProfileURL():String
		{
			return _url + MD5.hash(_email).toString() + '.json?callback=alert';
		}
		
		/** <b>Getting location of VCF/vCard Profile Data<b/> */
		public function get vcfProfileURL():String
		{
			return _url + MD5.hash(_email).toString() + '.vcf';
		}
		
		
		/** <b>Getting location of PHP Profile Data<b/> */
		public function get phpProfileURL():String
		{
			return _url + MD5.hash(_email).toString() + '.php';
		}
		
		
		/** <b>Getting loaded profile of user<b/> */
		public function get profile():Gravatar_Profile 
		{
			return _profile;
		}
		
		
		
		
		
		//===================================== METHODS =========================================
		/** <p>Loading Users Information<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function load():void
		{
			var urlReq:URLRequest = new URLRequest(xmlProfileURL);			
			var loader:URLLoader = new URLLoader(urlReq);
			
			loader.addEventListener(Event.COMPLETE, profileLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			dispatchEvent(new IOErrorEvent('ioError', false, false, 'User not found'));
		}
		
		private function profileLoaded(event:Event):void
		{
			var xm:XML = XML(event.target.data);
			
			
			if(xm.hasOwnProperty('error'))
			{
				dispatchEvent(new ErrorEvent('error', false, false, 'User not found'));
				return;
			}
				
			
			
			
			// when data existe
			var xml:Object = xm.entry;
			var profile:Gravatar_Profile = new Gravatar_Profile;
			
			
			// adding information of user
			profile.id = xml.id;
			profile.hash = xml.hash;
			profile.requestHash = xml.requestHash;
			profile.thumbnailUrl = xml.thumbnailUrl;
			profile.preferredUsername = xml.preferredUsername;
			profile.currentLocation = xml.currentLocation;
			profile.aboutMe = xml.aboutMe;
			
			profile.displayName = xml.displayName;
			profile.name.givenName = xml.name.givenName;
			profile.name.familyName = xml.name.familyName;
			profile.name.formatted = xml.name.formatted;
			
			profile.profileUrl = xml.profileUrl;
			profile.profileBackground.url = xml.profileBackground.url;
			profile.profileBackground.color = xml.profileBackground.color;
			profile.profileBackground.repeat = xml.profileBackground.repeat;
			profile.profileBackground.position = xml.profileBackground.position;
			
			

			
			// adding Photos of User
			for each(var xml1:XML in xml.photos)
			{
				profile.photos.push(new Gravatar_Photo(xml1.value, xml1.type));
			}
			
			// Adding Instatnt Massengers of User
			for each(var xml2:XML in xml.ims)
			{
				profile.ims.push(new Gravatar_IMs(xml2.value, xml2.type));
			}
			
			// Adding Accounts of User
			for each(var xml3:XML in xml.accounts)
			{
				profile.accounts.push(new Gravatar_Account(xml3.userid, xml3.shortname, xml3.display, xml3.url, xml3.domain, Boolean(xml3.verified)));
			}
			
			// Adding URL's of User
			for each(var xml4:XML in xml.urls)
			{
				profile.urls.push(new Gravatar_URL(xml4.title, xml4.value));
			}
			
			
			// adding Photos of User
			for each(var xml5:XML in xml.phoneNumbers)
			{
				profile.phoneNumbers.push(new Gravatar_PhoneNumbers(xml5.value, xml5.type));
			}
			
			
			// adding Emails of User
			for each(var xml6:XML in xml.emails)
			{
				profile.emails.push(new Gravatar_Email(xml6.value, xml5.primary));
			}
			
			
			_profile = profile;
			
			// dispatching event
			dispatchEvent(new Event('complete'));
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
}