package com.alborzsoft.date
{
	import com.alborzsoft.utils.StrUtils;

	[Bindable('propertyChange')]
	public final class PersianDate
	{
		//=========================== PROPERTISES ========================
		public var year:int;
		public var month:int;
		public var date:int;
		public var day:int;
		public var hours:int;
		public var minutes:int;
		public var seconds:int;
		public var milliseconds:int;
		
		
		
		//=========================== CONSTS ========================
		public static const MONTHS:Array = ['فروردین','اردیبهشت','خرداد','تیر','مرداد','شهریور','مهر','آبان','آذر','دی','بهمن','اسفند'];

		
		
		
		//=========================== METHODS ========================
		public function PersianDate(year:*=null, month:*=null, date:*=null, hours:*=null, minutes:*=null, seconds:*=null, ms:*=null)
		{
			
			// if there is no arguments, set the Current time
			if(year==null && month==null && date==null && hours==null && minutes==null && seconds==null && ms==null)
			{
				var pdate:PersianDate = PersianDate.juilan2Persian();
				
				this.year = pdate.year;
				this.month = pdate.month;
				this.date = pdate.date;
				this.day  = pdate.day;
				this.hours = pdate.hours;
				this.minutes = pdate.minutes;
				this.seconds = pdate.seconds;
				this.milliseconds = pdate.milliseconds
			}
			
			// setting the peroperties
			else {
				this.year = year;
				this.month = month;
				this.date = date;
				this.hours = hours;
				this.minutes = minutes;
				this.seconds = seconds;
				this.milliseconds = ms;
			}
		}
		
		
		
		/** <p>Name of Month in Persian languege<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function get monthName():String 
		{
			return PersianDate.MONTHS[month-1];
		}
		
		
		/** <p>Name of Day in Week in Persian languege<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function get dayName():String 
		{
			return Days.PDAYS[date-1];
		}
		
		
		/** <p>Persian Date in String - 1390/03/06 - 22:52:12.958<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function get currentDateValue():String 
		{
			var res:String = '';
			
			res += StrUtils.fixedInteger(year, 4) + '/';
			res += StrUtils.fixedInteger(month, 2) + '/';
			res += StrUtils.fixedInteger(date, 2) + ' - ';
			
			res += StrUtils.fixedInteger(hours, 2) + ':';
			res += StrUtils.fixedInteger(minutes, 2) + ':';
			res += StrUtils.fixedInteger(seconds, 2) + '.';
			res += StrUtils.fixedInteger(milliseconds, 4);
			
			
			return res;
		}
		
		/** <p>Persian Date in String - 1390/05/15<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function get currentDateValueSmall():String
		{
			return currentDateValue.substr(0, 10);
		}
		
		/** <p>Persian Date in String - 90/05/15<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function get currentDateValueSmall2():String
		{
			return currentDateValue.substr(2, 8);
		}
		
		public function set currentDateValue(str:String):void 
		{
			year  = int(str.substr(0, 4));
			month = int(str.substr(5, 2));
			date  = int(str.substr(8, 2));
			
			hours	= int(str.substr(13, 2));
			minutes	= int(str.substr(16, 2));
			seconds = int(str.substr(19, 2));
			milliseconds = int(str.substr(20, 4));
		}
		
		
		/** <p>Getting the Current Date for Using as Name of File<p/>
		 * 
		 * @return String The Return Result will be like <b>1390.06.01-13.30.1</b>
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function get currentDate4Name():String 
		{
			var name:String;
			var pd:PersianDate = new PersianDate;
			
			name = StrUtils.replaceAll(pd.currentDateValue, ':', '.');
			name = StrUtils.replaceAll(name, ' - ', '-');
			name = StrUtils.replaceAll(name, '/', '.');
			name = name.substr(0,19);
				
			return name;
		}
		
		
		
		
		
		
		
		
		
	//================================================================================================================================
	//================================================================================================================================
	//================================================== JUILAN TO PERSIAN  =======================================================
	//================================================================================================================================
	//================================================================================================================================
		
		/** <p>Converting Gergurian Date to Persian Date<p/>
		 * 
		 * @param Date - requested time to be converted <br/>if you send Null, you will get the current Time
		 * @return PersianDate - of converted Date to Persian form
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function juilan2Persian(date:Date=null):PersianDate
		{
			if(date == null) date = new Date; // creating date data if it's null
			
			var year:int  = date.fullYear;
			var month:int = date.month+1;  // +1 becuse months start with 0
			var day:int	  = date.date;
			
			
			var intY:int = 1;

			
			for(var i:int=0; i<3000; i+=4)
				if(year == i) intY = 2;
			
			
			for(var j:int = 1; j<3000; j+=4)
				if(year == j) intY = 3;
			
			
			
			if (intY == 1) {
				year -= ( (month < 3) || ((month == 3) && (day < 21)) )? 622:621;
				
				switch (month) {
					case 1:
						(day<21)? (month=10, day+=10):(month=11, day-=20);
						break;
					case 2:
						(day<20)? (month=11, day+=11):(month=12, day-=19);
						break;
					case 3:
						(day<21)? (month=12, day+=9):(month=1, day-=20);
						break;
					case 4:
						(day<21)? (month=1, day+=11):(month=2, day-=20);
						break;
					case 5:
					case 6:
						(day<22)? (month-=3, day+=10):(month-=2, day-=21);
						break;
					case 7:
					case 8:
					case 9:
						(day<23)? (month-=3, day+=9):(month-=2, day-=22);
						break;
					case 10:
						(day<23)? (month=7, day+=8):(month=8, day-=22);
						break;
					case 11:
					case 12:
						(day<22)? (month-=3, day+=9):(month-=2, day-=21);
						break;
					default:
					break;
				}
			}
			
			if (intY == 2) {
				year -= ( (month < 3) || ((month == 3) && (day < 20)) )? 622:621;
				
				switch (month) {
					case 1:
						(day<21)? (month=10, day+=10):(month=11, day-=20);
						break;
					case 2:
						(day<20)? (month=11, day+=11):(month=12, day-=19);
						break;
					case 3:
						(day<20)? (month=12, day+=10):(month=1, day-=19);
						break;
					case 4:
						(day<20)? (month=1, day+=12):(month=2, day-=19);
						break;
					case 5:
						(day<21)? (month=2, day+=11):(month=3, day-=20);
						break;
					case 6:
						(day<21)? (month=3, day+=11):(month=4, day-=20);
						break;
					case 7:
						(day<22)? (month=4, day+=10):(month=5, day-=21);
						break;
					case 8:
						(day<22)? (month=5, day+=10):(month=6, day-=21);
						break;
					case 9:
						(day<22)? (month=6, day+=10):(month=7, day-=21);
						break;
					case 10:
						(day<22)? (month=7, day+=9):(month=8, day-=21);
						break;
					case 11:
						(day<21)? (month=8, day+=10):(month=9, day-=20);
						break;
					case 12:
						(day<21)? (month=9, day+=10):(month=10, day-=20);
						break;
					default:
						break;
				}
			}
			
			if (intY == 3) {
				year -= ( (month < 3) || ((month == 3) && (day < 21)) )? 622:621;
				
				switch (month) {
					case 1:
						(day<20)? (month=10, day+=11):(month=11, day-=19);
						break;
					case 2:
						(day<19)? (month=11, day+=12):(month=12, day-=18);
						break;
					case 3:
						(day<21)? (month=12, day+=10):(month=1, day-=20);
						break;
					case 4:
						(day<21)? (month=1, day+=11):(month=2, day-=20);
						break;
					case 5:
					case 6:
						(day<22)? (month-=3, day+=10):(month-=2, day-=21);
						break;
					case 7:
					case 8:
					case 9:
						(day<23)? (month-=3, day+=9):(month-=2, day-=22);
						break;
					case 10:
						(day<23)? (month=7, day+=8):(month=8, day-=22);
						break;
					case 11:
					case 12:
						(day<22)? (month-=3, day+=9):(month-=2, day-=21);
						break;
					default:
						break;
				}
			}
			
			
			// creating date
			var persianDate:PersianDate = new PersianDate(year, month, day, date.hours, date.minutes, date.seconds, date.milliseconds);
			persianDate.day = date.day;
			
			return persianDate;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
	//================================================================================================================================
	//================================================================================================================================
	//================================================== PERSIAN TO JULIAN  =======================================================
	//================================================================================================================================
	//================================================================================================================================
		private var grgSumOfDays:Array = [[0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365],[0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366]];
		private var hshSumOfDays:Array = [[0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336, 365],[0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336, 366]];

		
		/** <p>Get Juilan date (Normal Date)<p/>
		 * 
		 * @return Date
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function get julianDate():Date
		{
			var grgYear:int = year+621;
			var grgMonth:int;
			var grgDay:int;
			
			var hshLeap:Boolean = hshIsLeap (year);
			var grgLeap:Boolean = grgIsLeap (grgYear);
			
			var hshElapsed:int = hshSumOfDays [hshLeap ? 1:0][month-1] + date;
			var grgElapsed:int;
			
			if (month > 10 || (month == 10 && hshElapsed > 286+(grgLeap ? 1:0)))
			{
				grgElapsed = hshElapsed - (286 + (grgLeap ? 1:0));
				grgLeap = grgIsLeap (++grgYear);
			}
			else
			{
				hshLeap = hshIsLeap (year-1);
				grgElapsed = hshElapsed + 79 + (hshLeap ? 1:0) - (grgIsLeap(grgYear-1) ? 1:0);
			}
			
			for (var i:int=1; i <= 12; i++)
			{
				if (grgSumOfDays [grgLeap ? 1:0][i] >= grgElapsed)
				{
					grgMonth = i;
					grgDay = grgElapsed - grgSumOfDays [grgLeap ? 1:0][i-1];
					break;
				}
			}
			
			
			// forming data for return
			var date:Date = new Date;
			date.fullYear = grgYear;
			date.month = grgMonth;
			date.date = grgDay;
			
			return date;
		}
		
		
		
		private function grgIsLeap(Year:int):Boolean
		{
			return ((Year%4) == 0 && ((Year%100) != 0 || (Year%400) == 0));
		}
		
		private function hshIsLeap(Year:int):Boolean
		{
			Year = (Year - 474) % 128;
			Year = ((Year >= 30) ? 0 : 29) + Year;
			Year = Year - Math.floor(Year/33) - 1;
			
			return ((Year % 4) == 0);
		}
		
		
		private function hshDayOfWeek(hshYear:int, hshMonth:int, hshDay:int):int
		{
			var value:int;
			value = hshYear - 1376 + hshSumOfDays[0][hshMonth-1] + hshDay - 1;
			
			for (var i:int=1380; i<hshYear; i++)
				if (hshIsLeap(i)) value++;
			
			for (i=hshYear; i<1380; i++)
				if (hshIsLeap(i)) value--;
			
			value = value%7;
			
			if (value<0) value=value+7;
			
			return (value);
		}
		
	}
}