package com.alborzsoft.web.facebook.types
{
	import mx.collections.ArrayCollection;

	public class FB_Status
	{
	//======================== CONSTANTS ==========================
		public static const STATUS:String = 'status';
		public static const PHOTO:String = 'photo';
		public static const VIDEO:String = 'video';
		public static const LINK:String = 'link';
		public static const QUESTION:String = 'question';
		public static const APPROVED_FRIEND:String = 'approved_friend';
		
		
		public static const STATUS_TYPE__ADDED_PHOTOS:String = 'added_photos';
		public static const STATUS_TYPE__SHARED_STORY:String = 'shared_story';
		public static const STATUS_TYPE__TAGGED_IN_PHOTO:String = 'tagged_in_photo';
		public static const STATUS_TYPE__APP_CREATED_STORY:String = 'app_created_story';

		
		
		
	//======================== VARRIABLES ==========================
		[Bindable] public var statuses:ArrayCollection;
		
		
		
	//======================== METHODS ==========================
		/** <p>Facebook Status Class<p/>
		 * 
		 * @param obj - Object value of returned Object from FacebookDesktop Class
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function FB_Status(obj:Object=null)
		{
			if(obj) 
				this.data = obj;
		}
		
		
		
		/** <p>Setting this Class with Object data that is returned from FacebookDesktop Class<p/>
		 * 
		 * @param result - Object value of returned Object from FacebookDesktop Class
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		private function set data(result:Object):void
		{
			if(result)
			{
				statuses = new ArrayCollection;
				
				
				for each(var obj:Object in result)
				{
						 if(obj.type == FB_Status.STATUS) statuses.addItem(new FB_StatusText(obj));
					else if(obj.type == FB_Status.PHOTO)  statuses.addItem(new FB_StatusPhoto(obj));
					else if(obj.type == FB_Status.VIDEO)  statuses.addItem(new FB_StatusText(obj));
					else if(obj.type == FB_Status.LINK)   statuses.addItem(new FB_StatusLink(obj));
				}
				
				trace(statuses.length);
			}
		}
		
		
		
		/** count of Statuses */
		public function get count():int
		{
			return statuses.length;
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
}