package com.alborzsoft.utils
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	public class GraphicsUtil
	{
		public function GraphicsUtil()
		{
		}
		
		
		/** getting repeated bitmap 
		 * 
		 * @param bitmap - A transparent or opaque bitmap image that contains the bits to be displayed.
		 * @param rect - Rectangle of output Shape
		 * @param height - Height of output Shape
		 * @param height - Height of output Shape
		 * 
		 * @return Shape - repeated Shape
		 */
		public static function makeBGTile(bitmap:BitmapData, rect:Rectangle, smooth:Boolean=false):Shape
		{
			var bg:Shape = new Shape;
			
			bg.graphics.beginBitmapFill(bitmap, null, true, smooth);
			bg.graphics.drawRect(0,0, rect.width, rect.height);
			bg.graphics.endFill();
			
			bg.x = rect.x;
			bg.y = rect.y;
			
			return bg;
		}
	}
}