package com.alborzsoft.database
{
	/**<p>This Class is For using easyer the SQLite Database in AIR</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: September 7, 2011</p>
	 * 
	 * @param databaseURL - String of actual url of Dtabase form HDD
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion AIR 1.5
	 */
	
	import com.alborzsoft.database.events.SQLErrorEvent;
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLSchemaResult;
	import flash.data.SQLStatement;
	import flash.data.SQLTableSchema;
	import flash.errors.SQLError;
	import flash.errors.SQLErrorOperation;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	
	
	
	
	[Event(name="schemaNotMatch", type="com.alborzsoft.database.events")]
	
	
	
	

	public class sqlClass extends EventDispatcher
	{
		private var sqlConn:SQLConnection;
		private var sqlStat:SQLStatement;
		private var dbFile:File;
		
		private var useCatching:Boolean;
		
		
		/** <p>Constructing the sqlClass<p/>
		 * 
		 * @param databaseURL - Url to sqlite file
		 * @param useCatching - if true, then it will catch database to localstorage and will use that after wards<br/> currently claas can't define new database to update the catched one
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function sqlClass(databaseURL:String, useCatching:Boolean=true)
		{
			this.useCatching = useCatching;
			dbURL = databaseURL;
			sqlConn = new SQLConnection();
		}
		
		
		/** <p>if class is connected to Dabase file will Return TRUE<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, AIR 1.5
		 */
		public function get connected():Boolean 
		{
			return sqlConn.connected;
		}
		
		
		/** <p>Set The URL of SQLite Database<p/>
		 * 
		 * @param url - The URL of Actual SQLite Database
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		private function set dbURL(url:String):void
		{
			var file:File = File.applicationDirectory.resolvePath(url);
			var newFile:File = File.applicationStorageDirectory.resolvePath(url);
			
			
			if(useCatching == false)
			{
				dbFile = file; // use direct link to file
			}
			else if(newFile.exists)
			{
				
				// comreing 2 database
				var isSame:Boolean = compare2DB(file, newFile);
				
				if(isSame == false)
				{
					dispatchEvent(new com.alborzsoft.database.events.SQLErrorEvent(com.alborzsoft.database.events.SQLErrorEvent.SCHEMA_NOT_MATCH));
					
					//throw Error('the Structure of your file is changed! Please Delete the old one on: ' + newFile.nativePath + '\n\n');
					
					// deleting the file
					//newFile.cancel();
					//newFile.deleteFile();
					
				}
				
				// using the new database that is placed on Storage Directory of OS
				dbFile = newFile;
			}
			else {
				if(file.exists)
				{
					file.copyTo(newFile);
					dbFile = newFile;
				}
				else{
					sqlClassError.throwErrorById(0); //The Database File Is not Exist!
				}
			}
			
			trace(dbFile.nativePath);
		}
		
		
		
		/** <p>Comparing 2 SQLite Database to each other<p/>
		 * 
		 * @param db1 - File variable of Database 1
		 * @param db2 - File variable of Database 2
		 * @return Boolean - true of the Structure of both are the same
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion AIR 1.5
		 */
		public function compare2DB(db1:File, db2:File):Boolean
		{
			var sqlSchema1:SQLSchemaResult = getSQLSchema(db1);
			var sqlSchema2:SQLSchemaResult = getSQLSchema(db2);
			
			
			//-- checking Tables Schema
			if(sqlSchema1.tables.length != sqlSchema2.tables.length)
			{
				return false;
			}
			else {
				for (var i:int=0; i<sqlSchema1.tables.length; i++)
				{
					var tableSchema1:SQLTableSchema = sqlSchema1.tables[i];
					var tableSchema2:SQLTableSchema = sqlSchema2.tables[i];
					
					if(StrUtils.isEqual(tableSchema1.sql, tableSchema2.sql) == false) return false;
				}
			}
			
			return true;
		}
		
		
		
		/** <p>Getting SQL Schema of SQLite file<p/>
		 * 
		 * @param dbFile - File of sqlite file
		 * @return SQLSchemaResult - schema of your database
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 2.0
		 */
		public function getSQLSchema(dbFile:File):SQLSchemaResult
		{
			var sqlStatement:SQLStatement;
			
			if(dbFile.exists)
			{
				sqlStatement = new SQLStatement;
				sqlStatement.sqlConnection = new SQLConnection;
				sqlStatement.sqlConnection.open(dbFile, SQLMode.READ);				
				sqlStatement.sqlConnection.loadSchema();
				
				return sqlStatement.sqlConnection.getSchemaResult();
			}
			else {
				sqlClassError.throwErrorById(0);
			}
			
			return null;
		}
		
		
		/** <p>Returning the value of id Column of Laest Record of Table<p/>
		 * 
		 * @param table - String name of Table
		 * @return int - int value of id Column <br/> if there is no record, it returns -1 value
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 2.0
		 */
		public function getLatestRowID(tableName:String):int
		{
			var sqlString:String = "SELECT * FROM " + tableName;
			var arr:Array = readSQL(sqlString);
			
			// null value - first value
			if(arr == null) return -1;
			
			return arr[arr.length-1].id;
		}
		
		
		/** <p>Getting New ID of a Table<p/>
		 * 
		 * @param table - String name of Table
		 * @return int - int value of new id
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function getNewID(tableName:String):int 
		{
			var num:int = getLatestRowID(tableName);
			
			return (num > -1) ? (num+1) : 1;
		}
		
		
		/** <p>Read data from SQL database<p/>
		 * 
		 * @param sqlStr - String value of Read SQL Statement
		 * @return Array - array of result rows
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 2.0
		 */
		public function readSQL(sqlStr:String):Array
		{
			if(openSQL())
			{
				sqlStat = new SQLStatement;
				sqlStat.sqlConnection = sqlConn;
				sqlStat.text = sqlStr;
				sqlStat.execute();
				
				disconnect();
				return sqlStat.getResult().data;
			}
			
			return null;
		}
		
		
		
		/** <p>Writing or Updating data from SQL database<p/>
		 * 
		 * @param sqlStr - String value of Write SQL Statement
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function runWriteSQL(sqlStr:String, closeDatabse:Boolean=true):void
		{
			if(openSQL())
			{
				sqlStat = new SQLStatement;
				sqlStat.sqlConnection = sqlConn;
				sqlStat.text = sqlStr;
				sqlStat.execute();
				
				if(closeDatabse) disconnect();
			}
		}
		
		
		/** <p>Updating or Writing data from SQL database<p/>
		 * 
		 * @param sqlStr - String value of Write SQL Statement
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function runUpdateSQL(sqlStr:String):void
		{
			runWriteSQL(sqlStr);
		}
		
		
		/** <p>Closing Connection of Database<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public function disconnect():void
		{
			sqlConn.close();
		}
		
		
		/** <p>Reclaim unused space and defragment the database file<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, AIR 1.5
		 */
		public function compact():void
		{
			sqlConn.compact();
		}
		
		
		
		/** Opening the SQL connection
		 */
		private function openSQL():Boolean
		{
			if(sqlConn.connected) return true;
			else {
				if(dbFile.exists) {
					sqlConn.open(dbFile, SQLMode.UPDATE); // dataBase is open now
					
					trace("SQL Openned.");
					return true;  
				}
				sqlClassError.throwErrorById(1); // SQL Opening erorr
			}
			
			return false;
		}
		
		
		
		
		
		
		//=========================== HELPER METHODS =================================
		/**Forming Data to right String format for SQL Statement
		 * 
		 * @param * - all types of data
		 * @return String
		 * */
		public static function gd(data:*):String
		{
			if(data is String)
			{
				data = StrUtils.replaceAll(data, '"', '');
				return '"' + data + '"';
			}
			
			if(data is Boolean)	return data ? '1' : '0';
			if(data is Date)	return '"' + TimeConvertor.styleDate(data, '-', ':', ' ') + '"';
			if(isNaN(data))		return '0';
			if(data is Number)	return Number(data).toString();
			if(data is int)		return int(data).toString();
			if(data == null)	return 'null';
			
			return data.toString();
		}
		
		
		
		
		
		
	}
}