package com.alborzsoft.date
{
	/**<p>Days of Week</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: May 5, 2011</p>
	 * 
	 * @see http://en.wikipedia.org/wiki/Week-day_names
	 * @langversion 3.0
	 * @playerversion AIR 1.5, Flash 10
	 */
	[Bindable]
	public class Days
	{
		//=========================== PROPERTISES ========================
		public var monday:Boolean;
		public var tuesday:Boolean;
		public var wednesday:Boolean;
		public var thursday:Boolean;
		public var friday:Boolean;
		public var saturday:Boolean;
		public var sunday:Boolean;
		
		
		//=========================== CONSTS ========================
		/** Gergurian Days of week that will be started at Monday */
		public static const DAYS:Array	 = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
		public static const DAYS2:Array	 = ['Mo','Tu','We','Th','Fr','Sa','Su'];

		
		/** Persian Days of week that will be started at Saturday */
		public static const PDAYS:Array	 = ['دوشنبه','سه شنبه','چهارشنبه','پنجشنبه','جمعه','شنبه','یکشنبه'];
		
		/** <p>Farsi Week - week starts form شنبه<p/>*/
		public static const PDAYS2:Array	 = ['شنبه','یکشنبه','دوشنبه','سه شنبه','چهارشنبه','پنجشنبه','جمعه'];
		
		public static const HOURS_OF_DAY:Array =   ['00:00', '00:30', '01:00', '01:30', '02:00', '02:03', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30',
													'06:00', '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
													'12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30',
													'18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30'];
		
		
		//=========================== METHODS ========================
		public function Days(mon:Boolean=false, tue:Boolean=false, wed:Boolean=false, thu:Boolean=false, fri:Boolean=false, sat:Boolean=false, sun:Boolean=false)
		{
			monday = mon;
			tuesday = tue;
			wednesday = wed;
			thursday = thu;
			friday = fri;
			saturday = sat;
			sunday = sun;
		}
		
		
		
		/** <p>current true Days of Week in String Format<p/>
		 */
		public function get days():String 
		{
			var SEP:String = '.';
			var ret:String = '';
			
			if(monday)		ret += Days.DAYS2[0] + SEP;
			if(tuesday)		ret += Days.DAYS2[1] + SEP;
			if(wednesday)	ret += Days.DAYS2[2] + SEP;
			if(thursday)	ret += Days.DAYS2[3] + SEP;
			if(friday)		ret += Days.DAYS2[4] + SEP;
			if(saturday)	ret += Days.DAYS2[5] + SEP;
			if(sunday)		ret += Days.DAYS2[6] + SEP;
			
			return ret;
		}
		
		public function set days(value:String):void 
		{
			var SEP:String = '.';
			
			for each(var str:String in value.split(SEP))
			{
					 if(str == Days.DAYS2[0]) monday = true;
				else if(str == Days.DAYS2[1]) tuesday = true;
				else if(str == Days.DAYS2[2]) wednesday = true;
				else if(str == Days.DAYS2[3]) thursday = true;
				else if(str == Days.DAYS2[4]) friday = true;
				else if(str == Days.DAYS2[5]) saturday = true;
				else if(str == Days.DAYS2[6]) sunday = true;
			}
		}
		
		/** <p>current true Days of Week in String Format in persian Languege<p/>
		 */
		public function get persian_days():String 
		{
			var SEP:String = ' , ';
			var ret:String = '';
			
			// adding data to return
			if(saturday)	ret += Days.PDAYS[5] + SEP;
			if(sunday)		ret += Days.PDAYS[6] + SEP;
			if(monday)		ret += Days.PDAYS[0] + SEP;
			if(tuesday)		ret += Days.PDAYS[1] + SEP;
			if(wednesday)	ret += Days.PDAYS[2] + SEP;
			if(thursday)	ret += Days.PDAYS[3] + SEP;
			if(friday)		ret += Days.PDAYS[4] + SEP;
			
			
			// removing last SEP
			if(ret.length > 0)
				if(ret.substr(ret.length-SEP.length, SEP.length) == SEP)
					ret = ret.substr(0, ret.length-SEP.length);
			
			return ret;
		}
		
		
		
		
		
		
	}
}