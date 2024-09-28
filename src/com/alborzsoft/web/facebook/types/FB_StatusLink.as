package com.alborzsoft.web.facebook.types
{
	import com.alborzsoft.date.TimeConvertor;

	public class FB_StatusLink extends FB_StatusText
	{
		/** name of the Application*/
		public var name:String;
		
		/** Caption */
		public var caption:String;
		
		/** Description */
		public var description:String;
		
		/** Application Information of this Link*/
		public var application:FB_Application;
		
		/** URL of this the post of this Link */
		public var link:String;
		
		/** URL of Logo*/
		public var picture:String;
		
		/** URL of Icon that is Related to this link*/
		public var icon:String;
		

		/** <p>Link Status of Facebook user<p/>
		 * 
		 * @param obj - Object value of returned Status Object from FacebookDesktop Class
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function FB_StatusLink(obj:Object)
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
				caption = obj.caption;
				description = obj.description;

				message = obj.message;
				
				from = new FB_Person(obj.from.id, obj.from.name);
				
				created_time = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(obj.created_time);
				updated_time = TimeConvertor.YYYYMMDD_HHMMSS__2__Date(obj.updated_time);
				
				
				if(obj.privacy)
					privacy = new FB_Privacy(obj.privacy.description, obj.privacy.value);
				
				if(obj.application)
					application = new FB_Application(obj.application.id, obj.application.name, obj.application.canvas_name, obj.application.namespace);
				
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
					if(!comments){
						comments = new Vector.<FB_Comment>; 
						comments_count = obj.comments.count;
					}
					
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
						likes_count = obj.likes.count;
						likes = new Vector.<FB_Person>; 
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
		
		
		override public function get type():String 
		{
			return FB_Status.LINK;
		}
	}
}