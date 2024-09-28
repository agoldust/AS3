package com.alborzsoft.web.facebook.types
{
	import com.alborzsoft.Math.Math2;
	import com.alborzsoft.date.TimeConvertor;
	import com.alborzsoft.utils.StrUtils;

	public class FB_StatusPhoto extends FB_StatusText
	{
	//======================== CONSTANTS ==========================
		public static const NORMAL:String = 'normal';
		public static const SQUARE:String = 'square';
		public static const SMALL:String = 'small';
		public static const LARGE:String = 'large';
		
	//======================== VARRIABLES ==========================
		/** ID of this Photo*/
		public var object_id:String;
		
		/** name of the Photo*/
		public var name:String;
		
		/** link to page of this Photo */
		public var link:String;
		
		/** URL  Thumbnail that is related to this photo */
		public var picture:String;
		
		/** URL of Icon that is Related to this Photo*/
		public var icon:String;
		
				
		
		
	//======================== METHODS ==========================
		/** <p>Photo Status of Facebook user<p/>
		 * 
		 * @param obj - Object value of returned Status Object from FacebookDesktop Class
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function FB_StatusPhoto(obj:Object=null)
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
		private function set data(obj:Object):void
		{
			if(obj) 
			{
				id = obj.id;
				link = obj.link;
				name = obj.name;
				icon = obj.icon;
				picture = obj.picture;
				object_id = obj.object_id;
				comments_count = obj.comments.count;
				
				from = new FB_Person(obj.from.id, obj.from.name);
				
				created_time = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(obj.created_time);
				updated_time = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(obj.updated_time);
				
				
				if(obj.privacy)
					privacy = new FB_Privacy(obj.privacy.description, obj.privacy.value);
				
				
				//-- Actions
				if(obj.actions)
				for each(var ob2:Object in obj.actions)
				{
					// construscting on the begining
					if(!actions) 
						actions = new Vector.<FB_Action>; 
					
					// adding to the array
					actions.push(new FB_Action(ob2.name, ob2.link));
				}
				
				
				//-- Comments
				if(obj.comments)
				for each(var ob3:Object in obj.comments.data)
				{
					// construscting on the begining
					if(!comments)
						comments = new Vector.<FB_Comment>; 
					
					// adding to the array
					var person:FB_Person = new FB_Person(ob3.from.id, ob3.from.name);
					var date:Date = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(ob3.created_time);
					
					comments.push(new FB_Comment(ob3.id, ob3.message, person, date)); 
				}
				
				
				//-- Likes
				if(obj.likes)
				for each(var ob4:Object in obj.likes.data)
				{
					// construscting on the begining
					if(!likes){
						likes = new Vector.<FB_Person>; 
						likes_count = obj.likes.count;
					}
					
					// adding to the array
					likes.push(new FB_Person(ob4.id, ob4.name)); 
				}
				
				
				//-- TO
				if(obj.to)
				for each(var ob5:Object in obj.to.data)
				{
					// construscting on the begining
					if(!to)
						to = new Vector.<FB_Person>
					
					// adding to the array
					to.push(new FB_Person(ob5.id, ob5.name)); 
				}
				
			}
		}
		
		
		/** <p>Getting Picture with Specific Size<p/>
		 * 
		 * @param width - uint of width of image
		 * @return String - the url of image with spacific size
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function pictureURL(width:uint=0):String 
		{
			// null if there is no image
			if(picture == null) 
				return null;
			
			// making the link
			var split:Array = picture.split('/');
			var fileName:String = split.pop();
			var base:String = 'http://a' + Math2.random(1, 7) + '.sphotos.ak.fbcdn.net/hphotos-ak-snc7';
			
			
			for(var i:uint=3; i<split.length-1; i++) 
				base += split[i];
			
			
			if(width)
				return base + '/s' + width + 'x' + width + '/' + fileName;
			
			
			return base + '/s/' + fileName;
		}
		
		
		override public function get type():String 
		{
			return FB_Status.PHOTO;
		}
	}
}