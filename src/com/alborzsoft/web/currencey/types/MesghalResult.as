package com.alborzsoft.web.currencey.types
{
	import com.alborzsoft.date.PersianDate;
	
	import mx.collections.ArrayCollection;
	
	
	
	public class MesghalResult
	{
		public var title:String;
		public var update_date:PersianDate;
		[Bindable] public var result:Array;
		
		
		public function MesghalResult(xml:XML=null)
		{
			result = new Array;
		}
		
		
		public function get result_AC():ArrayCollection 
		{
			var al:ArrayCollection = new ArrayCollection;
			
			for each(var money:Money in result)
			{
				al.addItem(money);
			}
			
			return al;
		}
		
		
	}
}