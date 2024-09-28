package com.alborzsoft.utils
{
	public final class Sort
	{
		public function Sort()
		{
		}
		
		
		
		/** <p>Shell Sort<p/>
		 * 
		 * @param data - Array
		 * @return Array - sorted Array
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function shellSort(data:Array):Array 
		{
			var n:int = data.length;
			var inc:int = int(n/2);
			
			while(inc)
			{
				for(var i:int=inc; i<n; i++)
				{
					var temp:Number = data[i].row;
					var j:int = i;
					
					while(j >= inc && data[int(j - inc)].row > temp)
					{
						data[j].row = data[int(j - inc)].row;
						j = int(j - inc);
					}
					data[j].row = temp
				}
				inc = int(inc / 2.2);
			}
			
			return data;
		}
		
	}
}