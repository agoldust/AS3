package com.alborzsoft.web.shoutcast.types
{
	import com.alborzsoft.utils.StrUtils;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Shoutcast_Genre
	{
		public var id:int;
		public var haschildren:Boolean;
		public var parentID:int;
		
		public var children:ArrayCollection;
		public var isChildrenLoading:Boolean;
		public var icon:Class;
		
		private var _name:String;
		
		
		public function Shoutcast_Genre(id:int=-1, name:String='', haschildren:Boolean=false, parentID:int=0)
		{
			this.id = id;
			this.name = name;
			this.haschildren = haschildren;
			this.parentID = parentID;
		}

		
		/**Name of Genre*/
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = StrUtils.replaceHTMLSpecialEntities(value);;
		}

	}
}