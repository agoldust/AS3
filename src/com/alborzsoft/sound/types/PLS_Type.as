package com.alborzsoft.sound.types
{
	
	[Bindable]
	public class PLS_Type
	{
		public var url:String;
		public var title:String;
		public var status:Array;
		
		
		public function PLS_Type(url:String='', title:String='', status:Array=null)
		{
			this.url = url;
			this.title = title;
			this.status = status;
		}
	}
}