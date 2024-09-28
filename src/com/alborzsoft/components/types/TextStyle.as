package com.alborzsoft.components.types
{
	import com.alborzsoft.utils.ColorUtils;

	[Bindable]
	public class TextStyle
	{
		public var color:uint;
		public var fontSize:uint;
		
		public var isBold:Boolean;
		public var isItalic:Boolean;
		public var isUnderline:Boolean;
		
		public var fontFamily:String;
		
		
		
		public function TextStyle(color:uint = 0x000000, fontSize:uint = 10, isBold:Boolean = false, isItalic:Boolean = false, fontFamily:String = 'Arial', isUnderline:Boolean=false)
		{
			this.color = color;
			this.fontSize = fontSize;
			
			this.isBold = isBold;
			this.isItalic = isItalic;
			this.isUnderline = isUnderline;
			this.fontFamily = fontFamily;
		}
		
		
		public function get colorCSS():String 
		{
			return ColorUtils.colorToCSS(color);
		}
	}
}