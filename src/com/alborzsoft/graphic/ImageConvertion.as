package com.alborzsoft.graphic
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
		
		
	public class ImageConvertion
	{
		public function ImageConvertion()
		{
		}
		
		
		/** <p>Resizing and saving Image<p/>
		 * 
		 * @param url - String value of URL of current Image
		 * @param saveURL - String value of URL of new Image <br/>if you wants to override the old image with this new one, use the same URL for saveURL
		 * @param width - int amount of Width of Image
		 * @param height - int amount of Height of Image
		 * @param type - String value of Type of Image that can be jpg or png
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function resizeImage(url:String, saveURL:String, width:int, height:int, type:String='png'):void
		{
			//first open image file and get bytearray
			var file:File = new File(url);
			var file2:File = new File(saveURL);
			var stream:FileStream = new FileStream();
			var ba:ByteArray = new ByteArray();

			stream.open(file, FileMode.READ);
			stream.readBytes(ba); 
			stream.close();
			
			
			//Transform byteArray to bitmapdata
			var loader:Loader = new Loader;
			loader.loadBytes(ba);
			
			
			// saving the Images
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function():void
			{
				// resizing the BitmapData
				var bmd:BitmapData = resizeBitmap(loader.content as Bitmap, width, height);
				
				
				//Transform BitmapData to ByteArray, in this case a I use JPEG Encoder but there’s also a Png Encoder
				var it:ImageTypes = new ImageTypes
				var myJPG:ByteArray = it.convertImageFormat(bmd, type);
				
				
				// Save the byteArray to file
				var stream:FileStream = new FileStream();
				stream.open(file2, FileMode.WRITE);
				stream.writeBytes(myJPG);
				stream.close();
			});
		}
		
		
		/** <p>Resizing the Bitmap Data<p/>
		 * 
		 * @param bitmap - Bitmap data of your image
		 * @param width - Number amount of Width of Bitmap data
		 * @param height - Number amount of Height of Bitmap data
		 * @return resized BitmapData
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.0
		 */
		public function resizeBitmap(bitmap:Bitmap, width:Number, height:Number):BitmapData
		{
			var bmd:BitmapData = new BitmapData(bitmap.width, bitmap.height,true,0x00000000);
			bmd.draw(bitmap, null, null, null, null, true);
			
			
			// Set the scale you want and apply to a Matrix
			var scaleX:Number = width / bitmap.width;
			var scaleY:Number = height / bitmap.height;
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleX, scaleY);
			
			
			// Copy BitmapData to Another bitmap data with the matrix crate above
			var bmd2:BitmapData = new BitmapData(width, height, true, 0x000000);
			bmd2.draw(bmd, matrix, null, null, null, true);
			
			return bmd2;
		}
		



	}
}