package com.alborzsoft.air
{
	import adobe.utils.ProductManager;
	import flash.desktop.NativeApplication;
		
	
	public class AirAplication
	{
		public function AirAplication()
		{
			
		}
		
		
		public static function reboot():void
		{
			var mgr:ProductManager = new ProductManager("airappinstaller");
			mgr.launch("-launch " + NativeApplication.nativeApplication.applicationID + " " + NativeApplication.nativeApplication.publisherID);
			NativeApplication.nativeApplication.exit();
		}
	}
}