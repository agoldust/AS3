package com.alborzsoft.database.events
{
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	
	public class SQLErrorEvent extends flash.events.SQLErrorEvent
	{
		public static const SCHEMA_NOT_MATCH:String = 'schemaNotMatch';
				
		public function SQLErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, error:SQLError=null)
		{
			super(type, bubbles, cancelable, error);
		}
	}
}