package com.alborzsoft.UI
{
	/**<p>SlideShow Class</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Aug 22, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Lite 4, Flash 9, AIR 1.0
	 */
	
	import com.flashdynamix.motion.Tweensy;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.controls.Image;
	

	
	public class SlideShow extends MovieClip
	{
		private var mTimer:Timer;
		private var mPlaceholder1:Loader = new Loader();
		private var mSlide:int;
		
		private var slideInterval:uint;// slide interval
		private var arrURLs:Array = new Array;
		
		private var imageWidth:Number;
		private var imageHeight:Number;
		
		
		
		/** <p><p/>
		 * 
		 * @param file - File that is showing a directory of images
		 * @param width - Width of ScreenSaver
		 * @param height - Height of ScreenSaver
		 * @param slideIntervalSeconds - Secends of showing each Image
		 * @return 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function SlideShow(file:File, width:Number, height:Number, slideIntervalSeconds:uint=3):void
		{
			mSlide = 0;
			this.imageWidth = width;
			this.imageHeight = height;
			slideInterval = slideIntervalSeconds * 1000;
			
			
			// getting the URLs
			for each(var f:File in file.getDirectoryListing())
				if(f.extension.toLowerCase() == 'jpg' || f.extension.toLowerCase() == 'png')
					arrURLs.push(f);
			
			
			// timer event
			mTimer = new Timer(slideInterval + 1000, 0);
			mTimer.addEventListener(TimerEvent.TIMER, fTimer);
			
			
			// adding the main PlaceHoder of images
			addChild(mPlaceholder1);
			mPlaceholder1.alpha = 0;
			mPlaceholder1.contentLoaderInfo.addEventListener(Event.OPEN, fOpen);
			mPlaceholder1.contentLoaderInfo.addEventListener(Event.COMPLETE, fResult);
			
			
			// loading images
			fLoadImage();
		}
		
		
		private function fLoadImage():void
		{
			mPlaceholder1.load(new URLRequest(arrURLs[mSlide].url));
		}
		
		
		private function fTimer(e:TimerEvent):void
		{
			mSlide == arrURLs.length - 1 ? mSlide = 0 : mSlide++;
			fLoadImage();
		}
		
		
		private function fOpen(e:Event):void
		{
			mTimer.stop();
		}
		
		
		private function fResult(e:Event):void
		{
			mTimer.start();
			
			// adding delay to get the File Information
			var tr:Timer = new Timer(100, 1);
			tr.start();
			tr.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
			{
				// scaling the Image
				if(imageWidth != 0) mPlaceholder1.scaleX = imageWidth / e.target.width;
				if(imageHeight != 0) mPlaceholder1.scaleY = imageHeight / e.target.height;
				
				// showing the Image
				Tweensy.to(mPlaceholder1, {alpha:1}, 1);
			});
			
			
			
			// Hiding the Image
			var t:Timer = new Timer(slideInterval, 1);
			t.start();
			t.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
			{
				Tweensy.to(mPlaceholder1, {alpha:0}, 1);
			});
		}
		
		
	}
	
}