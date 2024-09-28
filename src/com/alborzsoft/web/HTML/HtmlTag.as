package com.alborzsoft.web.HTML
{
	/**<p>HTML Tag static Class</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: May 21, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Lite 4, Flash 9, AIR 1.0
	 */
	public class HtmlTag
	{
		
		/** Paragraph Line Break */
		public static const P:String = '<p/>';
		
		/** Line Break */
		public static const BR:String = '<br/>';
		
		
		
		public function HtmlTag()
		{
		}
		
		
		
		/** <p>Adding 'P' (Paragraph) HTML Tag to a Text<p/>
		 * 
		 * @param text - String
		 * @param textIndent - int value of Text Indention<br/>
		 * @param align - align of Texts - left, right, center, justify
		 * 
		 * @return String - Formed Paragraph HTML
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function p(text:String, textIndent:int=0, align:String='left'):String
		{
			return '<p textIndent="' + textIndent.toString() + '" align="' + align + '">' + text + '</p>'
		}
		
		
		
		/** <p>Adding (A) Anchor tag for links <p/>
		 * 
		 * @param text - String
		 * @param href - String value of Link's location
		 * @param target - String value of Link's opening type
		 * 
		 * @return String - Formed A HTML
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function a(text:String, href:String, target:String='_blank'):String
		{
			return '<a href="event:' + href + '" target="' + target + '">' + text + '</a>';
		}
		
		
		/** <p>Adding 'b' (Bold) HTML Tag to a Text<p/>
		 * 
		 * @param text - String
		 * @return String - Formed Bold HTML tag
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function b(text:String):String
		{
			return '<b>' + text + '</b>';
		}
		
		
		/** <p>Adding 'i' (Italic) HTML Tag to a Text<p/>
		 * 
		 * @param text - String
		 * @return String - Formed Italic HTML tag
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function i(text:String):String
		{
			return '<i>' + text + '</i>';
		}
		
		
		
		/** <p>Adding 'u' (Underline) HTML Tag to a Text<p/>
		 * 
		 * @param text - String
		 * @return String - Formed Underline HTML tag
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function u(text:String):String
		{
			return '<u>' + text + '</u>';
		}
		
		/** <p>Adding 'br' Line Break HTML Tag to a Text<p/>
		 * 
		 * @param text - String
		 * @return String - Formed Italic HTML tag
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function br(text:String):String
		{
			return '<br>' + text + '</br>';
		}
		
		
		
		
		
		/** <p>Adding font HTML tag to a String<p/>
		 * 
		 * @param text - String
		 * @param size - int of size of font, values are: <br/>
		 * 1, 2, 3, 4, 5 , 6, 7 <br/>
		 * +1, +2, +3, +4, +5 , +6 <br/>
		 * -1, -2, -3, -4, -5 , -6 <br/><br/>
		 * 
		 * @param text - String
		 * @param size - Size of Font
		 * @param color - Object of color of font, value is CSS type like #000000, or black, white, yellow, gray, etc.
		 * @param face - Font Face of this String - default is Arial
		 * @return String - Formed font HTML
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function font(text:String, size:int=10, color:Object='#000000', face:String='Arial'):String
		{
			return '<font size="' + size.toString() + '" color="' + color.toString() + '" face="'+ face +'">' +  text + '</font>';
		}
		
		
		
		/** <p>Adding Span HTML Tag to String<p/>
		 * 
		 * @param text - String
		 * @param fontWeight - String of type of font weight <br/>
		 * there is this value <br/>
		 * 100 <br/>
		 * 200 <br/>
		 * 300 <br/>
		 * 400 <br/>
		 * 500 <br/>
		 * 600 <br/>
		 * 700 <br/>
		 * 800 <br/>
		 * 900 <br/>
		 * bold <br/>
		 * bolder <br/>
		 * normal <br/>
		 * lighter <br/>
		 * 
		 * 
		 * @return String - Formed span HTML
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function span(text:String, fontWeight:String='normal'):String
		{
			return '<span fontWeight="'+ fontWeight +'">' + text + '</span>'
		}
		
		
		/** <p>Adding Span HTML Tag to String<p/>
		 * 
		 * @param text - String
		 * @return String - Formed span HTML
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function span2(text:String):String
		{
			return '<span>' + text + '</span>'
		}
		
		
		/** <p>Image HTML Tag<p/>
		 * 
		 * @param src - String of Imahe location
		 * @return width - int of width size of Image
		 * @return height - int of height size of Image
		 * 
		 * @return String - Formed img HTML
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public static function img(src:String, width:int=-1, height:int=-1):String
		{
			var widths:String  = (width > -1) ? (' width="' + width + '"') : '';
			var heights:String = (height > -1) ? (' height="' + height + '"') : '';
			
			return '<img src="' + src + width + height + '/>';
		}
		
	}
}