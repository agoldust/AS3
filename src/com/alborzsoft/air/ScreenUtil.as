package com.alborzsoft.air
{
	/**
	 * 	Screen Utilities class by Akbar Goldust, Jan 3 2011
	 */
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.system.Capabilities;

	public class ScreenUtil
	{
		public function ScreenUtil()
		{
		}
		
		/** <p>Getting The Screen Resolution<p/>
		 * 
		 * @return Array - containd of [width and height]
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		
		public static function get screenResolution():Array 
		{
			var width:int  = flash.system.Capabilities.screenResolutionX;
			var height:int = flash.system.Capabilities.screenResolutionY;
			
			return [width, height];
		}
		*/
		
		
		
		/**
		 *	Resizing window and move the object to the center of window
		 *
		 *	@param obj  - The Object that you wants to centerized.
		 *	@param stage -  The Stage of your Window.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion AIR 1.1, Lite 4
		 */
		public static function alignCenter(obj:Object, stage:Stage):void
		{
			var width:int  = ScreenUtil.width();
			var height:int = ScreenUtil.height();	
			
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
			stage.nativeWindow.width = width;
			stage.nativeWindow.height = height;
			
			obj.x = (width /2) - (obj.width /2) + stage.nativeWindow.x;
			obj.y = (height/2) - (obj.height/2) + stage.nativeWindow.y;
		}
		
		
		/**
		 *	Move All open windows to the center
		 *
		 *  @param alwaysOnTop - Boolean,the true value indicates Application to be Always on top of all other Application, default false
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion AIR 2.0
		 */
		public static function center(alwaysInFront:Boolean=false):void
		{
			var width:int  = ScreenUtil.width();
			var height:int = ScreenUtil.height();		
			
			for each (var nv:NativeWindow in NativeApplication.nativeApplication.openedWindows)
			{
				nv.x = (width /2) - (nv.width /2);
				nv.y = (height/2) - (nv.height/2);
					
				nv.alwaysInFront = alwaysInFront;
			}
		}
		
		
		/** <p>Maximizing Application to all of the Screen<p/>
		 * 
		 * @param alwaysOnTop - Boolean,the true value indicates Application to be Always on top of all other Application, default false
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.1
		 */
		public static function maximize(alwaysInFront:Boolean=false):void 
		{
			var width:int  = ScreenUtil.width();
			var height:int = ScreenUtil.height();
			var appDes:ApplicationDescriptor = new ApplicationDescriptor;

			
			for(var i:int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i)
			{
				var nv:NativeWindow = NativeWindow(NativeApplication.nativeApplication.openedWindows[i]);
				
				if(nv.title != 'Updating: ' + appDes.name)
				{
					nv.x = 0;
					nv.y = 0;
					nv.width = width;
					nv.height = height;
					
					nv.alwaysInFront = alwaysInFront;
				}
			}
		}
			
		
		
		/** <p>Specifies the maximum horizontal resolution of the screen. The server string is R (which returns both the width and height of the screen). This property does not update with a user's screen resolution and instead only indicates the resolution at the time Flash Player or an Adobe AIR application started. Also, the value only specifies the primary screen.<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function width():Number 
		{
			return flash.system.Capabilities.screenResolutionX;
		}
		
		/** <p>Specifies the maximum vertical resolution of the screen. The server string is R (which returns both the width and height of the screen). This property does not update with a user's screen resolution and instead only indicates the resolution at the time Flash Player or an Adobe AIR application started. Also, the value only specifies the primary screen.<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flash 9, AIR 1.0, Lite 4
		 */
		public static function height():Number 
		{
			return flash.system.Capabilities.screenResolutionY;
		}
		
		
	}
}