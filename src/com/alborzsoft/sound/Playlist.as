package com.alborzsoft.sound
{
	import com.alborzsoft.sound.types.PLS_Type;
	import com.alborzsoft.utils.StrUtils;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class Playlist
	{
		public const PLS:String = 'pls';
		public const M3U:String = 'm3u';
		public const MMS:String = 'mms';
		
		
		public function Playlist()
		{
		}
		
		
		/** Converts String of Shoutcast PLS Playelist file to ArrayCollection
		 * @param str - String Content of PLS file (Shoutcast PLS)
		 * @return ArrayCollection - a list of {url, title, length} of Stations
		 */
		public function PLS_to_AC(str:String):ArrayCollection
		{
			//=========== defining the Number of Entries of this Radio Station
			var boSTA:int = str.search(new RegExp('=')) + 1;		// get the Begining index of Number of Entries
			var eoSTA:int = str.search(new RegExp('File'))			// get the Ending   index of Number of Entries
			var numberOfEntries:int = int(str.slice(boSTA, eoSTA));	// set the Number of Entries
			
			
			//=========== removing the beggining abd ending additional Tags
			var eoADI:int = str.search(new RegExp('Version='));	// Begining index of List of Enteries
			var boADI:int = str.search(new RegExp('File'));		// Ending   index of List of Enteries
			str = str.slice(boADI, eoADI)
			
			
			
			//=========== slicing Entries
			var beginIndex:int = 0;
			var strTemp:String = str;
			var Enteries:Array = new Array();
			
			
			for(var i:int=0; i<numberOfEntries; i++)
			{
				var boSTT:int	 = strTemp.search(new RegExp('File'));				// Begining index of URL
				var eoSTT:int	 = strTemp.search(new RegExp('Length')) + 6 + 4 ;	// Ending   index of URL
				var slice:String = strTemp.slice(boSTT, eoSTT);						// Make Slice of Each Enteries
				strTemp			 = strTemp.slice(eoSTT, strTemp.length);			// cut out that slice
				Enteries.push(slice);												// set the URL on an Array
			}
			
			
			
			//getting the URL and TITLE and STATUS of Radio Stations
			var enteries:ArrayCollection = new ArrayCollection();
			
			for each(var string:String in Enteries)
			{
				//--------getting the URL
				var boURL:int  = string.search(new RegExp('http://'));		// Begining index of URL
				var eoURL:int  = string.search(new RegExp('Title'));		// Ending   index of URL
				var url:String = string.slice(boURL, eoURL);				// set the URL
				url = StrUtils.replaceAll(url, '\n', '');
				
				
				//--------getting the TITLE
				var boTIT:int    = string.search(new RegExp('[)] ')) + 2;	// Begining index of URL
				var eoTIT:int    = string.search(new RegExp('Length'));		// Ending   index of URL
				var title:String = string.slice(boTIT, eoTIT);
				
				//--------getting the STATUS - how many is online/total
				var boSTU:int		= string.search(new RegExp(' - ')) + 3;	// Begining index of URL
				var eoSTU:int		= string.search(new RegExp('[)]'));		// Ending   index of URL
				var status:String	= string.slice(boSTU, eoSTU);
				
				var bsSTU:int		= status.search(new RegExp('[/]'));		// finding Slash '/'
				var Online:int		= int(status.slice(0, bsSTU));
				var Total:int		= int(status.slice(bsSTU+1, status.length));
				var state:Array		= new Array(Online, Total);
				
				
				//--------ading information into ArrayCollection
				enteries.addItem(new PLS_Type(url, title, state));
			}
			
			return enteries; // returning the Data with ArrayCollection type
		}


		
		/** Converts String of PLS Playelist file to ArrayCollection - Vrsion 2
		 * @param str - String Content of PLS file
		 * @return ArrayCollection - a list of {url, title, length} of Stations
		 */
		public function PLSv2_to_AC(str:String):ArrayCollection
		{
			var EOF:String = '';
			var numberOfEntries:int = int(str.charAt(27));
			
			//=========== removing the beggining of file
			str = str.slice(28, str.length)
			
			//=========== removing the beggining of file
			var endSlice:int = str.search(new RegExp('Version'));
			str = str.slice(0, endSlice-1)
			
			
			
			//=========== slicing Entries
			var beginIndex:int = 0;
			var string:String = '';
			var arr:Array = new Array();
			var arrTemp:Array = new Array();
			
			
			arr = str.split("\nFile");
			
			
			for (var i:int=1; i<arr.length; i++)
			{
				string = arr[i];
				arrTemp.push(string.slice(2, string.length));											// set the URL on an Array
			}
			arr = arrTemp;
			
			
			
			//getting the URL and TITLE and STATUS of Radio Stations
			var enteries:ArrayCollection = new ArrayCollection();
			
			for each(string in arr)
			{
				//--------getting the URL
				var eoURL:int  = string.search(new RegExp('Title'));		// Ending   index of URL
				var url:String = (eoURL != -1) ? string.slice(0, eoURL-1) : string;	// set the URL
				
				//--------getting the TITLE
				var eoTIT:int    = string.search(new RegExp('Length'));		// Ending   index of URL
				var title:String = string.slice(eoURL+7, eoTIT-1);
				
				//--------getting the TITLE
				var lenth:String = string.slice(eoTIT, string.length-1);
				
				//--------ading information into ArrayCollection
				enteries.addItem({url:url, title:title, length:lenth});
			}
			
			return enteries; // returning the Data with ArrayCollection type
		}
		
		
		
		
		/** Converts String of M3U Playelist file to ArrayCollection
		 * @param str - String Content of M3U file
		 * @return ArrayCollection - a list of {url, title} of Stations
		 */
		public function M3U_to_AC(str:String):ArrayCollection
		{
			//--------getting the URL
			var enteries:ArrayCollection = new ArrayCollection();
			
			
			//=========== removing the beggining abd ending additional Tags
			var boURL:int;
			var url:String;
			var arr:Array = new Array;
			
			arr = str.split("#EXTINF:");
			
			
			
			for(var i:int=1; i<arr.length; i++)
			{
				boURL = arr[i].search(new RegExp('http://'));// Begining index of URL
				url   = arr[i].slice(boURL, str.length-1);
				
				enteries.addItem({url:url,  title:'No Title'});
			}
			
			
			return enteries; // returning the Data with ArrayCollection type
		}
		
		
		
		
		
	}
}