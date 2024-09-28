package com.alborzsoft.web.shoutcast.types
{
	[Bindable]
	public class ShoutcastStation
	{
	//============================ PUBLIC VARRIABLES ============================
		/**ID of Station*/
		public var id:int;
		
		/**Bitrate of Station*/
		public var br:int;
		
		/**Listener Count*/
		public var lc:int;
		
		/**Media Ttype*/
		public var mt:String;
		
		/**Current Title*/
		public var ct:String;
		
		/**Genre of Statio*/
		public var genre:String;
		
		
	//============================ PRIVATE VARRIABLES ============================
		private var _name:String;	// Station's Name

		
		
	//============================ METHODS ============================
		public function ShoutcastStation()
		{
		}
		
		
		/** Station's Name
		 * @param name - Name of Station form shoutcast server */
		public function set name(name:String):void
		{
			_name = name.replace(" - a SHOUTcast.com member station", '');	
		}
		
		/** Station's Name
		 * @return String - it will filter the shoutcast extra texts and return the name of Station	 */
		public function get name():String
		{
			return _name;
		}
		
		
	}
}