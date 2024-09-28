package com.alborzsoft.utils
{
	import flash.net.dns.AAAARecord;

	public final class NumberUtils
	{
		public function NumberUtils()
		{
		}
		
		
		/** <p>Convert values within a range to values within another range<p/>
		 * 
		 * @param originalStart - Number of start of Original number
		 * @param originalEnd	- Number of end   of Original number
		 * @param newStart		- Number of start of New number
		 * @param newEnd		- Number of end   of New number
		 * @param value			- Number of current Value
		 * 
		 * @return Number		- result Number
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function convertRange(originalStart:Number, originalEnd:Number, newStart:Number,  newEnd:Number, value:Number):Number
		{
			var originalRange:Number = originalEnd - originalStart;
			var newRange:Number = newEnd - newStart;
			var ratio:Number = newRange / originalRange;
			var newValue:Number = value * ratio;
			var finalValue:Number = newValue + newStart;
			
			return finalValue;
		}
		
		
		/** <p>Rounding a Number With specified percision<p/>
		 * 
		 * @param number - Number
		 * @param precision - Precision of rounding
		 * 
		 * @return Number
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function round(number:Number, precision:int):Number
		{
			precision = Math.pow(10, precision);
			return (Math.round(number * precision)/precision);
		}
		
		
		/** <p>Converting IP to Integer<p/>
		 * 
		 * @param ip - String Value of an IP address - <br>
		 * example 1: ip2long('192.0.34.166');<br>
		 * returns 1: 3221234342<br>
		 * example 2: ip2long('0.0xABCDEF');<br>
		 * returns 2: 11259375<br>
		 * @return int - int value of an IP address<br>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		
		/**
		public static function ip2int(ip:String):int
		{
			var ret:int;
			
			// PHP allows decimal, octal, and hexadecimal IP components.
			// PHP allows between 1 (e.g. 127) to 4 (e.g 127.0.0.1) components.
			var IP:Array = ip.match(/^([1-9]\d*|0[0-7]*|0x[\da-f]+)(?:\.([1-9]\d*|0[0-7]*|0x[\da-f]+))?(?:\.([1-9]\d*|0[0-7]*|0x[\da-f]+))?(?:\.([1-9]\d*|0[0-7]*|0x[\da-f]+))?$/i)
			if(!IP)) return 0;
			
			IP[0] = 0;
			
			for (var i:int=1; i<5; i++) {
				IP[0] += !! ((IP[i] || '').length);
				IP[i] = parseInt(IP[i]) || 0;
			}
			
			return ret;
		}
		
		
		function ip2long (IP) {
			// http://kevin.vanzonneveld.net
			// +   original by: Waldo Malqui Silva
			// +   improved by: Victor
			// +    revised by: fearphage (http://http/my.opera.com/fearphage/)
			// +    revised by: Theriault
			// *     example 1: ip2long('192.0.34.166');
			// *     returns 1: 3221234342
			// *     example 2: ip2long('0.0xABCDEF');
			// *     returns 2: 11259375
			// *     example 3: ip2long('255.255.255.256');
			// *     returns 3: false
			var i = 0;
			// PHP allows decimal, octal, and hexadecimal IP components.
			// PHP allows between 1 (e.g. 127) to 4 (e.g 127.0.0.1) components.
			IP = IP.match(/^([1-9]\d*|0[0-7]*|0x[\da-f]+)(?:\.([1-9]\d*|0[0-7]*|0x[\da-f]+))?(?:\.([1-9]\d*|0[0-7]*|0x[\da-f]+))?(?:\.([1-9]\d*|0[0-7]*|0x[\da-f]+))?$/i); // Verify IP format.
			if (!IP) {
				return false; // Invalid format.
			}
			// Reuse IP variable for component counter.
			IP[0] = 0;
			for (i = 1; i < 5; i += 1) {
				IP[0] += !! ((IP[i] || '').length);
				IP[i] = parseInt(IP[i]) || 0;
			}
			// Continue to use IP for overflow values.
			// PHP does not allow any component to overflow.
			IP.push(256, 256, 256, 256);
			// Recalculate overflow of last component supplied to make up for missing components.
			IP[4 + IP[0]] *= Math.pow(256, 4 - IP[0]);
			if (IP[1] >= IP[5] || IP[2] >= IP[6] || IP[3] >= IP[7] || IP[4] >= IP[8]) {
				return false;
			}
			return IP[1] * (IP[0] === 1 || 16777216) + IP[2] * (IP[0] <= 2 || 65536) + IP[3] * (IP[0] <= 3 || 256) + IP[4] * 1;
		}
		 */
	}
}