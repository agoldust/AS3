package com.alborzsoft.graphic
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class ImageTypes
	{
		public static const PNG:String = 'png';
		public static const JPG:String = 'jpg';
		
		
		public function ImageTypes()
		{
		}
		
		
		
		/** <p>Converting BitmapData to JPG or PNG ByteArray<p/>
		 * 
		 * @param bmd
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function convertImageFormat(bmd:BitmapData, type:String='png', quality:Number=73):ByteArray
		{
			if(type == ImageTypes.JPG)
			{
				var jpg:JPGEncoder = new JPGEncoder(quality);
				return jpg.encode(bmd);
			}
			
			else if(type == ImageTypes.PNG)
			{
				return PNGEncoder.encode(bmd);
			}
			
			return null;
		}
		
		
		
		
	}
}