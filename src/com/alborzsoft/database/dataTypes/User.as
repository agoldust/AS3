package com.alborzsoft.database.dataTypes
{
	/**<p>User Class</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: May 22, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Lite 4, Flash 9, AIR 1.0
	 */
	public class User
	{
		public var id:int = -1;
		public var username:String;
		public var password:String;
		
		
		public function User(username:String='', password:String='')
		{
			this.username = username;
			this.password = password;
		}
	}
}