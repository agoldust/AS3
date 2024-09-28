package com.alborzsoft.database.dataTypes
{
	import com.alborzsoft.date.PersianDate;

	[Bindable("propertyChange")]
	public class Person
	{
		public var id:int;
		public var name:String;
		public var email:String;
		
		
		public var phone:String;
		public var cellphone:String;
		public var address:String;
		public var city:String;
		public var state:String;
		public var zip:String;
		
		public var receive_email:Boolean;
		public var registration_date:Date;
		
		
		public function Person()
		{
		}
		
		/** Registration date in Persian Date format */
		public function get registration_date_persian():PersianDate
		{
			return PersianDate.juilan2Persian(registration_date);
		}
	}
}