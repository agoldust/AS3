package com.alborzsoft.air
{
	/**<p>This Class Adds Icon to Tray Icon of Windows and DockIcon of Mac</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Mar 26, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, AIR 2.5
	 */
	
	import com.alborzsoft.UI.AboutUsWin;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.NotificationType;
	import flash.desktop.SystemTrayIcon;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import spark.components.Window;
	
	
	public class TrayDockIcon
	{
		//====================== CONST's ======================
		private const STR_OPEN:String = 'Open';
		private const STR_SHOW:String = 'Show';
		private const STR_HIDE:String = 'Hide';
		private const STR_CLOSE:String = 'Close';
		private const STR_ABOUTUS:String = 'About us';
		
		
		//====================== VARRIABLES ======================
		private var trayIcon:BitmapData;
		private var arrIcons:Array = new Array;
		private var showAboutUs:Boolean = false;
		private var appDes:ApplicationDescriptor = new ApplicationDescriptor;
		
		
		//Menu ITems
		private var winMenu:NativeMenu = new NativeMenu();
		private var macMenu:NativeMenu = new NativeMenu();
		
		private var openItem:NativeMenuItem = new NativeMenuItem(STR_HIDE);
		private var showItem:NativeMenuItem = new NativeMenuItem(STR_SHOW);
		private var closeItem:NativeMenuItem = new NativeMenuItem(STR_CLOSE);
		private var aboutusItem:NativeMenuItem = new NativeMenuItem(STR_ABOUTUS);
		private var versionItem:NativeMenuItem = new NativeMenuItem(appDes.name + ' v' + appDes.versionLable);

		
		
		

		
		
		
		
		//====================== FUNCTIONS ======================
		/** Displaying Icon on Tray Icon of Windows or Dock Icon of Mac
		 * @param withClose - Boolean type, when True application goes to Tray while Closing
		 * @param withMinimize - Boolean type, when True application goes to Tray while Minimizeing
		 * 
		 * @opratingsystem Windows Mac
  		 * @playerversion AIR 1.5
		 * @langversion ActionScript 3.0
		 */
		public function TrayDockIcon(withClose:Boolean=false, withMinimize:Boolean=false, startAtLogin1:Boolean=false, showAboutUs:Boolean=false)
		{
			setTrayDockIcon(withClose, withMinimize);
			
			
			if(startAtLogin1)
				startAtStartup(true);
			
			this.showAboutUs = showAboutUs;
		}
		
		
		// Set the Stage
		private function setTrayDockIcon(withClose:Boolean=false, withMinimize:Boolean=false):void
		{
			// loading tray bitmap data
			if(appDes.icons.length > 0)
				loadTrayIcon();
			
			// goto Tray Icon If you Close the Application
			if(withClose)
				NativeApplication.nativeApplication.openedWindows[0].addEventListener(Event.CLOSING, minToTray);
			
			// goto Tray Icon If you Minimize the Application
			if(withMinimize)
				NativeApplication.nativeApplication.openedWindows[0].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, winMinimized);
		}
		
		
		private function loadTrayIcon():void
		{
			// creating Loaders for Icons
			var loader:Loader;
			
			// gettying array of icons
			var arrIcons:Array = appDes.icons;
			
			// loading icons
			for each(var url:String in appDes.icons)
			{
				if(StringUtils.hasText(url))
				{
					loader = new Loader;
					loader.load(new URLRequest(url));
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, readyToTray);
				}
			}
		}
		
		private function minToTray(event:Event):void
		{
			dock();
		}
		
		private function readyToTray(event:Event):void
		{
			arrIcons.push(event.target.content.bitmapData);
			
			
			if(arrIcons.length == appDes.icons.length)
			{
				/*// sorting the Array
				var arr:Array = [arrIcons[0],arrIcons[0],arrIcons[0],arrIcons[0]];
				
				for each(var bmd:BitmapData in arrIcons)
				{
						 if(bmd.width == 16)  arr[0] = bmd;
					else if(bmd.width == 32)  arr[1] = bmd;
					else if(bmd.width == 48)  arr[2] = bmd;
					else if(bmd.width == 128) arr[3] = bmd;
				}
				arrIcons = arr;
				*/
								
				
				// Adding Menu Items
				versionItem.checked = true;
				
				openItem.addEventListener(Event.SELECT, dock);
				closeItem.addEventListener(Event.SELECT, closeApp);
				showItem.addEventListener(InvokeEvent.INVOKE, unDock2);
				aboutusItem.addEventListener(Event.SELECT, openAboutUS);
				
				
				winMenu.addItem(openItem);
				winMenu.addItem(new NativeMenuItem("", true));
				winMenu.addItem(versionItem);
				winMenu.addItem(new NativeMenuItem("", true));

				if(showAboutUs){
					winMenu.addItem(aboutusItem);
					winMenu.addItem(new NativeMenuItem("", true));
				}

				winMenu.addItem(closeItem);
				macMenu.addItem(showItem);
				
				/*
				var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = appXML.namespace();
				var menuTooltip:String = appXML.ns::name + " v" + appXML.ns::version;				
				*/
				var ad:ApplicationDescriptor = new ApplicationDescriptor;
				var versionNumber:String = (appDes.hasOwnProperty('versionLable')) ? appDes.versionLable : appDes.versionNumber;
				var menuTooltip:String = appDes.filename + " v" + versionNumber;		
				
				
				// adding Tray ICON  (or Dock) and  Menu
				if(NativeApplication.supportsSystemTrayIcon)
				{
					SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = menuTooltip;
					SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, unDock);
					SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = winMenu;
										
					//shows icon alvays for Windows in Tray Icon
					SystemTrayIcon(NativeApplication.nativeApplication.icon).bitmaps = arrIcons;
				}
				else if(NativeApplication.supportsDockIcon)
				{
					// un Doking the App
					NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, unDock2);
					
					// Adding Menu to Dock
					var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
					//dockIcon.menu = macMenu;
					//dockIcon.bounce(NotificationType.CRITICAL);
				}
				
			}
			
		}
		
		
		/** <p>Adding Native Menu Item to Tray or Dech Icon<p/>
		 * 
		 * @param item - NativeMenuItem that is going to be inserted
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function addMenuItem(item:NativeMenuItem):void
		{
			winMenu.addItemAt(item, winMenu.items.length-1);
		}
		
		
		
		/** <p>Removing Native Menu Item with name property<p/>
		 * 
		 * @param name - String of name property of that NativeMenuItem
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function removeMenuItem(name:String):void
		{
			for each(var nmi:NativeMenuItem in winMenu.items)
			{
				if(nmi.name)
				if(nmi.name == name)
					winMenu.removeItem(nmi);
			}
		}
		
		
		
		
		
		private function winMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void
		{
			if(displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
			{
				displayStateEvent.preventDefault();
				dock();
			}
		}
		
		public function openAboutUS(event:Event=null):void
		{
			var window:Window = new AboutUsWin;
			
			for(var i:int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i)
				if(NativeWindow(NativeApplication.nativeApplication.openedWindows[i]).title == window.title)
					return;
			
			
			window.open(false);
		}
		
		
		/** <p>Running Application at Starttup of OS<p/>
		 * 
		 * @param startAtLogin - Boolean value for running Application at Starttup of OS
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.0
		 */
		public static function startAtStartup(startAtLogin:Boolean):void 
		{
			if(NativeApplication.supportsStartAtLogin)
			{
				NativeApplication.nativeApplication.startAtLogin = startAtLogin;
			}
		}
		
		
		
		/** Hide the Application
		 * 
		 * @opratingsystem Windows Mac
		 * @playerversion AIR 1.5.1
		 * @langversion ActionScript 3.0
		 */
		public function dock(event:Event=null):void
		{
			for(var i:int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i)
			{
				NativeWindow(NativeApplication.nativeApplication.openedWindows[i]).visible = false;
			}
			
			openItem.label = STR_OPEN;
			openItem.removeEventListener(Event.SELECT, dock);
			openItem.addEventListener(Event.SELECT, unDock);
			//NativeApplication.nativeApplication.icon.bitmaps = arrIcons;
		}
		
		/** Show the Application
		 * 
		 * @opratingsystem Windows Mac
		 * @playerversion AIR 1.5.1
		 * @langversion ActionScript 3.0
		 */
		public function unDock(event:Event):void
		{
			openAllWindows();
			
			openItem.label = STR_HIDE;
			openItem.removeEventListener(Event.SELECT, unDock);
			openItem.addEventListener(Event.SELECT, dock);
			
			//NativeApplication.nativeApplication.icon.bitmaps = [];
		}
		
		private function unDock2(event:InvokeEvent):void
		{
			unDock(null);
		}
		
		/** Closes the Application
		 * @opratingsystem Windows Mac
		 * @playerversion AIR 1.5.1
		 * @langversion ActionScript 3.0
		 */
		public function closeApp(event:Event=null):void
		{
			// removing the Tray Icon
			NativeApplication.nativeApplication.icon.bitmaps = [];
			
			// closing all Windows
			closeAllWindows();
			
			// closing main window
			NativeApplication.nativeApplication.exit() 
		}
		
		/** Closes all Windows of Application
		 * @opratingsystem Windows Mac
		 * @playerversion AIR 1.5.1
		 * @langversion ActionScript 3.0
		 */
		public function closeAllWindows():void
		{
			for(var i:int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i)
			{
				NativeWindow(NativeApplication.nativeApplication.openedWindows[i]).close();
			}
		}
		
		/** Shows all Windows of Application
		 * @opratingsystem Windows Mac
		 * @playerversion AIR 1.5.1
		 * @langversion ActionScript 3.0
		 */
		// closing all Windows
		public function openAllWindows():void
		{
			for(var i:int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i)
			{
				var nv:NativeWindow = NativeWindow(NativeApplication.nativeApplication.openedWindows[i]);
				
				if(nv.title != 'Updating: ' + appDes.name)
				{
					nv.activate();
				}
			}
		}
	}
}