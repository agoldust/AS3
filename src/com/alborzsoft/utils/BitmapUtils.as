package com.alborzsoft.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.IUIComponent;
	
	import spark.utils.BitmapUtil;

	public class BitmapUtils
	{
		public function BitmapUtils()
		{
		}
		
		
		/** <p>Get Visible Bounds of Transparent Display Object<p/>
		 * 
		 * @param source - Source Display Object
		 * @return Rectangle - that indicates the Place of non transparent Object
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getVisibleBounds(source:DisplayObject):Rectangle
		{
			// Updated 11-18-2010;
			// Thanks to Mark in the comments for this addition;
			var matrix:Matrix = new Matrix()
			matrix.tx = -source.getBounds(null).x;
			matrix.ty = -source.getBounds(null).y;
			
			var data:BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
			data.draw(source, matrix);
			var bounds : Rectangle = data.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);
			data.dispose();
			return bounds;
		}
		
		
		/** <p><p/>
		 * 
		 * @param 
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getVisibleBitmap(source:Bitmap):Bitmap
		{
			//getting the Visible Bound
			var rect:Rectangle = BitmapUtils.getVisibleBounds(source);
			
			//Selecting the visible bound
			var target:Bitmap = new Bitmap(new BitmapData(rect.width, rect.height, true, 0xFF0000));
			target.bitmapData.copyPixels(source.bitmapData, rect, new Point(0,0));
			
			return target;
		}
		
		
		/** <p>Creates a BitmapData representation of the target object.<p/>
		 * 
		 * @param target - The object to capture in the resulting Bitmap
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getSnapshot(target:IUIComponent):Bitmap
		{
			// getting an Snapshot of Print UI
			var bitmap:Bitmap = new Bitmap(BitmapUtil.getSnapshot(target, null, false), PixelSnapping.NEVER, true);

			return BitmapUtils.getVisibleBitmap(bitmap);
		}
		
		
		
		
		
		
		
		
		
	}
}