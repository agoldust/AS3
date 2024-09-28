package com.alborzsoft.database.dataTypes
{
	import com.alborzsoft.date.PersianDate;
	import com.alborzsoft.utils.StringUtils;

	[Bindable("propertyChange")]
	public class Person2 extends Person
	{
		public var familyName:String;
		public var fatherName:String;
		public var birthCcertificate:String;
		public var nationalIdentity:String;
		public var birthDate:PersianDate;
		
		public var lastDegree:String;
		public var issuedPlace:String;
		
		
		public function Person2()
		{
			birthDate = new PersianDate;
		}
		
		public function get fullName():String 
		{
			return StringUtils.removeExtraWhitespace(name + ' ' + familyName);
		}
		
		
		public function get fullName2():String 
		{
			return StringUtils.removeExtraWhitespace(name + '  ' + familyName);
		}
	}
}