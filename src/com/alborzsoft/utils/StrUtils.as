package com.alborzsoft.utils
{
	/** String Utilities class by Akbar Goldust, Jan 11 2011 
	 */
	public class StrUtils
	{
		/** Enter Character */
		public static const utf8_ENTER:String = '&#xd;';

		/** Space Character */
		public static const utf8_SPACE:String = '&nbsp; ';

		
		
		/** Check's 2 String to be the same
		 * 
		 * @param str1 - String value
		 * @param str2 - String Value
		 * @param capitalization=false - set True if you wants to ignore Capitalization 
		 * @result Boolean - True if the both are the Same
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function isEqual(str1:String, str2:String, cap:Boolean=false):Boolean
		{
			// cheking for null
				 if(str1 == null && str2 == null) return true;
			else if(str1 == null || str2 == null) return false;
			
			// varriables
			var len1:int = str1.length;
			var len2:int = str2.length;
			
			//returns False if the length of String are Diffrent
			if(len1 != len2) return false;
			
			
			// ignoring Capitalization
			if(cap == true){
				str1 = str1.toLocaleLowerCase();
				str2 = str2.toLocaleLowerCase();
			}
			
			
			//check 2 String Character by Character
			for(var i:int=0; i<len1; i++) {
				if(str1.charCodeAt(i) != str2.charCodeAt(i)) {
					return false;
				}
			}
			
			return true;
		}
		
		
		
		/** <p>Matches the specifed pattern against the string and returns a new string in which the all matchs of pattern is replaced with the content specified by replace.<p/>
		 * 
		 * @param p	- base String value
		 * @param remove - String that needs to be removed
		 * @param replace - String that needs to be added to text instead the old one
		 * 
		 * @return String - new String file
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function replaceAll(p:String, remove:String=',', replace:String='-'):String 
		{
			var result:String = '';
			var arr:Array = p.split(remove);
			
			for (var i:int=0; i<arr.length; i++)
			{
				if(i==arr.length-1)	result += arr[i];
				else				result += arr[i] + replace;
			}
			
			return result;
		}
		
		/** <p>Matches the Array of patterns against the string and returns a new string in which the all matchs of pattern is replaced with the content specified by replace.<p/>
		 * 
		 * @param p	- base String value
		 * @param arrRemove - Array if Strings that needs to be removed
		 * @param replace - String that needs to be added to text instead the old one
		 * 
		 * @return String - new String file
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function replaceAll2(p:String, arrRemove:Array, replace:String=''):String
		{
			for each(var str:String in arrRemove)
				p = StrUtils.replaceAll(p, str, replace);
				
			return 	p;
		}
		
		
		
		/** <p>Replacing Special Entities of HTML to UTF-8<p/>
		 * <br/>like replacing &amp; to &
		 * 
		 * @param str - String
		 * @return replaced String
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function replaceHTMLSpecialEntities(str:String):String
		{
			str = StrUtils.replaceAll(str, '&amp;',	'&');
			str = StrUtils.replaceAll(str, '&lt;',	'<');
			str = StrUtils.replaceAll(str, '&gt;',	'>');
			str = StrUtils.replaceAll(str, '&apos;',"'");
			str = StrUtils.replaceAll(str, '&quot;','"');
			
			return str;
		}
		
		
		/** <p>Returns a substring consisting of the characters that start at the specified startIndex and with a length specified by len. The original string is unmodified.<p/>
		 * 
		 * @param startIndex - An integer that specified the index of the first character to be used to create the substring.
		 * @param endReverseIndex - An integer that specified the index of the end character from the end of String to be used to create the substring.
		 *  If len is not specified, the substring includes all the characters from startIndex to the end of the string. <br/>
		 * 
		 * @return A substring based on the specified parameters.
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function subStr(str:String, startIndex:int=0, endReverseIndex:int=0):String
		{
			return str.substr(startIndex, (str.length - (endReverseIndex+1)));
		}
		
		
		/**
		 *	Capitallizes the first word in a string or all words..
		 *
		 *	@param p_string The string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function capitalize(p_string:String):String {
			var str:String = '';
			var arr:Array = p_string.split(' ');
			
			for each(var word:String in arr)
			{
				word = StringUtils.trimLeft(word); // removing any white spaces form the left
				
				var c1:String = word.charAt(0).toLocaleUpperCase();
				var c2:String = word.substring(1).toLocaleLowerCase();
				
				str += c1 + c2 + ' '; 
			}
			
			// adding Space to the End of String
			if(p_string.charAt(p_string.length-1) == ' ')
			{
				str = StringUtils.removeExtraWhitespace(str);
				str += ' '; 
			}
			
			// removing extra white spaces
			str = str.substr(0, p_string.length);
			
			return str;
		}
		
		
		
		/** Get a Random String Between 0 to int.MAX_VALUE
		 * @return String - Random Strin Number
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function randomString():String
		{
			var str:String = (Math.random()*int.MAX_VALUE).toString();
			
			str = replaceAll(str, '.' , '');
			
			return str;
		}
		
		
		/** Adds ran=randomnumber to end of your url to make that uniqe
		 * @return String - URL with a Uniqe ran number
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function randomNewURL(url:String):String
		{
			return url + '?do=' + StrUtils.randomString();
		}
		
		
		
		/** get's the Main Domain name of a Full addreess URL    ,like http://google.com/ddf  >>  google.com
		 * @param site - String of Full Path URL
		 * @return String - of domain name
		 * 
		 * @langversion ActionScript3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function siteDomain(site:String):String
		{
			var regx1:String = '^(?:[^/]+:\/\/)?([^/:]+)';
			
			//site = site.replace(regx1);
			
			// removing HTTP and HTTPS
			site = site.replace(/htt(ps:\/\/|p:\/\/)/g, "");
				 
			if(site.search('#') != -1) site = site.substr(0, site.search('#'));
			if(site.search('?') != -1) site = site.substr(0, site.search('?'));
			if(site.search('/') != -1) site = site.substr(0, site.search('/'));
			
			return site;
		}
		
		
		/** <p>Fixing the url of site<p/>
		 * 
		 * @param url - String of URL  --> like <strong>google</strong>
		 * @return STring - full path url ---> like http://google.com
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function domainFix(url:String):String
		{
			if (!StrUtils.domainHasProtecol(url))  url = "http://" + url;
			if (!StrUtils.domainHasExtention(url)) url += '.com';
			
			return url;
		}
		
		/** <p>If site hast protecols like http or https it will return True<p/>
		 * 
		 * @param url - String of URL  --> like <strong>google</strong>
		 * @return Boolean - True if there is http or https protecol in url
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function domainHasProtecol(url:String):Boolean
		{
			return (url.search(/^htt(ps|p):\/\//)==-1) ? false : true;
		}
		
		/** <p>If site hast Extention like .com it will return True<p/>
		 * 
		 * @param url - String of URL  --> like <strong>google</strong>
		 * @return Boolean - True if there is .com, .net, .org, .us, .tv, .info, .biz, .name, .me, .mobi, .asia, .co.uk, .orguk, .ca, .cn.com, .eu, .cc, .bz, .ws, .in
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function domainHasExtention(url:String):Boolean
		{
			return (url.search(/.(com|net|org|us|tv|info|biz|name|me|mobi|asia|couk|orguk|ca|cncom|eu|cc|bz|ws|in)/)==-1) ? false : true;
		}
		
		
		
		
		/** Removeing the Extra White Space From a Textbase UI Component (like TextField, RichEditableText, etc.)
		 * @param obj - Object of Textbase UI Component
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function removeEWSF_TextUI(obj:Object):void
		{
			obj.text = StringUtils.removeExtraWhitespace(obj.text);
		}
		
		
		/** Will format th Money Number to String Currency. 12000.25 will be like $12,000.25
		 * @param number - Number of Money Value
		 * @param isDollarSign - when it's true it will add a $ on the left of Currency Number. default true.
		 * @return String - String Currency
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function number2Currency(number:Number, isDollarSign:Boolean=true):String
		{
			var result:String = '';
			var isNegetive:Boolean = (number<0) ? true : false;
			var strNumber:String = String(number);
			
			
			// adding Negetive Sign
			if(number<0) {
				result += '-';
				strNumber = strNumber.slice(1);
			}
			
			// adding Dollar Sign
			if(isDollarSign) result += '$';
						
			
			// defining the first point
			var arrNum:Array = strNumber.split('.');
			
			// adding comma ',' aftre each 3 letter form the right
			var fine:String = arrNum[0];
			var temp:String = '';
			
			if(fine.length > 3)
			{
				// adding comma
				for(var i:int=0; i<int(fine.length/3)+1; i++)
				{
					var shift:int = int(fine.length % 3);
					var LSH:int = (shift != 0) ? shift : 3;
					
					temp += fine.substr(0, LSH) + ',';
					fine = fine.substr(LSH);
				}
				
				// removing last comma
				arrNum[0] = temp.substr(0, temp.length-1);
			}
			
			
				 if(arrNum.length == 1) result += arrNum[0];
			else if(arrNum.length == 2) result += arrNum[0] + '.' + arrNum[1];
			else {
				throw Error('your Number is Wrong!! please make like this >>  2500.25');
			}
			
			return result;
		}
		
		
		/** Will format the String Currency to Money Number . $12,000.25 will be like 12000.25 
		 * @param number - String of Money Value
		 * @return Number - String Currency
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0		
		 */
		public static function currency2Number(number:String):Number
		{
			var result:Number = 0;
			
			// removing the - sign
			var isNegetive:Boolean = (number.charAt(0)=='-') ? true : false;
			if(isNegetive) number = number.substr(1);
			
			// removing the $ sign
			if(number.charAt(0) == '$') number = number.substr(1);
			
			// slicing the values
			var arrNumber:Array = number.split('.');
			var arrFine:Array = arrNumber[0].split(',');
			var len:int = arrFine.length;
			var j:int = 0;
			
			for(var i:int=len-1; i>=0; i--)
			{
				result +=  arrFine[i] * Math.pow(10, ((j++)*3));
			}
			
			result += Number(String('0.' + arrNumber[1]));
			
			if(isNegetive) result *= -1;
			
			return result;
		}
		
		
		
		
		/** <p>Fixed Lenght String<p/>
		 * 
		 * @param String - int value
		 * @param ditiCount - count of digits, if ditiCount is less than num.lenght there will be no effect
		 * 
		 * @return String - Fixed String of Old String
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function fixedLengthString(str:String, ditiCount:int=1):String
		{
			var dif:int = ditiCount - str.length;;
			
				 if(dif == 0) return str;
			else if(dif <  0) return str.substr(0, ditiCount);
			else {
				for(var i:int=0; i<dif; i++)
					str += ' ';
			}
			
			return str;
		}
		
		
		/** <p>Converting Interger to Fixed Digit String<p/>
		 * 
		 * @param num - int value
		 * @param ditiCount - count of digits, if ditiCount is less than num.lenght there will be no effect
		 * 
		 * @return String - Fixed String of integer
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function fixedInteger(num:int, ditiCount:int=1):String
		{
			var result:String = '';
			
			
			if(num>0)
			{
				while(num>0)
				{				
					if(num < int(Math.pow(10, --ditiCount))) // checking to be less than requested fixed Digit
					{
						result += '0';
					}
					else{
						result += num.toString();
					}
					
					//exit from loop when calculation is done
					if(num == int(result)) num = -1;
				}
			}
			
			else {
				for(var i:int=0; i<ditiCount; i++)
					result += '0';
			}
				
			
			
			return result;
		}
		
		
		
		/** <p>Adding Currency Comma<p/>
		 * 
		 * @param num - int value
		 * @return String - formated Text
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */				
		public static function addCurrencyComma(num:int):String
		{
			return num.toString().replace(/(\d)(?=(\d{3})+$)/gixsm, "$1,");
		}
		
		
		
		/** <p>Get Spacified amount of blank space<p/>
		 * 
		 * @param numbers - uint value of Space that needed
		 * @return String - String of Spaces
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public static function space(numbers:uint):String
		{
			var str:String = '';
			
			for(var i:int=0; i<numbers; i++)
				str += ' ';
			
			return str;
		}
		
		
		/** <p>Decoding the Unicode Text<p/>
		 * 
		 * @param str - String
		 * @return String - decoded String
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function decodeUnicode(str:String):String
		{
			while(str.search(/&#\w\w\w\w;/) != -1)
			{
				var bof:int = str.search(/&#\w\w\w\w;/);
				var strCode:String = str.substr(bof+2, 4);
				var code:int = int(strCode);
				
				str = str.replace(/&#\w\w\w\w;/, String.fromCharCode(code));
			}
			
			return str;
		}
		
		
		
		
		
		/** <p>Get The Estimated Read Time in milliseconds<p/>
		 * 
		 * @param text - String of Text
		 * @param age - age of reader
		 * @return uint - Milliseconds
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function estimatedReadTime(text:String, age:Number=20):uint
		{
			var wordPerSec:Number;
			
				 if(age > 30)	wordPerSec = 4;
			else if(age > 19)	wordPerSec = 3;
			else if(age > 15)	wordPerSec = 2.7;
			else if(age > 12)	wordPerSec = 2.5;
			else if(age > 10)	wordPerSec = 1.2;
			else if(age > 9)	wordPerSec = 1.1;
			else if(age > 8)	wordPerSec = 1;
			else if(age > 7)	wordPerSec = 0.7;
			else if(age > 6)	wordPerSec = 0.5;
			else				wordPerSec = 0.3;
			
			
			var wordCount:uint = StringUtils.wordCount(text);
			
			return (wordCount/wordPerSec) * 1000;
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}
