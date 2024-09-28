package com.alborzsoft.Math
{
	public class Math2
	{
		
		
		/** <p>checking an Integer Value to be even<p/>
		 * 
		 * @param value of Integer number
		 * @return Boolean of result, <b>True for Even</b> and <b>False for Odd</b>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function isEven(value:int):Boolean
		{
			return (value%2 == 0);
		}
		
		
		/** <p>Changing Degree to Radians<p/>
		 * 
		 * @param value - Number value of degrees
		 * @return Number of Radians
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function degreesToRadians(value:Number):Number
		{
			return value * ( Math.PI / 180 );
		}
		
		
		/** <p>Making Random Value Between 2 Value<p/>
		 * 
		 * @param value1 - Numver Value for Starting Random Numbers
		 * @param value2 - Numver Value for Ending Random Numbers
		 * @param isInteger - Boolean that if be True, it will return fixed floating point Number
		 * 
		 * @return Number - of random Numbers
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public static function random(value1:Number, value2:Number, isInteger:Boolean=true):Number 
		{
			
			var biggerValue:Number  = (value2 > value1) ? value2 : value1;
			var smallerValue:Number = (value2 < value1) ? value2 : value1;
			
			var diffrance:Number = biggerValue - smallerValue;
			var temp:Number = Math.random() * diffrance + smallerValue;
			
			
			return (isInteger) ? int(temp) : Number(temp);
		}
		
		
		
		
		/** <p>Random Color<p/>
		 * 
		 * @return uint - of random Color
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public static function randomColor():uint
		{
			return Math.random() * 0xFFFFFF;
		}
		
		
		
		
		/** Calculating Distance between 2 pints
		 * @param x1 - X Position of Point 1
		 * @param y1 - Y Position of Point 1
		 * @param x2 - X Position of Point 2
		 * @param y2 - Y Position of Point 2
		 * @return Number - Distance between 2 points
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 */
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			return Math.sqrt(dx*dx + dy*dy);
		}
		
		
		/** Change the Sign of Number to Positive or Negetive
		 * @param num - Number
		 * @param bePositive - Boolean that True will make Positive
		 * @return Number
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 */
		public static function positive(num:Number, bePositive:Boolean=true):Number
		{
			if(bePositive) return Math.abs(num);
			
			return Math.abs(-10.2)*(-1);
		}
	}
}