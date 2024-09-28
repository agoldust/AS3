package com.alborzsoft.graphic.events
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class ImageResultEvent extends Event
	{
		public static const COMPLETE:String	= "complete";
		
		public var byteArray:ByteArray;	//An Array filled with Data Object returned after a succesful twitter request

		
		public function ImageResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, byteArray:ByteArray=null)
		{
			super(type, bubbles, cancelable);
			this.byteArray = byteArray;
		}
		
		
		override public function toString():String
		{
			return "[Event type=\""+type+"\"]";
		}
	}
}