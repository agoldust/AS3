package com.alborzsoft.utils
{
	public class MinMax
	{
		public function MinMax()
		{
		}
		
		
		// creates an Array between 2 Integer
		public function minMax(min:int, max:int):Array
		{
			var res:Array = new Array;
			
			for(var i:int=min; i<=max; i++)	res.push(i);
			
			return res
		}
		
		// creates an Array with Even Numbers between 2 Integer
		public function evenMinMax(min:int, max:int):Array
		{
			var i:int = min;
			var res:Array = new Array;
			
			for(i; i<=max; i++)
				if(i%2 == 0) res.push(i);
			
			return res;
		}
		
		
		// creates an Array with Odd Numbers between 2 Integer
		public function oddMinMax(min:int, max:int):Array
		{
			var i:int = min;
			var res:Array = new Array;
			
			for(i; i<=max; i++)
				if(i%2 == 1) res.push(i);
			
			return res;
		}
		
	}
}