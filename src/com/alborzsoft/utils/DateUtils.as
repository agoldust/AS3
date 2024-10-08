package com.alborzsoft.utils
{
	public class DateUtils {
		
		public static const AM_DESIGNATOR:String = "am";
		public static const PM_DESIGNATOR:String = "pm";
		
		public static const DAY_NAMES:Array = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
		public static const DAY_NAMES_ABBR:Array = ["Sun","Mon","Tues","Wed","Thu","Fri","Sat"];
		
		public static const DAYS_IN_MONTH:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		
		public static const MILLISECONDS_IN_DAY:Number = 24*60*60*1000;
		public static const MILLISECONDS_IN_HOUR:Number = 60*60*1000;
		public static const MILLISECONDS_IN_MINUTE:Number = 60*1000;
		
		public static const MONTH_NAMES:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
		public static const MONTH_NAMES_ABBR:Array = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
		
		protected static const DATE_MASK_PATTERN:RegExp = /hh|h|HH|H|mm|m|ss|s|yyyy|yy|dddd|ddd|dd|d|MMMM|MMM|MM|M|tt|t/g;
		
		
		
		public static function addDays(p_date:Date, p_days:Number):Date {
			var d:Date = clone(p_date);
			d.setDate(d.date+p_days)
			return d;//addHours(p_date, p_days*24);
		}
		
		public static function addHours(p_date:Date, p_hours:Number):Date {
			var d:Date = clone(p_date);
			d.setHours(d.hours + p_hours);
			return d;//addMinutes(p_date, p_hours*60);
		}
		
		public static function addMinutes(p_date:Date, p_mins:Number):Date {
			var d:Date = clone(p_date);
			d.setMinutes(d.minutes + p_mins);
			return d;//addSeconds(p_date, p_mins*60);
		}
		
		public static function addMonths(p_date:Date, p_months:int):Date {
			var d:Date = clone(p_date);
			var dt:Number = p_date.getDate();
			d.setMonth(p_date.month + p_months);
			if (dt > d.date) { d = addDays(d, -p_date.date); }
			return d;
		}
		
		public static function addSeconds(p_date:Date, p_secs:int):Date {
			return new Date(p_date.time + (p_secs * 1000));
		}
		
		public static function addWeeks(p_date:Date, p_weeks:int):Date {
			return addDays(p_date, p_weeks*7);
		}
		
		public static function addYears(p_date:Date, p_years:int):Date {
			return addMonths(p_date, p_years*12);
		}
		
		public static function clone(p_date:Date):Date {
			return new Date(p_date.getTime());
		}
		
		public static function getAMPM(p_date:Date):String {
			return (p_date.hours > 11) ? PM_DESIGNATOR : AM_DESIGNATOR;
		}
		
		public static function getDayName(p_date:Date, p_abbr:Boolean = false):String {
			return (p_abbr) ? DAY_NAMES_ABBR[p_date.day] : DAY_NAMES[p_date.day];
		}
		
		public static function getDaysInMonth(p_date:Date):Number {
			var dayCount:Number = DAYS_IN_MONTH[p_date.month];
			if (p_date.month == 1 && isLeapYear(p_date)) { dayCount++; }
			return dayCount;
		}
		
		public static function getDaysInYear(p_date:Date):Number {
			return isLeapYear(p_date) ? 365 : 366;
		}
		
		public static function getDaySpan(p_startDate:Date, p_endDate:Date):Number {			
			return getJulianDay(p_endDate) - getJulianDay(p_startDate);
		}
		
		public static function getEndOfDay(p_date:Date, p_advMidnight:Boolean=false):Date {
			var eDay:Date = getStartOfDay(p_date);
			eDay.milliseconds = MILLISECONDS_IN_DAY;
			if (!p_advMidnight) { eDay.milliseconds--; }
			return eDay;
		}
		
		public static function getEndOfMonth(p_date:Date, p_advMidnight:Boolean=false):Date {
			var eDate:Date = new Date(p_date.fullYear, p_date.month, getDaysInMonth(p_date)-1);
			eDate.milliseconds = MILLISECONDS_IN_DAY;
			if (!p_advMidnight) { eDate.milliseconds--; }
			return eDate;
		}
		
		public static function getEndOfWeek(p_date:Date, p_advMidnight:Boolean=false):Date {
			var eDate:Date = getStartOfWeek(p_date);
			eDate.date += 7;
			if (!p_advMidnight) { eDate.milliseconds--; }
			return eDate;
		}
		
		public static function getJulianDay(p_date:Date):Number {
			var y:int = p_date.fullYear;
			var m:int = p_date.month + 1;
			var d:int = p_date.date; 
			if ( m < 3 ) {
				m += 12;
				y--;
			}			
			return Math.floor( 365.25*( y + 4716 ) ) + Math.floor( 30.6001*( m + 1 ) ) + d + 2 - Math.floor( y/100 ) + Math.floor( Math.floor( y/100 ) / 4 ) - 1524;
		}
		
		public static function getDayIndex(p_date:Date):Number {
			var firstDayOfYear:Date = new Date(p_date.time);
			firstDayOfYear.setMonth(0);
			firstDayOfYear.setDate(0);
			return getDaySpan(firstDayOfYear, p_date);
		}
		
		public static function getRelativeDate(p_date:Date):String {
			
			if (p_date == null) { return 'Never'; }
			
			var now:Date = new Date();
			var days:Number = DateUtils.getDaySpan(p_date, now);	
			var difMonths:Number = now.month - p_date.month;
			
			difMonths += (now.fullYear - p_date.fullYear) * 12;	
			if (p_date > now) { return "Today"; }	
			if (p_date.fullYear < now.fullYear && difMonths > 6) {
				if (p_date.fullYear == now.fullYear-1) { return "Last year"; }
				var years:Number = (now.fullYear - p_date.fullYear);
				return years + " year" + (years==1?"":"s") + " ago";
			}
			if (difMonths > 2) { return difMonths + " months ago"; }
			var difDays:Number = DateUtils.getDayIndex(now) - DateUtils.getDayIndex(p_date);
			if (difDays > 13 || difDays == 7) { 
				var weeks:Number = difDays / 7 >> 0;
				return weeks + " week" + (weeks==1?"":"s") + " ago";
			}
			if (difDays > 7 && difDays < 13) { return "Last Week"; }
			if (days > 1) { return days + " days ago"; }
			if (days == 1) { return "Yesterday"; }
			var difSeconds:Number = (now.time - p_date.time) / 1000 >> 0;
			if (difSeconds > 60*59) {
				var hours:Number = difSeconds / 60 / 60 >> 0;
				return hours + " hour" + (hours==1?"":"s") + " ago";
			}
			var minutes:Number = difSeconds / 60 >> 0;
			if (minutes < 4 && minutes > 1) { return "a few minutes ago"; }
			else if (minutes < 1) { return 'a moment ago'; }
			return minutes + " minute" + (minutes==1?"":"s") + " ago";
		}
		
		public static function getIntersectingDates(p_dates:Array, p_start:Date, p_end:Date):Array {
			var st:Number = p_start.time;
			var et:Number = p_end.time;
			
			var res:Array = [];
			
			var l:uint = p_dates.length;
			for (var i:uint=0; i<l; i++) {
				var dt:Number = p_dates[i].time;
				if (dt > et || dt < st) { continue; }
				res.push(p_dates[i]);
			}
			return res;
		}
		
		public static function getMonthName(p_date:Date, p_abbr:Boolean = false):String {
			return (p_abbr) ? MONTH_NAMES_ABBR[p_date.month] : MONTH_NAMES[p_date.month];
		}
		
		
		/**Getting Offset of 2 Date in Millisecond
		 * 
		 * @param start Date
		 * @param end Date
		 * 
		 * @return int - milliseconds
		 */
		public static function getOffset(startDate:Date, endDate:Date=null):Number
		{
			if(startDate == null)
				return 0;
			
			if(endDate == null) 
				endDate = new Date;
			
			return endDate.time - startDate.time;
		}
		
		
		public static function getOffsetOfMonth(p_date:Date):Number {
			return getStartOfMonth(p_date).day;
		}
		
		public static function getStartOfDay(p_date:Date):Date {
			return new Date(p_date.fullYear, p_date.month, p_date.date);
		}
		
		public static function getStartOfMonth(p_date:Date):Date {
			return new Date(p_date.fullYear, p_date.month, 1);
		}
		
		public static function getStartOfWeek(p_date:Date):Date {			
			return new Date(p_date.fullYear, p_date.month, p_date.date-p_date.day);
		}
		
		public static function getWeekSpan(p_from:Date, p_to:Date):Number {
			var swDays:Number = getJulianDay( getStartOfWeek(p_from) );
			var ewDays:Number = getJulianDay( getStartOfWeek(p_to) );
			
			var difDays:Number = ewDays - swDays;
			
			return 1 + Math.ceil(difDays/7)
			
		}
		
		public static function getUTC(p_date:Date):Number {
			return Date.UTC(p_date.fullYear, p_date.month, p_date.date, p_date.hours, p_date.minutes, p_date.seconds, p_date.milliseconds);
		}
		
		public static function getDateFromUTC(p_utc:Number):Date {
			var d:Date = new Date();
			d.setTime(p_utc + (d.timezoneOffset * MILLISECONDS_IN_MINUTE));
			return d;
		}
		
		public static function getUTCDate(p_date:Date):Date {
			return new Date(p_date.fullYearUTC, p_date.monthUTC, p_date.dateUTC, p_date.hoursUTC, p_date.minutesUTC, p_date.millisecondsUTC);
		}
		
		public static function hasTime(p_date:Date):Boolean {
			return p_date.milliseconds == p_date.seconds == p_date.minutes == p_date.hours == 0;
		}
		
		public static function isLeapYear(p_date:Date):Boolean {
			//var yr:uint = p_date.fullYear;
			//return (yr%4 == 0 && yr%100 != 0) || yr%400 == 0;
			return (p_date.fullYear & 0x3) == 0;
		}
		
		public static function isWeekDay(p_date:Date):Boolean {
			var d:uint = p_date.day;
			return d != 0 && d != 6;
		}
		
		public static function isWeekEnd(p_date:Date):Boolean {
			var d:uint = p_date.day;
			return d == 0 || d == 6;
		}
		
		public static function timeSpan(p_startDate:Date, p_endDate:Date, p_interval:Number, p_format:String="h:mm tt"):Array {
			var o:Array = [];
			
			var incDate:Date = new Date(p_startDate.getTime());
			while (incDate <= p_endDate) {
				o.push(toString(incDate, p_format));
				incDate = addMinutes(incDate, p_interval);
			}
			
			return o;
		}		
		
		public static function sameDay(p_d1:Date, p_d2:Date):Boolean {
			return (p_d1.fullYear == p_d2.fullYear) && (p_d1.month == p_d2.month) && (p_d1.date == p_d2.date);
		}
		
		public static function toDays(p_date:Date):Number {
			var dayCount:Number = 0;
			for(var y:Number=p_date.fullYear-1; y>=1970; y--) { dayCount += (y & 0x3 == 0) ? 366 : 355; }
			for(var m:Number=p_date.month-1; m>=0; m--) {
				dayCount += DAYS_IN_MONTH[m];
				if(m == 1 && p_date.fullYear & 0x3 == 0) { dayCount++; }
			}
			
			dayCount += p_date.date - 1;			
			
			return dayCount;
		}
		
		public static function toLongDateString(p_date:Date):String {
			return toString(p_date, "dddd, dd MMMM, yyyy");
		}
		
		public static function toLongMeridiem(p_date:Date):String {
			return toString(p_date, "h:mm:ss tt");
		}
		
		public static function toShortMeridiem(p_date:Date):String {
			return toString(p_date, "h:mm tt");
		}
		
		public static function floorDate(date:Date):Date {
			return new Date(date.fullYear,date.month,date.date,0,0,0,0);
		}
		
		public static function floorWeek(date:Date):Date {
			// GDS: possibly update for sun or mon start?
			return new Date(date.fullYear,date.month,date.date-date.day,0,0,0,0);
		}
		
		public static function toString(p_date:Date, p_mask:String='dd/MM/yy'):String {
			if (p_mask != null) {
				var replFunc:Function = function():String { return formatDate(p_date, arguments[0]); }		
				
				return p_mask.replace(DATE_MASK_PATTERN, replFunc);
			}
			return p_date.toString();
		}
		
		public static function getHourString(hour:int):String {
			return String((hour%12==0)?12:hour%12)+(hour%24>=12?"pm":"am");
		}
		
		public static function getDayString(day:int,len:Number=0):String {
			return (len>0) ? DAY_NAMES[day%7].substr(0,len) : DAY_NAMES[day%7];
		}
		
		public static function getMonthString(day:int,len:Number=0):String {
			return (len>0) ? MONTH_NAMES[day%7].substr(0,len) : MONTH_NAMES[day%7];
		}
		
		// helper methods
		private static function formatDate(p_date:Date, p_mask:String):String {
			var h:int;
			switch (p_mask) { 
				case "hh":
					h = p_date.hours;
					if (h%12 == 0) { h = 12; }
					else if (h >= 13) { h -= 12; }
					
					return StringUtils.padLeft(h.toString(), '0', 2);
					break;
				case "h":
					h = p_date.hours;
					if (h%12 == 0) { h = 12; }
					else if (h >= 13) { h -= 12; }
					
					return h.toString();
					break;
				case "HH":
					return StringUtils.padLeft(p_date.getHours().toString(), '0', 2);
					break;
				case "H":
					return p_date.getHours().toString();
					break;
				case "mm":
					return StringUtils.padLeft(p_date.getMinutes().toString(),'0',2);
					break;
				case "m":
					return p_date.getMinutes().toString();
					break;
				case "ss":
					return StringUtils.padLeft(p_date.getSeconds().toString(),'0',2);
					break;
				case "s":
					return p_date.getSeconds().toString();
					break;
				case "yyyy":
					return p_date.getFullYear().toString();
					break;
				case "yy":
					return p_date.getFullYear().toString().substr(2);
					break;
				case "dddd":
					return getDayName(p_date).toString();
					break;
				case "ddd":
					return getDayName(p_date, true).toString();
					break;
				case "dd":
					return StringUtils.padLeft(p_date.getDate().toString(),'0',2);
					break;
				case "d":
					return p_date.getDate().toString();
					break;
				case "MMMM":
					return getMonthName(p_date);
					break;
				case "MMM":
					return getMonthName(p_date, true);
					break;
				case "MM":
					return StringUtils.padLeft((p_date.getMonth()+1).toString(),'0',2);
					break;
				case "M":
					return (p_date.getMonth()+1).toString();
					break;
				case "tt":
					return p_date.getHours()<12 ? AM_DESIGNATOR : PM_DESIGNATOR;
					break;
				case "t":
					return String(p_date.getHours()<12 ? AM_DESIGNATOR : PM_DESIGNATOR).charAt(0);
					break;
			}
			return '';
		}	
		
		
		/**Getting short Tweeter Style of The Time Past from inserted Date to til now
		 * 
		 * @param - begin Date
		 * @return String - hour to short Tweeter Style <br/>
		 * like 5d, or */
		public static function timePast(date:Date):String
		{
			if(date == null) return '';
			
			var now:Date = new Date();
			var diff:uint = int((now.time - date.time)/1000); // seconds diffrance
			
			
				 if(diff <= 0) return 'now';
			else if(diff < 60) return int(diff) + 's';
			else if(diff < 60*60) return int(diff/60) + 'm';
			else if(diff < 60*60*24) return int(diff/60/60) + 'h';
			else if(diff < 60*60*24*365) return date.date + ' ' + DateUtils.MONTH_NAMES_ABBR[date.month];
			else if(diff > 60*60*24*365) return date.fullYear.toString();
			
			return 'now'
		}
		
		
		
		
		
		
	}
}