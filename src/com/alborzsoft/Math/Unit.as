package com.alborzsoft.Math
{
	public class Unit
	{
		public function Unit()
		{
		}
		
		
		// =========================================== MILLIMETERS ======================================
		/** <p>Millimeters to Inch<p/>
		 * 
		 * @param value - Nmuber Value of Millimeters
		 * @return Number - Number value of Inch
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function mm2in(value:Number):Number
		{
			return value * 0.03937;
		}
		
		
		
		
		// =========================================== CENTIMETERS ======================================
		/** <p>Centimeters to Millimeters<p/>
		 * 
		 * @param value - Nmuber Value of Centimeters
		 * @return Number - Number value of Millimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function cm2mm(value:Number):Number
		{
			return value * 10;
		}
		
		
		/** <p>Centimeters to Millimeters<p/>
		 * 
		 * @param value - Nmuber Value of Centimeters
		 * @return Number - Number value of Inches
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function cm2in(value:Number):Number
		{
			return value * 0.3937007874015748;
		}
		
		
		
		/** <p>Centimeters to Feet<p/>
		 * 
		 * @param value - Nmuber Value of Centimeters
		 * @return Number - Number value of Feets
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function cm2feet(value:Number):Number
		{
			return value * 0.0328083989501312;
		}
		
		
		
		/** <p>Centimeters to Yard<p/>
		 * 
		 * @param value - Nmuber Value of Centimeters
		 * @return Number - Number value of Yards
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function cm2yard(value:Number):Number
		{
			return value * 0.0109361329833771;
		}
		
		
		
		
		
		
		
		
		// =========================================== METERS ======================================
		/** <p>Meters to Millimeters<p/>
		 * 
		 * @param value - Nmuber Value of Meters
		 * @return Number - Number value of Millimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function m2mm(value:Number):Number
		{
			return value * 1000;
		}
		
		
		
		/** <p>Meters to Centimeters<p/>
		 * 
		 * @param value - Nmuber Value of Meters
		 * @return Number - Number value of Centimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function m2cm(value:Number):Number
		{
			return value * 100;
		}
		
		
		
		/** <p>Meters to Feet<p/>
		 * 
		 * @param value - Nmuber Value of Meters
		 * @return Number - Number value of Feet
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function m2f(value:Number):Number
		{
			return value * 3.281;
		}
		
		
		
		/** <p>Meters Per Second to Feet Per Second<p/>
		 * 
		 * @param value - Nmuber Value of Meters Per Second
		 * @return Number - Number value of Feet Per Second
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function mps2fps(value:Number):Number
		{
			return value * 3.281;
		}
		
		
		
		
		
		
		
		
		// =========================================== KILOMTERS ======================================
		/** <p>Kilometers to Meters<p/>
		 * 
		 * @param value - Nmuber Value of Kilometers
		 * @return Number - Number value of Meters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function km2m(value:Number):Number
		{
			return value * 1000;
		}
		
		
		
		/** <p>Kilometers to Miles<p/>
		 * 
		 * @param value - Nmuber Value of Kilometers
		 * @return Number - Number value of Miles
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function km2mi(value:Number):Number
		{
			return value * 0.6214;
		}
		
		
		
		
		
		
		// =========================================== INCHES ======================================
		
		/** <p>Inchs to Centimeters<p/>
		 * 
		 * @param value - Nmuber Value of Inchs
		 * @return Number - Number value of Centimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function in2cm(value:Number):Number
		{
			return value * 2.54;
		}
		
		
		/** <p>Inch to Millimeters<p/>
		 * 
		 * @param value - Nmuber Value of Inchs
		 * @return Number - Number value of Millimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function in2mm(value:Number):Number
		{
			return value * 25.4;
		}
		
		
		/** <p>Inch to Feet<p/>
		 * 
		 * @param value - Nmuber Value of Inchs
		 * @return Number - Number value of Feets
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function in2feet(value:Number):Number
		{
			return value * 0.0833333333333333;
		}
		
		
		/** <p>Inch to Yard<p/>
		 * 
		 * @param value - Nmuber Value of Inchs
		 * @return Number - Number value of Yards
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function in2yard(value:Number):Number
		{
			return value * 0.0277777777777778;
		}
		
		
		/** <p>Square Inchs to Square Centimeters<p/>
		 * 
		 * @param value - Nmuber Value of Square Inchs
		 * @return Number - Number value of Square Centimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function sqin2sqcm(value:Number):Number
		{
			return value * 6.4516;
		}
		
		
		
		
		
		
		// =========================================== FEET ======================================
		/** <p>Feet to Inches<p/>
		 * 
		 * @param value - Nmuber Value of Feet
		 * @return Number - Number value of Inches
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function ft2in(value:Number):Number
		{
			return value * 12;
		}
		
		
		
		/** <p>Feet to Meteres<p/>
		 * 
		 * @param value - Nmuber Value of Feet
		 * @return Number - Number value of Meteres
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function ft2m(value:Number):Number
		{
			return value * 0.3048;
		}
		
		
		
		
		
		
		
		
		
		// =========================================== YARD ======================================
		/** <p>Yard to Feet<p/>
		 * 
		 * @param value - Nmuber Value of Yard
		 * @return Number - Number value of Feet
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function yd2ft(value:Number):Number
		{
			return value * 3;
		}
		
		
		
		/** <p>Yard to Meteres<p/>
		 * 
		 * @param value - Nmuber Value of Yard
		 * @return Number - Number value of Meteres
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function yd2m(value:Number):Number
		{
			return value * 0.9144;
		}
		
		
		
		
		
		
		
		// =========================================== MILES ======================================
		/** <p>Miles to Feet<p/>
		 * 
		 * @param value - Nmuber Value of Miles
		 * @return Number - Number value of Feet
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function mi2ft(value:Number):Number
		{
			return value * 5280;
		}
		
		
		
		/** <p>Miles to Meteres<p/>
		 * 
		 * @param value - Nmuber Value of Miles
		 * @return Number - Number value of Meteres
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function mi2m(value:Number):Number
		{
			return value * 1609.3;
		}
		
		
		
		
		
		/** <p>Miles to Kilometeres<p/>
		 * 
		 * @param value - Nmuber Value of Miles
		 * @return Number - Number value of Kilometeres
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function mi2km(value:Number):Number
		{
			return value * 1.6093;
		}
		
		
		
		
		
		
		
		
		
		
		
		// =========================================== Temperature Conversions ======================================
		
		/** <p>Celsius to Fahrenheit<p/>
		 * 
		 * @param value - Nmuber Value of degrees Celsius
		 * @return Number - Number value of degrees Fahrenheit
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function C2F(value:Number):Number
		{
			return value * 1.8 + 32;
		}
		
		
		
		/** <p>Fahrenheit to Celsius<p/>
		 * 
		 * @param value - Nmuber Value of degrees Fahrenheit
		 * @return Number - Number value of degrees Celsius
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function F2C(value:Number):Number
		{
			return value * 1.8 + 32;
		}
		
		
		
		
		// =========================================== Energy Conversions ======================================
		/** <p>Kilojoule to Calories<p/>
		 * 
		 * @param value - Nmuber Value of Kilojoule
		 * @return Number - Number value of Calories
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function KJ2Cals(num:Number):Number
		{
			return num * 238.8458966274959;
		}
		
		/** <p>Calories to Kilojoule<p/>
		 * 
		 * @param value - Nmuber Value of Calories
		 * @return Number - Number value of Kilojoule
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function Cals2KJ(num:Number):Number
		{
			return num * 0.0041868;
		}
		
		
		
		
		// =========================================== Weights  ======================================

		/** <p>KG 2 Pound<p/>
		 * 
		 * @param value - Nmuber Value of Gallons
		 * @return Number - Number value of Liters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function kg2pound(value:Number):Number
		{
			return value * 2.20462;
		}
		
		/** <p>KG 2 Ounce<p/>
		 * 
		 * @param value - Nmuber Value of Gallons
		 * @return Number - Number value of Liters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function kg2ounc(value:Number):Number
		{
			return value * 35.274;
		}
		
		
		
		
		// =========================================== CIRCLE ======================================
		/** <p>Angle 2 Radian<p/>
		 * 
		 * @param angle - Nmuber Value of Angle
		 * @return Number - Number value of Radian
		 */
		public static function angle2Radian(angle:Number):Number
		{
			return angle * Math.PI / 180;
		}
		
		
		/** <p>Radian 2 Angle<p/>
		 * 
		 * @param radian - Nmuber Value of Radian
		 * @return Number - Number value of Angle
		 */
		public static function radian2Angle(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		
		
		
		// =========================================== Weights and Measures ======================================
		
		/** <p>Gallon 2 Liters<p/>
		 * 
		 * @param value - Nmuber Value of Gallons
		 * @return Number - Number value of Liters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function gallon2Liter(value:Number):Number
		{
			return value * 3.785;
		}
		
		
		
		/** <p>Liters 2 Gallon<p/>
		 * 
		 * @param value - Nmuber Value of Liters
		 * @return Number - Number value of Gallons
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function liter2Gallon(value:Number):Number
		{
			return value * 0.2642;
			
		}
		
		
		
		/** <p>Ounce 2 Pounds<p/>
		 * 
		 * @param value - Nmuber Value of Ounces
		 * @return Number - Number value of Pounds
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function ounce2Pound(value:Number):Number
		{
			return value * 0.0625;
		}
		
		
		
		/** <p>Ounce 2 Grams<p/>
		 * 
		 * @param value - Nmuber Value of Ounces
		 * @return Number - Number value of Grams
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function ounce2Gram(value:Number):Number
		{
			return value * 28.35;
		}
		
		
		
		/** <p>Ounce 2 Grain<p/>
		 * 
		 * @param value - Nmuber Value of Ounces
		 * @return Number - Number value of Grains
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function ounce2Grain(value:Number):Number
		{
			return value * 437.5;
		}
		
		
		
		
		
		/** <p>Pound 2 Ounces<p/>
		 * 
		 * @param value - Nmuber Value of Pounds
		 * @return Number - Number value of Ounces
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Ounce(value:Number):Number
		{
			return value * 16;
		}
		
		
		
		/** <p>Pound 2 Kilograms<p/>
		 * 
		 * @param value - Nmuber Value of Pounds
		 * @return Number - Number value of Kilograms
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Kilogram(value:Number):Number
		{
			return value * 0.45359237;
		}
		
		
		
		/** <p>Pound 2 Grain<p/>
		 * 
		 * @param value - Nmuber Value of Pounds
		 * @return Number - Number value of Grain
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Grain(value:Number):Number
		{
			return value * 7000;
		}
		
		
		
		/** <p>Pound 2 Grain<p/>
		 * 
		 * @param value - Nmuber Value of Pounds
		 * @return Number - Number value of Carat
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Carat(value:Number):Number
		{
			return value * 2267.96185;
		}
		
		
		/** <p>Pound 2 Stone<p/>
		 * 
		 * @param value - Nmuber Value of Pounds
		 * @return Number - Number value of Stones
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Stone(value:Number):Number
		{
			return value * 0.0714285714285714;
		}
		
		
		
		/** <p>Pound 2 Pounds Troy<p/>
		 * 
		 * @param value - Nmuber Value of Pounds
		 * @return Number - Number value of Pounds Troy
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2PoundTR(value:Number):Number
		{
			return value * 1.2153;
		}
		
		
		
		/** <p>Quart 2 Pints<p/>
		 * 
		 * @param value - Nmuber Value of Quart
		 * @return Number - Number value of Pints
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Pint(value:Number):Number
		{
			return value * 2;
		}
		
		
		
		/** <p>Quart 2 Gallon<p/>
		 * 
		 * @param value - Nmuber Value of Quart
		 * @return Number - Number value of Gallons
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Gallon(value:Number):Number
		{
			return value * 0.25;
		}
		
		
		
		
		/** <p>Quart 2 Liter<p/>
		 * 
		 * @param value - Nmuber Value of Quart
		 * @return Number - Number value of Liters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4, FLash 9
		 */
		public static function pound2Liter(value:Number):Number
		{
			return value * 0.9464;
		}
		
		
		
	}
}






















