package com.alborzsoft.web.facebook.types
{
	import com.alborzsoft.database.dataTypes.Person;
	import com.alborzsoft.date.TimeConvertor;

	public class FB_StatusText
	{
	//======================== VARRIABLES ==========================
		/** ID of Post */
		public var id:String;
		
		/** information of creator of this post */
		public var from:FB_Person;
		
		/** persons that can see this post*/
		public var to:Vector.<FB_Person>;
		
		/** Actions of this post that are avalible <br>Like Comments or Likes, etc. */
		public var actions:Vector.<FB_Action>;
		
		/** Message of this post<br>this is not avalible for Videos or Photos*/
		public var message:String;
		
		
		/** Likes of this post*/
		public var likes:Vector.<FB_Person>;
		
		/** count of Likes of this post*/
		public var likes_count:uint = 0;
		
		/** Comments of This Post*/
		public var comments:Vector.<FB_Comment>;
		
		/** Counts of Comments of This Post*/
		public var comments_count:uint = 0;
		
		public var privacy:FB_Privacy;
		
		
		/**When this Post is created*/
		public var created_time:Date;
		
		/**When this Post is Updated*/
		public var updated_time:Date;

		
		
		
	//======================== METHODS ==========================
		/** <p>Text Status of Facebook user<p/>
		 * 
		 * @param obj - Object value of returned Status Object from FacebookDesktop Class
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function FB_StatusText(obj:Object=null)
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
				message = obj.message;
				
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
		
		
		public function get type():String 
		{
			return FB_Status.STATUS;
		}
	}
}