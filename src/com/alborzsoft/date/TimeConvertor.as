package com.alborzsoft.date
{
	import com.adobe.utils.DateUtil;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	[Bindable]
	public class TimeConvertor
	{
	/**================== CONSTS ==============================*/
		public static const MINUTE_IN_MILISECONDS:int = 60*1000;
		public static const HOUR_IN_MILISECONDS:int   = 60*60*1000;
		public static const DAY_IN_MILISECONDS:int    = 24*60*60*1000;
		
		
		private const secondsPerMinute:Number = 60;
		private const minutesPerHour:Number = 60;
		
		private static const DAY:Array = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
		private static const MONTHS:Array = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		private static const MONTHS_SMALL:Array = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
		public static var MMM_DD:Object;
		
		
	/**================== FUNCTIONS ==============================*/
		public function TimeConvertor()
		{
		}
		
		
		/** <p>Getting time in Formated Date Code to be easy to read<p/>
		 * 
		 * 
		 * @param date - Date
		 * @param type - code of Return Type<br>
		 * 0 will be like  <b>10 October at 03:22</b><br>
		 * 1 will be like  <b>Monday, 10 October 2011 at 03:22</b>
		 * 
		 * @return String value of formated Date
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getDateCode(date:Date, type:uint=0):String
		{
			if(date == null) return '';
			
			var res:String = "";
			
				 if(type==0) res = date.date + ' ' + MONTHS[date.month] + ' at ' + StrUtils.fixedInteger(date.hours,2) + ':' + StrUtils.fixedInteger(date.minutes,2);
			else if(type==1) res = DAY[date.day] + ', ' + date.date + ' ' + MONTHS[date.month] + ' ' + date.fullYear + ' at ' + StrUtils.fixedInteger(date.hours,2) + ':' + StrUtils.fixedInteger(date.minutes,2);
			
			return res;
		}
		
		
		/**Getting relative String based on 2 dates */
		public static function relativize( d:Date, relativeTo:Date = null ):String
		{
			relativeTo ||= new Date();
			
			var delta:Number = Math.floor( ( relativeTo.time - d.time ) / 1000 );
			
			if( delta < 0 )
			{
				return 'in the future';
			}
			if( delta < 60 )
			{
				return 'less than a minute ago';
			}
			else if( delta < 120 )
			{
				return 'about a minute ago';
			}
			else if( delta < ( 45 * 60 ) )
			{
				return Math.floor(delta / 60) + ' minutes ago';
			}
			else if( delta < ( 90 * 60 ) )
			{
				return 'about an hour ago';
			}
			else if( delta < ( 24 * 60 * 60 ) )
			{
				return 'about ' + Math.floor(delta / 3600) + ' hours ago';
			}
			else if(delta < (48*60*60) )
			{
				return '1 day ago';
			}
			else if( delta >= (48*60*60) )
			{
				return Math.floor(delta / 86400) + ' days ago';
			}
			return null;
		}
		
		
		
		
		/** <p>Getting time in Formated Time Code of a sound or video, something like <b>06:30</b><p/>
		 * 
		 * 
		 * @param seconds - Number value of seconds of FLV Video MP3 file 
		 * @return String value of formated time like <b>06:30</b>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getTimecode(seconds:Number):String
		{
			var t:Number    = Math.round(seconds);
			var min:Number  = Math.floor(t/60);
			var sec:Number  = t%60;
			var tc:String   = "";
			
			
			if(min < 10) 
				tc += "0";
			
			if(min >= 1)
			{
				if (isNaN(min) == true) tc += "0";
				else tc += min.toString();
			}
			else 
				tc += "0";
			
			tc += ":";
			
			if(sec < 10) 
			{
				tc += "0";
				
				if (isNaN(sec) == true) tc += "0";
				else tc += sec.toString();
			}
			else 
			{
				if (isNaN(sec) == true) tc += "0";
				else tc += sec.toString();
			}
			
			return tc;
		}
		
		
		
		/** <p>Get Current Date and Time in String in 2011/05/04 - 01:55:12<p/>
		 * 
		 * @return STring of Current Date
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function getCurrentDate():String 
		{
			return styleDate(new Date);
		}
		
		
		
		/** <p>Forming the Date to <b>2011/05/04 - 01:55:12</b> string form<p/>
		 * 
		 * @param date - Date
		 * @param dateSep - Strin of seperator between year and month and day
		 * @param timeSep - Strin of seperator between hour and minute and seconds
		 * @param dtSep - Strin of seperator between day and hours
		 * @param showMiliseconds - Boolean value that if set to true the return value will be have miliseconds too like 2011/05/04 - 01:55:12.<b>258</b>
		 * @param msSep - Strin of seperator between seconds and miliseconds
		 * 
		 * @return String - String of the formed Date
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9, AIR 1.5
		 */
		public static function styleDate(date:Date, dateSep:String='/', timeSep:String=':', dtSep:String=' - ', showMiliseconds:Boolean=false, msSep:String='.'):String
		{
			var arrTime:Array = new Array(date.fullYear,
										  date.month+1,
										  date.date,
										  date.hours,
										  date.minutes,
										  date.seconds,
										  date.milliseconds);
			
			var str:String = String(StrUtils.fixedInteger(arrTime[0], 2) + dateSep +
									StrUtils.fixedInteger(arrTime[1], 2) + dateSep +
									StrUtils.fixedInteger(arrTime[2], 2) + dtSep +
									StrUtils.fixedInteger(arrTime[3], 2) + timeSep +
									StrUtils.fixedInteger(arrTime[4], 2) + timeSep +
									StrUtils.fixedInteger(arrTime[5], 2));
			
			if(showMiliseconds)
				str += msSep + Math.floor(arrTime[6]/100);
			
			return str;
		}
		
		/** <p>Forming the Date to <b>July 24, 1969</b> string form<p/>
		 * 
		 * @param date - Date
		 * @param showAge - Boolean value that if set to true the return value will be have Age too like July 24, 1969 <b>(age 42)</b>
		 * 
		 * @return String - String of the formed Date
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9, AIR 1.5
		 */
		public static function styleDate2(date:Date, showAge:Boolean=false):String
		{
			var str:String = String(MONTHS[date.month] + ' ' + date.date + ', ' + date.fullYear);
			
			
			if(showAge)
			{
				var age:int = 0;
				age = DateUtil.compareDates(date, new Date);
				
				str += ' (age ' + age.toString() + ')';
			}
				
			
			return str;
		}
		
		
		
		
		
		
		/** converting Some String Like this 2009-02-25T01:37:35.000Z to Date
		 * @param dateStr - String of date
		 * @return Date
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function YYYYMMDD_HHMMSS__2__Date(dateStr:String):Date
		{
			var year:int	= int(dateStr.slice(0,4));
			var month:int	= int(dateStr.slice(5,7));
			var day:int		= int(dateStr.slice(8,10));
			var hours:int	= int(dateStr.slice(11,13));
			var minutes:int	= int(dateStr.slice(14,16));
			var seconds:int	= int(dateStr.slice(17,19));
			var miliseconds:int = int(dateStr.slice(20,23));
			
			
			var date:Date = new Date(year, --month, day, hours, minutes, seconds, miliseconds);
			
			return date;
		}
		
		
		/** converting Some String Like this 2009-02-25 01:37 to Date
		 * @param dateStr - String of date
		 * @return Date
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function YYYYMMDD_HHMM__2__Date(dateStr:String):Date
		{
			var year:int	= int(dateStr.slice(0,4));
			var month:int	= int(dateStr.slice(5,7));
			var day:int		= int(dateStr.slice(8,10));
			var hours:int	= int(dateStr.slice(11,13));
			var minutes:int	= int(dateStr.slice(14,16));
			var seconds:int	= int(dateStr.slice(17,19));
			var miliseconds:int = int(dateStr.slice(20,23));
			
			
			var date:Date = new Date(year, --month, day, hours, minutes, seconds, miliseconds);
			
			return date;
		}
		
		
		/** converting  ISO date string Like "Sun Jan 11 13:25:33 GMT+0330 2015" to Date
		 * @param dateStr - ISO date string
		 * @return Date
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function MMM_DD_HHMMSS_GMT_YYYY__2__Date(dateStr:String):Object
		{
			dateStr = dateStr.substr(4);
			
			var month:int	= getMonthIndex(dateStr.substr(0,3));
			var day:int		= int(dateStr.substr(4,2));
			var year:int	= int(dateStr.substr(7, 4));
			var hours:int	= int(dateStr.substr(12,2));
			var minutes:int	= int(dateStr.substr(15,2));
			var seconds:int	= int(dateStr.substr(18,2));

			var date:Date = new Date(year, month, day, hours, minutes, seconds);
			
			return date;
		}
		
		
		/**Getting Index of Month based on the Name of it<br/>
		 * you can use Short and Full Month name like, Jan or January
		 * 
		 * @param month - String - name of Month, like, Jan or January
		 * @return int - index of month, starting with 0
		 */
		public static function getMonthIndex(month:String):int
		{
			month = StringUtils.removeExtraWhitespace(month);
			
			// checking with Small Month
			var index:int = -1;
			for each (var str:String in MONTHS_SMALL) 
			{
				index++;
				
				if(str.toLocaleLowerCase() == month.toLocaleLowerCase())
					return index
			}
			
			
			// checking with Full Name Month
			index = -1;
			for each (var str2:String in MONTHS) 
			{
				index++;
				
				if(str2.toLocaleLowerCase() == month.toLocaleLowerCase())
					return index
			}
			
			
			return -1;
		}
		
		
		/** converting Sec to String -> HH:MM:SS
		 * @param intSecondsToConvert - Number of Seconds
		 * @return String - of time like 12:60:60
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public function sec2HHMMSS(intSecondsToConvert:Number):String
		{
			var sec:String;
			var hours:Number = hours(intSecondsToConvert);
			var minutes:Number = remainingMinutes(intSecondsToConvert);
			var seconds:Number = Math.round(remainingSecondes(intSecondsToConvert));
			
			minutes = ((minutes == 60) ? "00" : minutes).toString();
			
			(seconds < 10) ? sec = "0" + seconds  :   sec = "" + seconds;
			
			return hours + ":" + minutes + ":" + sec;
		}
		
		//
		public function hours(intSeconds:Number):Number
		{
			var minutes:Number = convertMinutes(intSeconds);
			var hours:Number = Math.floor(minutes/minutesPerHour);
			
			return hours;
		}
		
		public function convertMinutes(intSeconds:Number):Number
		{
			return Math.floor(intSeconds/secondsPerMinute);
		}
		
		public function remainingSecondes(intTotalSeconds:Number):Number
		{
			return (intTotalSeconds % secondsPerMinute);
		}
		
		public function remainingMinutes(intSeconds:Number):Number
		{
			var intTotalMinutes:Number = convertMinutes(intSeconds);
			return (intTotalMinutes%minutesPerHour);
		}
		
		
	}
}