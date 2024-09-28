package com.alborzsoft.web.currencey
{
	import com.alborzsoft.date.PersianDate;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.web.currencey.types.MesghalResult;
	import com.alborzsoft.web.currencey.types.MesghalStatistics;
	import com.alborzsoft.web.currencey.types.Money;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import spark.globalization.StringTools;
	
	
	//=============================== EVENTS ========================================
	/** Event for Reteriving the User's view Statistics*/
	[Event(name="id3 ", type="flash.events.Event")] 
	
	/** When Data is Received */
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	
	public class Mesghal extends EventDispatcher
	{
	//=============================== CONSTANTS ========================================
		//http://tala.ir/webservice/price_live.php?domain=tala.ir
		//http://tala.ir/fullprice.php
		
		
		private const WEBSITE:String = 'http://alborzsoft.com/00/mdata/';
		private const URL_MONEY:String = WEBSITE + 'json_money.php';
		private const URL_STATISTICS:String = WEBSITE + 'json_statistics.php';
		
		
	//=============================== VARRIABLES ========================================
		/**Exchange Rate of Melli Bank*/
		[Bindable] public var ER_Bank:MesghalResult;
		
		/**Exchange Rate of Markets*/
		[Bindable] public var ER_Market:MesghalResult;
		
		/**User's View Statistics*/
		[Bindable] public var user_statistics:MesghalStatistics;
		
		
		
	//=============================== METHODS ========================================
		public function Mesghal()
		{
			load();
		}
		
		
		/** <p>Loading Data From Server<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function load():void
		{
			var loader:URLLoader = new URLLoader(new URLRequest(URL_MONEY));
			loader.addEventListener(Event.COMPLETE, onResult);
			loader.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
			loader.addEventListener(IOErrorEvent.IO_ERROR,  dispatchEvent);
		}
		
		
		/** <p>Loading User's view Statistics Information From Server<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function loadUserStatistics():void
		{
			var loader:URLLoader = new URLLoader(new URLRequest(URL_STATISTICS));
			loader.addEventListener(Event.COMPLETE, onResultStatistics);
		}
		
		
		
		/** when main data loaded */
		private function onResult(event:Event):void
		{
			ER_Bank = new MesghalResult;
			ER_Market = new MesghalResult;
			
			
			var jsonData:Object = JSON.parse(event.currentTarget.data as String);
			
			// getting date
			var date:Object = jsonData[0];
			ER_Bank.update_date = getPD(date['dateBank']);
			ER_Market.update_date = getPD(date['dateMarket']);
			
			// clearing the date data
			jsonData.reverse();
			jsonData.pop();
			
			// foring the data
			for each(var obj:Object in  jsonData)
			{					
				var money:Money = new Money;
				money.sellValue = obj[1];
				money.buyValue = obj[2];	
				money.is_bank = (obj[3] == '1') ? true : false;
				money.code = obj[5];
				
				if(obj[3] == 1){  // if its Bank
					ER_Bank.result.push(money);
					money.sellValue = obj[1];
					money.buyValue = obj[2];	
				}
				else {
					ER_Market.result.push(money);
					money.sellValue = obj[1]*10;
					money.buyValue = obj[2]*10;	
				}
				
				money.title = StrUtils.decodeUnicode(obj[4]);
			}
			
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		/** when User's Statistics data loaded */
		private function onResultStatistics(event:Event):void
		{
			var jsonData:Object = JSON.parse(event.currentTarget.data as String);
			
			if(jsonData)
			{
				user_statistics = new MesghalStatistics;
				user_statistics.totalView			= jsonData.t;
				user_statistics.totalViewToday		= jsonData.tt;
				user_statistics.totalViewUser		= jsonData.tu;
				user_statistics.totalViewUserToday	= jsonData.ttu;
			}
			
			dispatchEvent(new Event(Event.ID3));
		}
		
		
		
		private function getPD(strDate:String):PersianDate
		{
			var year:int	= 1300 + int(strDate.substr(0, 2));
			var month:int	= int(strDate.substr(3, 2));
			var day:int		= int(strDate.substr(6, 2));
			var hours:int	= int(strDate.substr(9, 2));
			var minutes:int	= int(strDate.substr(12, 2));
			
			return new PersianDate(year, month, day, hours, minutes);
		}
		
	}
}