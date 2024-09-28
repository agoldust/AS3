package com.alborzsoft.web.shoutcast.types
{
	import com.alborzsoft.database.dataTypes.Comment;
	import com.alborzsoft.database.dataTypes.User;

	[Bindable]
	public class ShoutcastStationFavorite extends ShoutcastStation
	{
		/** Favorite ID of user on Database*/
		public var fav_id:uint;
		
		/** User that is Favorited the Station */
		public var user_id:uint;
		
		/**Favorite Status of this station that will be changed by user*/
		public var isFavorited:Boolean;
		
		/**determins the Favorite date*/
		public var timestamp:Date;
		
		/** Comments*/
		public var comments:Vector.<Comment>;

		
		public function ShoutcastStationFavorite(sc:ShoutcastStation=null)
		{
			super();
			
			
			if(sc) {
				this.id = sc.id;
				this.br = sc.br;
				this.ct = sc.ct;
				this.genre = sc.genre;
				this.lc = sc.lc;
				this.mt = sc.mt;
				this.name = sc.name;				
			}
		}
		
	}
}