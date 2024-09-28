package com.alborzsoft.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.ObjectUtil;

	public class Util
	{
		public function Util()
		{
		}
		
		
		/** <p>Runing a Function after certain amount of time<p/>
		 * 
		 * @param delay - Number of milliseconds - 1000 == 1sec
		 * @param func - desired Function
		 * @param ...params - add the remaining amount of parameters to this function that will be redirected to func Function
		 * 
		 * @return Timer - varriable of timer
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function doIn(delay:Number, func:Function, ...params):Timer
		{
			var t:Timer = new Timer(delay, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
			{
				 	  if(params.length == 0)  func();
				 else if(params.length == 1)  func(params[0]);
				 else if(params.length == 2)  func(params[0],params[1]);
				 else if(params.length == 3)  func(params[0],params[1],params[2]);
				 else if(params.length == 4)  func(params[0],params[1],params[2],params[3]);
				 else if(params.length == 5)  func(params[0],params[1],params[2],params[3],params[4]);
				 else if(params.length == 6)  func(params[0],params[1],params[2],params[3],params[4],params[5]);
				 else if(params.length == 7)  func(params[0],params[1],params[2],params[3],params[4],params[5],params[6]);
				 else if(params.length == 8)  func(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7]);
				 else if(params.length == 9)  func(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8]);
				 else if(params.length == 10) func(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8],params[9]);
				 else if(params.length == 11) func(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8],params[9],params[10]);
				
			});
			t.start();
			
			return t;
		}
		
		
		
		/** <p>Cloning (Duplicating) an Object or Class<p/>
		 * 
		 * @param source - Object
		 * @return Object - duplicated Object with diffrent memory address
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function clone(source:*):Object {
			
			var clone:Object;
			if(source) {
				clone = newSibling(source);
				
				if(clone) {
					copyData(source, clone);
				}
			}
			
			return clone;
		}
		
		
		
		
		public static function newSibling(sourceObj:Object):* {
			if(sourceObj) {
				
				var objSibling:*;
				try {
					var classOfSourceObj:Class = getDefinitionByName(getQualifiedClassName(sourceObj)) as Class;
					objSibling = new classOfSourceObj();
				}
				
				catch(e:Object) {}
				
				return objSibling;
			}
			return null;
		}
		
		
		
		
		
		/**copies data from commonly named properties and getter/setter pairs*/
		public static function copyData(source:Object, destination:Object):void
		{
			if((source) && (destination))
			{
				try {
					var sourceInfo:XML = describeType(source);
					var prop:XML;
					
					for each(prop in sourceInfo.variable) {
						
						if(destination.hasOwnProperty(prop.@name)) {
							destination[prop.@name] = source[prop.@name];
						}
						
					}
					
					for each(prop in sourceInfo.accessor) {
						if(prop.@access == "readwrite") {
							if(destination.hasOwnProperty(prop.@name)) {
								destination[prop.@name] = source[prop.@name];
							}
							
						}
					}
				}
				catch (err:Object) {
					;
				}
			}
		}
		
		
		/** <p>Copying the Data of and Object into Class<p/>
		 * 
		 * @param data - Data that needs to be inserted to class
		 * @param destination - Class that needs to be filled
		 *  
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function copyDataClass(data:Object, destination:Object):void
		{
			if(data)
			{
				var att:Object = ObjectUtil.getClassInfo(data);
				
				for each(var qn:QName in att.properties) 
				{
					destination[qn.localName] = ObjectUtil.copy(data[qn.localName]);
				}
			}
		}
		
		
		
		
		
		
		
		
	}
}