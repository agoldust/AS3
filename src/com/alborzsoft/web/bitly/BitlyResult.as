package com.alborzsoft.web.bitly
{
	public class BitlyResult
	{
		private const SERVERS:Array = ['bit.ly', 'bitly.com', 'j.mp'];
		
		/**the corresponding bitly aggregate identifier.*/
		public var hash:String;
		
		/** the Long URL*/
		public var longURL:String;
		
		/** Returned SHort URL from server that server will be changed dynamically*/
		public var ShortURL_dynamic:String;
		
		/**the corresponding bitly user identifier.*/
		public var userHash:String;
		
		public var shortCNAMEUrl:String;
		public var shortKeywordURL:String;
		
		
		public function BitlyResult()
		{
			
		}
		
		/** Short URL with static server (http://bit/ly)*/
		public function get shortURL():String 
		{
			return 'http://' + SERVERS[0] + '/' + userHash;
		}
		
		
		/** <p>Getting the Short URL based on Server ID<p/>
		 * 
		 * @param serverID - uint of Server <br/> it must be between <b>0-2<b/>
		 * @return String - of Short URL
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 */
		public function getShortURL(serverID:uint=0):String 
		{
			return 'http://' + SERVERS[serverID] + '/' + userHash;
		}
		
	}
}