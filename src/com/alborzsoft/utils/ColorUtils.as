package com.alborzsoft.utils
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	import spark.filters.ColorMatrixFilter;
	
	
	public class ColorUtils
	{
		public function ColorUtils()
		{
		}
		
		
		/** Changing Color Offset of Shape by Offset
		 * @param mc - MovieClip that will be changed
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function colorOffset(mc:MovieClip, red:int, green:int, blue:int):void
		{
			var colorT:ColorTransform = new ColorTransform();
			
			colorT.redOffset   += red;
			colorT.greenOffset += green;
			colorT.blueOffset  += blue;
			
			mc.transform.colorTransform = colorT;
		}
		
		/** Changing Color of Shape by Offset
		 * @param color - uint of Color, like 0xFF0000
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function colorTransform(mc:MovieClip, color:uint):void
		{
			var colorT:ColorTransform = new ColorTransform();
			
			colorT.color = color
			mc.transform.colorTransform = colorT;
		}
		
		
		/** Changing Color of Shape by Offset
		 * @param mc - MovieClip that will be changed
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function colorTransform2(mc:MovieClip, red:uint, green:uint, blue:uint):void
		{  
			var color:uint = RGB2Hex(red, green, blue);
			var colorT:ColorTransform = new ColorTransform();
			
			colorT.color = color;
			mc.transform.colorTransform = colorT;
		}
		
		
		
		/** <p>Appling a Grayscale Filter to any Display Object<p/>
		 * 
		 * @param image - DisplayObject
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function convertToGrayscale(image:DisplayObject):void
		{
			var matrix:Array = [0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0, 0, 0, 1, 0];
			
			var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			var filters:Array = image.filters; 
			filters.push(grayscaleFilter);
			image.filters = [grayscaleFilter];
		}
		
		
		
		
		/**
		 * Converting Red, Green Blue values to uint Hexadecimal Value
		 * @ Param r the red (R) indicating the number (0-255)
		 * @ Param g green (G) indicates the number (0-255)
		 * @ Param b blue (B) shows the number (0-255)
		 * @ Return obtained from the RGB color value for each indicating the number
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 **/
		public static function RGB2Hex(r:uint, g:uint, b:uint):uint
		{
			var hex:uint = (r << 16 | g << 8 | b);
			return hex;
		}
		
		/**
		 * Converting uint Hexadecimal Value to Red, Green Blue values
		 * @ Param hex - uint Value - like 0xFF0000 for red
		 * @ Return Array - [Red, Green, Blue]
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 **/
		public static function Hex2RGB(hex:uint):Array
		{
			var rgb:Array = [];
			
			var r:uint = hex >> 16 & 0xFF;
			var g:uint = hex >> 8 & 0xFF;
			var b:uint = hex & 0xFF;
			
			rgb.push(r, g, b);
			return rgb;
		}
		
		
		/** <p>Inverting HEX Color<p/>
		 * 
		 * @param uint - Value of color
		 * @return uint - Inverted Value of color
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function invertHEX(color:uint):uint
		{
			var red:uint = ColorUtils.extractRedFromHEX(color);
			var green:uint = ColorUtils.extractGreenFromHEX(color);
			var blue:uint = ColorUtils.extractBlueFromHEX(color);
			
			red = (255 - red);
			green = (255 - green);
			blue = (255 - blue);
			
			return RGB2Hex(red, green, blue);
		}
		
		
		
		/** <p>Changing the Brighness of Color<p/>
		 * 
		 * @param color - uint value of color
		 * @param brightness - Number between 0-1 <br/> % of Brightness
		 * @return uint color
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function HEXBrightness(color:uint, brightness:Number):uint
		{
			var red:uint = ColorUtils.extractRedFromHEX(color);
			var green:uint = ColorUtils.extractGreenFromHEX(color);
			var blue:uint = ColorUtils.extractBlueFromHEX(color);
			var hsv:Array = RGB2HSV(red, green, blue);
			
			if (brightness < 0){brightness = 0};
			if (brightness > 1){brightness = 1};
			
			brightness *= 100;
			
			hsv[2] = brightness;
			
			var rgb:Array = HSV2RGB(hsv[0],hsv[1],hsv[2]);
			
			return RGB2Hex(rgb[0], rgb[1], rgb[2]);
		}
		
		
		/** <p>Converting Colored Image to Grey<p/>
		 * 
		 * @param color - uint color Value
		 * @return uint - Grayescale value of it
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function HEXtoGreyScale(color:uint):uint
		{
			var red:uint = ColorUtils.extractRedFromHEX(color);
			var green:uint = ColorUtils.extractGreenFromHEX(color);
			var blue:uint = ColorUtils.extractBlueFromHEX(color);
			var av:Number = (red + green + blue) / 3;
			
			red = green = blue = av;
			
			return RGB2Hex(red, green, blue);
		}
		
		
		/** <p>Ectracting Red Value from a Color<p/>
		 * 
		 * @param color - uint color Value
		 * @return uint - Red value of it
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function extractRedFromHEX(color:uint):uint
		{
			return (( color >> 16 ) & 0xFF);
		}
		
		/** <p>Ectracting Green Value from a Color<p/>
		 * 
		 * @param color - uint color Value
		 * @return uint - Green value of it
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function extractGreenFromHEX(color:uint):uint
		{
			return ((color >> 8) & 0xFF);
		}
		
		/** <p>Ectracting Blue Value from a Color<p/>
		 * 
		 * @param color - uint color Value
		 * @return uint - Blue value of it
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function extractBlueFromHEX(color:uint):uint
		{
			return (color & 0xFF);
		}
		
		
		
		/** <p>calculate the difference between two colors (the CIE 1976 method)<p/>
		 * 
		 * @param color1 - Number of color 0x000000 - 0xFFFFFF
		 * @param color2 - Number of color 0x000000 - 0xFFFFFF
		 * 
		 * @return Number of diffrance between 2 colors
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function diff(color1:Number, color2:Number):Number
		{
			var R1:uint = (color1 >> 16) & 0xff;
			var G1:uint = (color1 >> 8) & 0xff;
			var B1:uint = color1 & 0xff;
			var R2:uint = (color2 >> 16) & 0xff;
			var G2:uint = (color2 >> 8) & 0xff;
			var B2:uint = color2 & 0xff;
			
			var lab1:Object = ColorUtils.rgb2lab(R1,G1,B1);
			var lab2:Object = ColorUtils.rgb2lab(R2,G2,B2);
			
			var diff76:Number = Math.sqrt((lab2.l - lab1.l)*(lab2.l - lab1.l) + (lab2.a - lab1.a)*(lab2.a - lab1.a) + (lab2.b - lab1.b)*(lab2.b - lab1.b));
			
			return diff76;
		}
		
		
		
		
		/** <p>convert RGB to XYZ LAB color<p/>
		 * 
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @return Object - XYZ Color data 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function rgb2xyz(R:uint,G:uint,B:uint):Object
		{
			//R from 0 to 255
			//G from 0 to 255
			//B from 0 to 255
			var r:Number = R/255;
			var g:Number = G/255;
			var b:Number = B/255;
			
			if (r > 0.04045){ r = Math.pow((r + 0.055) / 1.055, 2.4); }
			else { r = r / 12.92; }
			if ( g > 0.04045){ g = Math.pow((g + 0.055) / 1.055, 2.4); }
			else { g = g / 12.92; }
			if (b > 0.04045){ b = Math.pow((b + 0.055) / 1.055, 2.4); }
			else {	b = b / 12.92; }
			
			r = r * 100;
			g = g * 100;
			b = b * 100;
			
			//Observer. = 2°, Illuminant = D65
			var xyz:Object = {x:0, y:0, z:0};
			xyz.x = r * 0.4124 + g * 0.3576 + b * 0.1805;
			xyz.y = r * 0.2126 + g * 0.7152 + b * 0.0722;
			xyz.z = r * 0.0193 + g * 0.1192 + b * 0.9505;
			
			return xyz;
		}
		
		
		/** <p>convert XYZ to LAB color<p/>
		 * 
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @return Object - LAB Color data 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function xyz2lab(X:Number, Y:Number, Z:Number ):Object
		{
			const REF_X:Number = 95.047; // Observer= 2°, Illuminant= D65
			const REF_Y:Number = 100.000; 
			const REF_Z:Number = 108.883; 
			
			var x:Number = X / REF_X;   
			var y:Number = Y / REF_Y;  
			var z:Number = Z / REF_Z;  
			
			if ( x > 0.008856 ) { x = Math.pow( x , 1/3 ); }
			else { x = ( 7.787 * x ) + ( 16/116 ); }
			if ( y > 0.008856 ) { y = Math.pow( y , 1/3 ); }
			else { y = ( 7.787 * y ) + ( 16/116 ); }
			if ( z > 0.008856 ) { z = Math.pow( z , 1/3 ); }
			else { z = ( 7.787 * z ) + ( 16/116 ); }
			
			var lab:Object = {l:0, a:0, b:0};
			lab.l = ( 116 * y ) - 16;
			lab.a = 500 * ( x - y );
			lab.b = 200 * ( y - z );
			
			return lab;
		}
		
		
		/** <p>convert LAB to XYZ color<p/>
		 * 
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @return Object - XYZ Color data 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function lab2xyz( l:Number, a:Number, b:Number ):Object
		{
			const REF_X:Number = 95.047; // Observer= 2°, Illuminant= D65
			const REF_Y:Number = 100.000; 
			const REF_Z:Number = 108.883; 
			
			var y:Number = (l + 16) / 116;
			var x:Number = a / 500 + y;
			var z:Number = y - b / 200;
			
			if ( Math.pow( y , 3 ) > 0.008856 ) { y = Math.pow( y , 3 ); }
			else { y = ( y - 16 / 116 ) / 7.787; }
			if ( Math.pow( x , 3 ) > 0.008856 ) { x = Math.pow( x , 3 ); }
			else { x = ( x - 16 / 116 ) / 7.787; }
			if ( Math.pow( z , 3 ) > 0.008856 ) { z = Math.pow( z , 3 ); }
			else { z = ( z - 16 / 116 ) / 7.787; }
			
			var xyz:Object = {x:0, y:0, z:0};
			xyz.x = REF_X * x;     
			xyz.y = REF_Y * y; 
			xyz.z = REF_Z * z; 
			
			return xyz;
		}
		
		
		
		/** <p>convert XYZ to RGB color<p/>
		 * 
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @return Object - RGB Color data 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function xyz2rgb(X:Number, Y:Number, Z:Number):Object
		{
			//X from 0 to  95.047      (Observer = 2°, Illuminant = D65)
			//Y from 0 to 100.000
			//Z from 0 to 108.883
			
			var x:Number = X / 100;        
			var y:Number = Y / 100;        
			var z:Number = Z / 100;        
			
			var r:Number = x * 3.2406 + y * -1.5372 + z * -0.4986;
			var g:Number = x * -0.9689 + y * 1.8758 + z * 0.0415;
			var b:Number = x * 0.0557 + y * -0.2040 + z * 1.0570;
			
			if ( r > 0.0031308 ) { r = 1.055 * Math.pow( r , ( 1 / 2.4 ) ) - 0.055; }
			else { r = 12.92 * r; }
			if ( g > 0.0031308 ) { g = 1.055 * Math.pow( g , ( 1 / 2.4 ) ) - 0.055; }
			else { g = 12.92 * g; }
			if ( b > 0.0031308 ) { b = 1.055 * Math.pow( b , ( 1 / 2.4 ) ) - 0.055; }
			else { b = 12.92 * b; }
			
			var rgb:Object = {r:0, g:0, b:0}
			rgb.r = Math.round( r * 255 );
			rgb.g = Math.round( g * 255 );
			rgb.b = Math.round( b * 255 );
			
			return rgb;
		}
		
		
		/** <p>convert RGB to Lab color<p/>
		 * 
		 * @param red - Red offset 0-255
		 * @param green - Green offset 0-255
		 * @param blue - Blue offset 0-255
		 * 
		 * @return Object - LAB Color data 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function rgb2lab(R:uint, G:uint, B:uint):Object
		{
			var xyz:Object = ColorUtils.rgb2xyz(R, G, B);
			return ColorUtils.xyz2lab(xyz.x, xyz.y, xyz.z);
		}
		
		
		
		/** <p>Converting uint value to String value to be used in CSS - example 0xFFFFFF to #FFFFFF<p/>
		 * 
		 * @param color - uint of a color - like 0xFFFFFF
		 * @return String - Well formed CSS color - like #FFFFFF
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function colorToCSS(color:uint):String
		{
			return 	'#' + color.toString(16);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//=======================================================
		public static function RGB2HSV(r:Number, g:Number, b:Number):Array
		{
			var max:uint = Math.max(r, g, b);
			var min:uint = Math.min(r, g, b);
			
			var hue:Number = 0;
			var saturation:Number = 0;
			var value:Number = 0;
			
			var hsv:Array = [];
			
			//get Hue
			if(max == min){
				hue = 0;
			}else if(max == r){
				hue = (60 * (g-b) / (max-min) + 360) % 360;
			}else if(max == g){
				hue = (60 * (b-r) / (max-min) + 120);
			}else if(max == b){
				hue = (60 * (r-g) / (max-min) + 240);
			}
			
			//get Value
			value = max;
			
			//get Saturation
			if(max == 0){
				saturation = 0;
			}else{
				saturation = (max - min) / max;
			}
			
			hsv = [Math.round(hue), Math.round(saturation * 100), Math.round(value / 255 * 100)];
			return hsv;
		}
		
		
		public static function HSV2RGB(h:Number, s:Number, v:Number):Array
		{
			var r:Number = 0;
			var g:Number = 0;
			var b:Number = 0;
			var rgb:Array = [];
			
			var tempS:Number = s / 100;
			var tempV:Number = v / 100;
			
			var hi:int = Math.floor(h/60) % 6;
			var f:Number = h/60 - Math.floor(h/60);
			var p:Number = (tempV * (1 - tempS));
			var q:Number = (tempV * (1 - f * tempS));
			var t:Number = (tempV * (1 - (1 - f) * tempS));
			
			switch(hi){
				case 0: r = tempV; g = t; b = p; break;
				case 1: r = q; g = tempV; b = p; break;
				case 2: r = p; g = tempV; b = t; break;
				case 3: r = p; g = q; b = tempV; break;
				case 4: r = t; g = p; b = tempV; break;
				case 5: r = tempV; g = p; b = q; break;
			}
			
			rgb = [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
			return rgb;
		}

		
		
		
		
		
		
		
		
		public static function RGBToHex(r:uint, g:uint, b:uint):uint
		{
			var hex:uint = (r << 16 | g << 8 | b);
			return hex;
		}
		
		public static function RGBtoHSV(r:Number, g:Number, b:Number):Array
		{
			var max:uint = Math.max(r, g, b);
			var min:uint = Math.min(r, g, b);
			
			var hue:Number = 0;
			var saturation:Number = 0;
			var value:Number = 0;
			
			var hsv:Array = [];
			
			//get Hue
			if(max == min){
				hue = 0;
			}else if(max == r){
				hue = (60 * (g-b) / (max-min) + 360) % 360;
			}else if(max == g){
				hue = (60 * (b-r) / (max-min) + 120);
			}else if(max == b){
				hue = (60 * (r-g) / (max-min) + 240);
			}
			
			//get Value
			value = max;
			
			//get Saturation
			if(max == 0){
				saturation = 0;
			}else{
				saturation = (max - min) / max;
			}
			
			hsv = [Math.round(hue), Math.round(saturation * 100), Math.round(value / 255 * 100)];
			return hsv;
		}

		
		public static function getAnalogousFromHex(c:uint,rot:Number):uint
		{
			var r:Number=extractRedFromHEX(c);
			var g:Number=extractGreenFromHEX(c);
			var b:Number = extractBlueFromHEX(c); 
			
			var hsv:Array = RGBtoHSV(r, g, b);
			var h:Number = hsv[0];
			var s:Number = hsv[1];
			var v:Number = hsv[2];
			
			h += rot;
			
			if (h < 0) { h = 359 - h }
			else if (h > 359) { h = h - 359 };
			
			var rgb:Array = HSV2RGB(h, s, v);
			
			return RGBToHex(rgb[0], rgb[1], rgb[2]);
		}
		
		public static function HEXTriad(c:uint):Array
		{
			var c1:uint = c;
			var c2:uint = getAnalogousFromHex(c, 120);
			var c3:uint = getAnalogousFromHex(c, 240);
			
			var triad:Array = [c1, c2, c3];
			
			return triad;
		}
		
		public static function HEXTetrad(c:uint):Array
		{
			var c1:uint = c;
			var c2:uint = getAnalogousFromHex(c, 90);
			var c3:uint = getAnalogousFromHex(c, 180);
			var c4:uint = getAnalogousFromHex(c, 270);
			
			var tetrad:Array = [c1, c2, c3, c4];
			
			return tetrad;
		}
		
		public static function HEXHue(c:uint,a:Number):uint
		{
			var r:Number=extractRedFromHEX(c);
			var g:Number=extractGreenFromHEX(c);
			var b:Number = extractBlueFromHEX(c); 
			
			var hsv:Array = RGBtoHSV(r, g, b);
			var h:Number = hsv[0];
			var s:Number = hsv[1];
			var v:Number = hsv[2];
			
			h = a;
			
			if (h < 0) { h = 359 - h }
			else if (h > 359) { h = h - 359 };
			
			var rgb:Array = HSV2RGB(h, s, v);
			
			return RGBToHex(rgb[0], rgb[1], rgb[2]);
		}

		public static function HEXSaturation(c:uint,a:Number):uint
		{
			var r:Number=extractRedFromHEX(c);
			var g:Number=extractGreenFromHEX(c);
			var b:Number=extractBlueFromHEX(c);
			
			var hsv:Array = RGBtoHSV(r,g,b);
			
			if (a < 0){a = 0};
			if (a > 1){a = 1};
			
			a *= 100;
			
			hsv[1] = a;
			
			var rgb:Array = HSV2RGB(hsv[0],hsv[1],hsv[2]);
			
			return RGBToHex(rgb[0],rgb[1],rgb[2]);
		}
		
		public static function HEXtoString(c:uint,t:Boolean):String
		{
			//return uint in form 0xFFFFFF or #FFFFFF as string
			var r:String=extractRedFromHEX(c).toString(16).toUpperCase();
			var g:String=extractGreenFromHEX(c).toString(16).toUpperCase();
			var b:String=extractBlueFromHEX(c).toString(16).toUpperCase();
			var hs:String="";
			var zero:String="0";
			
			if(r.length==1){r=zero.concat(r)};
			if(g.length==1){g=zero.concat(g)};
			if(b.length==1){b=zero.concat(b)};
			
			if (t){hs="0x"+r+g+b} else {hs="#"+r+g+b};
			
			return hs;
		}
		
		public static function HEXStringToHEX(hex:String):uint
		{
			hex = hex.replace('#', "");
			hex = "0x" + hex;
			
			return new uint(hex);
		}
		
		public static function hex2hexString(hex:uint):String
		{
			return hex.toString(16).toLocaleUpperCase();
		}
		
		
		

		public static function colouriseHEX(c:uint,r:Number,g:Number,b:Number):uint
		{
			if (r>1){r=1}
			else if (r<-1){r=0};
			if (g>1){g=1}
			else if (g<-1){g=0};
			if (b>1){b=1}
			else if (b<-1){b=-1};
			
			var rE:Number=extractRedFromHEX(c);
			var gE:Number=extractGreenFromHEX(c);
			var bE:Number=extractBlueFromHEX(c);
			
			rE = rE * r;
			gE = gE * g;
			bE = bE * b;
			
			if (r>255){r=255};
			if (g>255){g=255};
			if (b>255){b=255};
			if (r<0){r=0};
			if (g<0){g=0};
			if (b<0){b=0};
			
			return RGBToHex(rE, gE, bE);
		}
		
		public static function RGBHEXtoARGBHEX(rgb:uint, newAlpha:uint):uint
		{
			//newAlpha has to be in the 0 to 255 range
			var argb:uint = 0;
			argb += (newAlpha<<24);
			argb += (rgb);
			return argb;
		}
		
		
	}
	
	
}



