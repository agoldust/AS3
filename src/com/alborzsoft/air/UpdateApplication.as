package com.alborzsoft.air
{
	/**<p>Custom Class For Updating the Application</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Mar 26, 2011</p>
	 * 
	 * @param String - updaterConfig.xml address of your local configuration file
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, AIR 2.5
	 */
	
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.filesystem.File;
	
	
	public class UpdateApplication
	{
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VARRIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		private var _configurationFile:String;
		private var updater:ApplicationUpdaterUI = new ApplicationUpdaterUI;
				
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		public function UpdateApplication(configurationFile:String)
		{
			_configurationFile = configurationFile;
			
			checkUpdate();
		}
		
		
		public function get configurationFile():String 
		{
			return _configurationFile;
		}
		
		
		/** <p>checking the Update of Application<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, AIR 2.5
		 */
		private function checkUpdate():void
		{
			updater.configurationFile = File.applicationDirectory.resolvePath(_configurationFile);
			updater.addEventListener(UpdateEvent.INITIALIZED, checkNow);
			updater.initialize();
		}
		
		
		public function checkNow(e:*=null):void
		{
			updater.checkNow();
		}
		
		
	}
}