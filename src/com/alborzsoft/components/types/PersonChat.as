package com.alborzsoft.components.types
{
	import com.alborzsoft.database.dataTypes.Person;
	
	import flashx.textLayout.elements.InlineGraphicElement;

	
	public class PersonChat extends Person
	{
		/**Mode - an Image before username*/
		public var mode:InlineGraphicElement = null;
		
		
		/**Image of Avatar <br>
		 * it can be an String of URL of image file,  <br>
		 * Class of actual Image*/
		public var imageSource:Object = null;
		
		
		public function PersonChat(id:uint, name:String, mode:InlineGraphicElement=null)
		{
			super();
			
			super.id = id;
			super.name = name;
			this.mode = mode;
		}
	}
}