package com.alborzsoft.air
{
	import com.alborzsoft.utils.StrUtils;
	
	import flash.desktop.NativeApplication;
	
	
	public class ApplicationDescriptor
	{
		private var appXML:XML;;
		private var ns:Namespace;
		
		
		public function ApplicationDescriptor()
		{
			appXML = NativeApplication.nativeApplication.applicationDescriptor;
			ns = appXML.namespace();
			
			var strTemp:String = appXML.toString();
			strTemp = StrUtils.replaceAll(strTemp, 'xmlns="' + ns + '"', '');
			appXML = XML(strTemp);
		}
		
		
		/** <p>Getting the Version of Current SDK that is using on this Application<p/> */
		public function get sdkVersion():Number
		{
			return Number(ns.uri.slice(36));
		}
		
		
		/** <p>A universally unique application identifier. Must be unique across all AIR applications.</br>
		 *  Using a reverse DNS-style name as the id is recommended. (Eg. com.example.ExampleApplication.) Required.<p/>*/
		public function get id():String 
		{
			return appXML.id;
		}
		
		/** <p>Used as the filename for the application.<p/> */
		public function get filename():String 
		{
			return appXML.filename;
		}
		
		
		
		/** <p>The name that is displayed in the AIR application installer.<p/>*/
		public function get name():String 
		{
			return appXML.name;
		}
		
		
		/** <p>An application version designator<p/> */
		public function get versionLable():String
		{
			var versionLabel:String;
			
			if(sdkVersion < 2.5) versionLabel = appXML.version;
			else				 versionLabel = appXML.versionLabel;
			
			return versionLabel;
		}
		
		
		/** <p>A string value of the format <0-999>.<0-999>.<0-999> that represents application version which can be used to check for application upgrade.<p/>*/
		public function get versionNumber():String 
		{
			return appXML.versionNumber;
		}
		
		
		/** <p>Copyright information. Optional<p/> */
		public function get copyright():String 
		{
			return appXML.copyright;
		}
		
		
		
		
		/** <p>The icon the system uses for the application.<p/> */
		public function get icons():Array 
		{
			var arrIcons:Array = new Array;
			
			if(sdkVersion < 2.5) {
				arrIcons.push(removeTag(appXML.icon.image16x16));
				arrIcons.push(removeTag(appXML.icon.image32x32));
				arrIcons.push(removeTag(appXML.icon.image48x48));
				arrIcons.push(removeTag(appXML.icon.image128x128));
			}
			else {
				arrIcons.push(removeTag(appXML.icon.image16x16));
				arrIcons.push(removeTag(appXML.icon.image32x32));
				arrIcons.push(removeTag(appXML.icon.image36x36));
				arrIcons.push(removeTag(appXML.icon.image48x48));
				arrIcons.push(removeTag(appXML.icon.image72x72));
				arrIcons.push(removeTag(appXML.icon.image128x128));
			}
			
			return arrIcons;
		}
		
		
		private function removeTag(xml:XMLList):String
		{
			return xml.toString().replace(new RegExp(/<[^<]+?>/g), '');
		}
		
		
		
		
		
		
		
		
		
		
	}
}