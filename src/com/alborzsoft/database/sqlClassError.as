package com.alborzsoft.database
{
	/**<p>SQLight Errors</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Mar 13, 2011</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion AIR 1.5
	 */
	
	public class sqlClassError
	{
		//============ ERROR NUMBERS ==================
		public static const FILE_NOT_EXIST_ID:Number = 0;
		public static const SQL_OPENING_ERROR_ID:Number = 0;
		

		
		//======================= ERROR MESSAGES ==========================
		public static const FILE_NOT_EXIST:String = 'Database file is not exist!';
		public static const SQL_OPENING_ERROR:String = 'SQL Opening erorr!!!';
		
		
		//---- array of Errors
		public static var arr_erorrs:Array = [FILE_NOT_EXIST, SQL_OPENING_ERROR];
		
		
		
		public function sqlClassError()
		{
		}
		
		
		/** Send An Error Message to Compiler
		 * param id - int of Error
		 */
		public static function throwErrorById(id:int):void
		{
			try{
				throw Error(arr_erorrs[id]);
			}
			catch(e:Error){
				trace('Error on Throwing another Error!!');
			}
		}
	}
}