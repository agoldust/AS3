package com.alborzsoft.utils
{
	public class TypeConvertion
	{
		public function TypeConvertion()
		{
		}
		
		
		
		/** Converting int 2 Boolean
		 * @param value - String Value
		 * @return Boolean
		 * 
		 * @langversion ActionScript 3.0
	     * @playerversion Flash 9.0
	     * @tiptext
		 */
		public static function string2boolean(value:String):Boolean
		{
			return (value == "0") ? false : true;
		}
		
		
		
		/** Converting int to String
		 * @param str - String Value
		 * @return Number
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function int2string(num:int, wildCardSize:int=2):String
		{
			var result:String = "";
			var grade:int = num.toString().length;
			
			// filling the wildSize with 0 charachter
			for(var i:int=0; i<wildCardSize-grade; i++)
			{
				result += "0";
			}

			result += num.toString();
			
			return result;
		}
		
		
		
		/** Converting Hex String to Number
		 * @param str - String Value
		 * @return Number
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function hex2dec(str:String):Number
		{
			var val:int;
			var num:int;
			var char:String;
			var result:int = -1;
			
			for(var i:int=0; i<str.length; i++)
			{
				char = str.charAt(i);
				char = char.toUpperCase();
				val  = char.charCodeAt(0);
				
				if(val >=65 && val <= 70) num = val-55;
				else					  num = int(char);
				
				if(result == -1) result = num;
				else			 result = result * 16 + num;
			}
			
			return result;
		}
		
	}
}