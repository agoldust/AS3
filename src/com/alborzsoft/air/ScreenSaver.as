package com.alborzsoft.air
{
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import mx.events.AIREvent;
	
	import spark.components.Window;
	

	public class ScreenSaver
	{
	//============================ VARRIABLES =================================
		//----------PUBLICS
		/** a varriable for defining the ScreenSaver Displaying state */
		public var isOpen:Boolean = false;
		public var displayObject:DisplayObject;
		
		
		//----------PRIVATES
		private var window:Window;
		
		private var timer:Timer;
		private var startDelaySeconds:Number;
		
		
		
		//----------CONSTANTS

		
		
	//============================ METHODS =================================
		/**<p>ScreenSaver Class - When Class Constructed, it will start counting down for showing the DisplayObject</p>
		 * <p>Creatd By: Akbar Goldust</p>
		 * <p>Last modification date: Aug 8, 2011</p>
		 * 
		 * @param backgroundColor - Color of background of ScreenSaver - Default is 0x000000
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4,  AIR 1.5
		 */
		public function ScreenSaver(displayObject:DisplayObject, startDelaySeconds:Number)
		{
			this.displayObject = displayObject;
			this.startDelaySeconds = startDelaySeconds;
			
			start();
		}
		
		
		/** <p>Adding a ScreenSaver MovieClip<p/>
		 * 
		 * @param mc - DisplayObject of ScreenSaver
		 * 
		 * @langversion 3.0
		 * @playerversion Lite 4, Flash 9, AIR 1.5
		 */
		public function addMovieClip(mc:DisplayObject=null, backgroundColor:uint=0x000000):void
		{
			// adding Background Color of ScreenSaver 
			var rect:Sprite = new Sprite;
			rect.graphics.beginFill(backgroundColor);
			rect.graphics.drawRect(0,0, ScreenUtil.width(), ScreenUtil.height());
			rect.graphics.endFill();
			
			addCloseEvents(rect); 			// adding events to the window
			window.stage.addChild(rect);  	// adding to DISPLAY List
			
			
			// adding ScreenSaver MovieClip
			if(mc!=null) 
			{
				addCloseEvents(mc); 			// adding events to the window
				window.stage.addChild(mc);  	// adding to DISPLAY List
			}
		}
		
		
		/**Starting the ScreenSaver Timer*/
		public function start():void
		{
			// deleting last timer
			if(timer != null) {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, open);
				timer = null;
			}
			
			
			// creating new timer
			timer = new Timer(startDelaySeconds * 1000);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, open);
			
			
			refreashResetEvents(); // adding event for resetting timer
		}
		
		
		
		/** <p>Opening the ScreenSaver Window<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function open(e:*=null):void
		{
			isOpen = true;
			Mouse.hide(); // hiding the mouse cursor
			timer.stop();
			
			createWindow(); // setting up the window and opening that
			
			addCloseEvents(window); 	// adding events to the window
		}
		
		
		
		/** <p>Closing the ScreenSaver Window<p/>
		 *
		 * @langversion 3.0
		 * @playerversion AIR 1.5
		 */
		public function close(e:*=null):void
		{
			Mouse.show(); // showing the mouse cursor

			window.close(); // closing the screensaver
			isOpen = false;
			
			reset(); // restarting the screensaver Timer
		}
		
		
		/**Resetting the Show ScreenSaver Timer */
		public function reset(e:*=null):void
		{
			if(timer != null)
			{
				timer.reset();
				timer.start();
			}
		}
		
		
		
		
		/**Adding Reset Event to all open windows For starting the Screensaver*/
		public function refreashResetEvents():void
		{
			for each (var nv:NativeWindow in NativeApplication.nativeApplication.openedWindows)
			{
				addResetEvents(nv.stage);
			}
		}
		
		
		/**Adding Reset Event to window For starting the Screensaver*/
		public function addResetEvents(stage:Stage):void
		{
			stage.addEventListener(MouseEvent.CLICK, 		reset);
			stage.addEventListener(MouseEvent.MIDDLE_CLICK,	reset);
			stage.addEventListener(MouseEvent.RIGHT_CLICK,	reset);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,	reset);
			stage.addEventListener(TouchEvent.TOUCH_BEGIN,	reset);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	reset);
		}
		
		
		/** <p>adding events to the Object<p/>
		 */
		private function addCloseEvents(obj:Object):void
		{
			obj.addEventListener(MouseEvent.CLICK, 			close);
			obj.addEventListener(MouseEvent.MIDDLE_CLICK,	close);
			obj.addEventListener(MouseEvent.RIGHT_CLICK,	close);
			obj.addEventListener(MouseEvent.MOUSE_MOVE,		close);
			obj.addEventListener(TouchEvent.TOUCH_BEGIN,	close);
			obj.addEventListener(KeyboardEvent.KEY_DOWN,	close);
		}
		
		/** setting up the window and opening that*/
		private function createWindow():void
		{
			window = new Window;
			window.systemChrome = 'none';
			window.alwaysInFront = true;
			window.showStatusBar = false;
			
			
			window.open(); // opening the Window
			window.move(0,0);
			window.width = ScreenUtil.width();
			window.height = ScreenUtil.height();
			
			
			window.addEventListener(AIREvent.WINDOW_COMPLETE, function():void 
			{ 
				addMovieClip(displayObject) 
			});
			
		}
		
	}
}