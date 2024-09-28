package com.alborzsoft.web.shoutcast.events
{	
	import flash.events.Event;
	import com.alborzsoft.web.shoutcast.types.ShoutcastStationFavorite;
	
	public class FavoriteEvents extends Event
	{
		//================= PUBLIC CONSTANTS ===================
		public static const RESULT:String = 'result';
		
		
		//================= PRIVATE VARRIABLES ===================
		public var result:Vector.<ShoutcastStationFavorite>;
		
		
		public function FavoriteEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false, stations:Vector.<ShoutcastStationFavorite>=null)
		{
			super(type, bubbles, cancelable);
			
			this.result = stations;
		}
		
		
		// Override the inherited clone() method.
		override public function clone():Event
		{
			return new FavoriteEvents(type, false, false, result);
		}
		
		override public function toString():String
		{
			return "[Event type=\""+ type +"\"]";
		}
		
	}
}