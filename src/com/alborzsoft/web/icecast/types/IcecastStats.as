package com.alborzsoft.web.icecast.types
{
	/**<p>Icecast Stat Class for Storing all data of Admin Information of Icecast server</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Apr 29, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 1.5, Flash 10
	 */
	
	public class IcecastStats
	{
	//=========================== PROPERTIES ==========================
		public var admin:String;
		public var host:String;
		public var location:String;
		public var server_id:String;
		public var server_start:String;
		
		public var listeners:int;
		public var listener_connections:int;
		
		public var clients:int;
		public var connections:int;
		public var client_connections:int;
		public var source_client_connections:int;
		public var source_relay_connections:int;
		public var source_total_connections:int;
		
		public var sources:int;
		public var stats:int;
		public var stats_connections:int;
		
		
		public var stations:Vector.<IcecastStation>;
		
		
		
		
	//=========================== METHODS ==========================
		public function IcecastStats(xml:XML)
		{
			source(xml);
		}
		
		
		/** <p>Setting the Information of Admin Stats information of Icecast Server<p/>
		 * 
		 * @param xml - XML value of Admin Stats of Icecast server
		 * 
		 * @langversion 3.0
		 * @playerversion AIR 1.5, Flash 10
		 */
		public function source(xml:XML):void 
		{
			//~~~~~~~~~~ adding main Information
			admin = xml.admin;
			host  = xml.host;
			location = xml.location;
			server_id = xml.server_id;
			server_start = xml.server_start;
			
			listeners = xml.listeners;
			listener_connections = xml.listener_connections;
			
			clients = xml.clients;
			connections = xml.connections;
			client_connections = xml.client_connections;
			source_client_connections = xml.source_client_connections;
			source_relay_connections = xml.source_relay_connections;
			source_total_connections = xml.source_total_connections;
			
			sources = xml.sources;
			stats = xml.stats;
			stats_connections = xml.stats_connections;
			
			
			
			//~~~~~~~~~~ adding Stations Information
			stations = new Vector.<IcecastStation>;
			
			for each(var xml2:XML in xml.source)
			{
				var ai:AudioInfo = new AudioInfo;
				var st:IcecastStation = new IcecastStation;
				
				//making Audio Info
				ai.bitrate = xml2.child("ice-bitrate");
				ai.channels = xml2.child("ice-channels");
				ai.samplerate = xml2.child("ice-samplerate");
				
				st.audio_info = ai;
				st.mount = xml2.@mount;
				st.genre = xml2.genre;
				st.peakListeners = xml2.listener_peak;
				st.currentListeners = xml2.listeners;
				st.location = xml2.listenurl;
				st.max_listeners = (xml2.max_listeners == 'unlimited') ? 0 : xml2.max_listeners;
				
				st.name = xml2.server_name;
				st.type = xml2.server_type;
				st.server_url = xml2.server_url;
				st.description = xml2.server_description;
				st.isPublic = (xml2.public == '0') ? false : true;
				
				st.slow_listeners = xml2.slow_listeners;
				st.source_ip = xml2.source_ip;
				st.stream_start = xml2.stream_start;
				st.title = xml2.title;
				
				st.total_bytes_read = xml2.total_bytes_read;
				st.total_bytes_sent = xml2.total_bytes_read;
				st.currentlyPlayingTitle = xml2.yp_currently_playing;
				
				stations.push(st);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}