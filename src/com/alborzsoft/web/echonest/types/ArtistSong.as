package com.alborzsoft.web.echonest.types
{
	import com.alborzsoft.utils.Util;
	
	import mx.utils.ObjectUtil;

	public class ArtistSong
	{
		public var id:String;
		public var title:String;
		
		public var artist_id:String;
		public var artist_name:String;
		public var artist_md5:String;
		
		public var artist_familiarity:Number;
		public var artist_hotttnesss:Number;
		public var artist_location:Object;
		public var artist_foreign_ids:Object;
		
		public var audio_md5:String;
		public var audio_summary:AudioSummary;
		
		public var song_hotttnesss:Number;
		public var song_type:Array;
		
		public var tracks:Array;
		
		
		
		
		public static const AUDIO_SUMMARY:String = 'audio_summary';
		public static const ARTIST_FAMILIARITY:String = 'artist_familiarity';
		public static const ARTIST_HOTTTNESSS:String = 'artist_hotttnesss';
		public static const ARTIST_LOCATION:String = 'artist_location';
		public static const SONG_HOTTTNESSS:String = 'song_hotttnesss';
		public static const SONG_TYPE:String = 'song_type';
		public static const TRACKS:String = 'tracks';
		
		
		public static const ROSETA_7DIGITAL:String	  = 'id:7digital';
		public static const ROSETA_7DIGITAL_AU:String = 'id:7digital-AU';
		public static const ROSETA_7DIGITAL_US:String = 'id:7digital-US';
		public static const ROSETA_7DIGITAL_UK:String = 'id:7digital-UK';
		
		
		public static const ROSETA_RDIO:String	  = 'id:rdio';
		public static const ROSETA_RDIO_US:String = 'id:rdio-US';
		public static const ROSETA_RDIO_UK:String = 'id:rdio-UK';
		public static const ROSETA_RDIO_AU:String = 'id:rdio-AU';
		public static const ROSETA_RDIO_SE:String = 'id:rdio-SE';
		public static const ROSETA_RDIO_PT:String = 'id:rdio-PT';
		public static const ROSETA_RDIO_NZ:String = 'id:rdio-NZ';
		public static const ROSETA_RDIO_NO:String = 'id:rdio-NO';
		public static const ROSETA_RDIO_NL:String = 'id:rdio-NL';
		public static const ROSETA_RDIO_IT:String = 'id:rdio-IT';
		public static const ROSETA_RDIO_IE:String = 'id:rdio-IE';
		public static const ROSETA_RDIO_FR:String = 'id:rdio-FR';
		public static const ROSETA_RDIO_FI:String = 'id:rdio-FI';
		public static const ROSETA_RDIO_ES:String = 'id:rdio-ES';
		public static const ROSETA_RDIO_DK:String = 'id:rdio-DK';
		public static const ROSETA_RDIO_DE:String = 'id:rdio-DE';
		public static const ROSETA_RDIO_CH:String = 'id:rdio-CH';
		public static const ROSETA_RDIO_CA:String = 'id:rdio-CA';
		public static const ROSETA_RDIO_BR:String = 'id:rdio-BR';
		public static const ROSETA_RDIO_AT:String = 'id:rdio-AT';
		
		
		public function ArtistSong(data:Object=null)
		{
			if(data)
			{
				var att:Object = ObjectUtil.getClassInfo(data);
				
				for each(var qn:QName in att.properties) 
				{
						 if(qn.localName == "artist_location")	this.artist_location = new Location(data.artist_location);
					else if(qn.localName == "audio_summary")	this.audio_summary   = new AudioSummary(data.audio_summary);
					
					else if(qn.localName == "tracks")
					{
						this.tracks = new Array;
						
						for each(var obj:Object in data.tracks) 
							this.tracks.push(new Track(obj));
					}
						 
					else
						this[qn.localName] = ObjectUtil.copy(data[qn.localName]);
				}
			}
		}
		
		
		
		public static function get bukets_all():Array 
		{
			return [ArtistSong.AUDIO_SUMMARY, ArtistSong.ARTIST_FAMILIARITY, ArtistSong.ARTIST_HOTTTNESSS, ArtistSong.ARTIST_LOCATION, 
					ArtistSong.SONG_HOTTTNESSS, ArtistSong.SONG_TYPE, ArtistSong.TRACKS, ArtistSong.ROSETA_7DIGITAL_AU, ArtistSong.ROSETA_RDIO_AU];
		}
		
		
		
		public function get song_types():String 
		{
			var str:String;
			
			for each (var type:String in song_type) 
			{
				if(str == null) str = type;
				else			str += ', ' + type;
			}
			
			return str;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}