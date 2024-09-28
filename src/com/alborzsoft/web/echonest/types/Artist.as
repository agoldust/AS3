package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;
	
	import mx.collections.ArrayCollection;
	
	dynamic public class Artist
	{
		/**id of Artis From Echo Nest Database*/
		public var id:String;
		
		/**Name of Artist*/
		public var name:String;
		
		
		
		/**up to the 15 most recent biographies found on the web related to the artist*/
		public var biographies:Object;
		
		/**up to the 15 most recent blogs found on the web related to the artist*/
		public var blogs:Object;
		
		/**document counts for each of the various artist document types*/
		public var doc_counts:Object;
		
		/**the familiarity for the artist*/
		public var familiarity:Object;
		
		/**the hotttnesss for the artist*/
		public var hotttnesss:Object;
		
		/**up to the 15 most recent images found on the web related to the artist*/
		public var images:Object;
		
		/**information about the location of origin for the artist*/
		public var artist_location:Object;
		
		/**up to the 15 most recent news articles found on the web related to the artist*/
		public var news:Object;
		
		/**up to the 15 most recent reviews found on the web related to the artist*/
		public var reviews:Object;
		
		/**up to the 15 hotttest songs for the artist*/
		public var songs:Object;
		
		/**links to this artist's pages on various sites*/
		public var urls:Object;
		
		/**up to the 15 most recent videos found on the web related to the artist*/
		public var video:Object;
		
		/**years active information for the artist*/
		public var years_active:Object;
		
		/**catalog specific information about the artist for the given catalog. See Project Rosetta Stone for details.*/
		public var id_rosettaCatalog:Object;
		
		/**ersonal catalog specific information about the artist for the given catalog. See Project Rosetta Stone for details.*/
		public var id_tasteProfileID:Object;
		
		
		
		public static const BKT_DOC_COUNTS:String		= 'doc_counts';
		
		public static const BKT_FAMILIARITY:String		= 'familiarity';
		public static const BKT_YEARS_ACTIVE:String		= 'years_active';
		public static const BKT_ARTIST_LOCATION:String	= 'artist_location';
		
		public static const BKT_IMAGES:String			= 'images';
		public static const BKT_VIDEO:String			= 'video';
		public static const BKT_SONGS:String			= 'songs';
		
		public static const BKT_REVIEWS:String			= 'reviews';
		public static const BKT_BIOGRAPHIES:String		= 'biographies';

		public static const BKT_NEWS:String				= 'news';
		public static const BKT_BLOGS:String			= 'blogs';
		public static const BKT_URLS:String				= 'urls';


		
		[Bindable] public var loadedImages:ArrayCollection	= new ArrayCollection;
		[Bindable] public var loadedVideos:ArrayCollection	= new ArrayCollection;
		[Bindable] public var loadedBlogs:ArrayCollection	= new ArrayCollection;
		[Bindable] public var loadedNews:ArrayCollection	= new ArrayCollection;
		[Bindable] public var loadedSongs:ArrayCollection	= new ArrayCollection;
		[Bindable] public var loadedBio:ArrayCollection		= new ArrayCollection;
		[Bindable] public var loadedReviews:ArrayCollection	= new ArrayCollection;

		
		
		public function Artist(data:Object=null)
		{
			Util.copyDataClass(data, this);
		}
		
		
		
		
		public static function get bukets_small():Array 
		{
			return [];
		}
		
		public static function get bukets_all():Array 
		{
			return [Artist.BKT_DOC_COUNTS, 
					Artist.BKT_FAMILIARITY, Artist.BKT_YEARS_ACTIVE, Artist.BKT_ARTIST_LOCATION, 
					Artist.BKT_IMAGES, Artist.BKT_VIDEO, Artist.BKT_SONGS,
					Artist.BKT_REVIEWS, Artist.BKT_BIOGRAPHIES,
					Artist.BKT_NEWS, Artist.BKT_BLOGS, BKT_URLS];
		}
		
		/**making buket value to bucket parameter*/
		public static function val(str:String):String
		{
			return '&bucket=' + str;
		}
		
	
		
		
		
		
		
		
		
	}
}