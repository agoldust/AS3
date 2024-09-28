import com.alborzsoft.date.PersianDate;
import com.alborzsoft.utils.StrUtils;

import flash.events.Event;

import mx.collections.ArrayList;
import mx.collections.IList;

import spark.events.IndexChangeEvent;
import spark.events.TextOperationEvent;

[Bindable] public var lable:String;
[Bindable] public var baseYear:uint = 1300;


private var year:ArrayList;
private var month:ArrayList;
private var day:ArrayList;



private var _date:Date;
private var _persianDate:PersianDate;


//========================== FUNCTIONS ==========================
public function initi():void
{
	// clear the prev-information
	clearData();
}


/** Date value*/
public function get date():Date
{
	return _date;
}
public function set date(date:Date):void
{
	_date = date;
}


/** <p>set the date of comboboxes<p/> */
public function get persianDate():PersianDate 
{
	//_persianDate = new PersianDate(int(comYear.selectedItem), int(comMonth.selectedItem), int(comDay.selectedItem));
	_persianDate = new PersianDate(nsYear.value, nsMonth.value, nsDay.value);
	return _persianDate;
}
public function set persianDate(pd:PersianDate):void 
{
	_persianDate = pd;
	
	if(_persianDate)
	{
		nsYear.value = _persianDate.year;
		nsMonth.value = _persianDate.month;
		nsDay.value = _persianDate.date;
	}
	else {
		clearData();
	}
	
	com_changeHandler();
}


// reset all data
public function clearData():void
{
	// set the date of today
	var pd:PersianDate = new PersianDate;
	persianDate = pd;
}



// change and Fix the Date data
public function com_changeHandler():void
{
	//var selectedDay:int   = comDay.selectedIndex;
	var selectedDay:int   = nsDay.value;
	var selectedYear:int  = nsYear.value;
	var selectedMonth:int = nsMonth.value;
	
	
	
	if(selectedMonth <= 6) {
		nsDay.maximum = 31;
	}
	else if(selectedMonth <= 11)
	{
		nsDay.maximum = 30;
		
		// fixing the selected external day issue 31 to 30
		if(selectedDay == 31) nsDay.value = 30;
	}
		
	else if(selectedMonth == 12){
		
		if(selectedYear != baseYear-1)
		{
			if(selectedYear%4 == 3) nsDay.value = 30; //addDays(30); // sale khabise 
			else{
				//addDays(29);
				nsDay.maximum = 29;
				if(selectedDay <= 30) nsDay.value = 29; //comDay.selectedIndex = 28;
			}	
		}
	}
	
	
	var pdate:PersianDate = new PersianDate(selectedYear, selectedMonth, selectedDay);
	date = pdate.julianDate;
	
	
	comDay_changeHandler(); // dispatching
}


// add days to Day ComboBox
/*
private function addDays(count:int):void
{
	comDay.dataProvider = new ArrayList;
	
	for(var i:int=1; i<=count; i++)
		comDay.dataProvider.addItem(StrUtils.fixedInteger(i, 2));
}*/

// dispatching change event
protected function comDay_changeHandler():void
{
	this.dispatchEvent(new Event('change'));
}
