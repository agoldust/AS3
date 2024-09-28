package com.alborzsoft.controls.TabBar {
	import com.alborzsoft.controls.TabBar.events.AddTabEvent;
	import com.alborzsoft.controls.TabBar.events.TerrificTabBarEvent;
	import com.alborzsoft.controls.TabBar.skins.TerrificTabBarSkin;
	import com.alborzsoft.utils.Util;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	
	import mx.collections.IList;
	import mx.containers.ViewStack;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	import mx.events.ResizeEvent;
	
	import spark.components.Group;
	import spark.components.TabBar;
	import spark.events.IndexChangeEvent;
	
	
	
	/**When New Tab Button Pressed*/
	[Event(name="addTab", type="com.alborzsoft.controls.TabBar.events.AddTabEvent")]
	
	
	/**When Component Resized*/
	[Event(name="resize", type="mx.events.ResizeEvent")]
	
	
	
	
	public class TerrificTabBar extends TabBar
	{
		public var btnmaxwidth:Number=0 ;
		public var btnminwidth:Number=0;
		public var totaltab:Number=0;
		public var Height:Number=0;
		public var Width:Number=0;
		public var addnewtabxpos:Number=0;
		public var imgicnwidth:Number=0;
		public var autoCloseWhenEmpty:Boolean=true;
		public var tabwidth:Number=0;
		public var addImageWidth:Number=0;
		public var tabsWidth:Number=0;
	
		[SkinPart(required="false")]
		public var img_addnewtab:Group;
		
		
		
		public function TerrificTabBar() 
		{
			super();
			// adding style
			super.setStyle('skinClass', TerrificTabBarSkin);
			super.setStyle('color', 0xEEEEEE);
			super.setStyle('fontSize', 10);
			
			//this.addEventListener(Event.ENTER_FRAME, setTabWidth);
			this.addEventListener(Event.CHANGE, tabBar_changeHandler);
			this.addEventListener(ResizeEvent.RESIZE, setTabWidth);
			
			//this.addEventListener(AddTabEvent.ADD_NEW_TAB, addNewTabhandler);
		}
		
		
		/** <p>Adding new Tab to the component<p/>
		 * 
		 * @param title - Titlte of Tab
		 * @param iconUrl - The URL, object, class or string name of a class to load as the content.
		 */
		public function addNewTab(title:String, iconUrl:Object=null):void
		{
			if(iconUrl)
			{
				// add tab with icon
				addTabItem(title,iconUrl as String); // make this to use object for showing icon on tabs, sometimes i just pass the data, like source of Image component
				callLater(add_TabHandler);
			}
			else 
			{
				//add tab without icon
				addTabItem(title,"");
				callLater(add_TabHandler);
			}
			
		}
		
		
		public function add_TabHandler():void
		{
			var totaltabwidth:Number=0;
			
			totaltab = dataGroup.numChildren;
			
			totaltabwidth = dataGroup.width + getTabBarButton(dataGroup.numChildren-1).width + img_addnewtab.width + 3
			
			if(  totaltabwidth < width){
				
				for(var i:int=0; i< totaltab ; i++){
					setTabBarButton(btnmaxwidth ,i);
					
					//Set selected tab's close button property visible= true;
					var object:* = dataGroup.dataProvider.getItemAt(i);
					
					if(!object.hasOwnProperty('icon'))
						setIconImage(i,false);
					
					setHeaderDisplay(i,true);
					setCloseableTab(i ,true);
				}
				
				callLater(setTabbar);
				
			}else{
				//resize tabbutton and add new tab
				
				//var xpos:Number = this.Width- ( img_addnewtab.width + 3 );//3 is gap between tabbutton and image
				var xpos:Number = parent.width - ( img_addnewtab.width + 3 );//3 is gap between tabbutton and image
				//addTabItem("New Tab","assets/icons/icon1.png");
				NewTabbar(xpos);
				//callLater(NewTabbar,[xpos]);
			}
		}
		
		
		private function NewTabbar(xpos:Number):void
		{
			// here 15 is the gap of tab button
			var totaltabwidth:Number = xpos+ ( ( totaltab - 1 ) * 15 )
			
			var newwidth:Number = totaltabwidth / totaltab; 
			
			if(newwidth<40)
			{
				var widthDiff:Number=  40 - newwidth;
				var newtabwidthdiff:Number = widthDiff/(totaltab-1);
				newwidth = newwidth-newtabwidthdiff;
			}
			if(newwidth>btnmaxwidth)
			{
				newwidth=btnmaxwidth;
				xpos = (btnmaxwidth * totaltab) - ((totaltab-1) *15);
			}
			/*for(var i:int=0;i<totaltab;i++)
			{
				if(i!= newIndex)
				{
					var tabs:TerrificTabBarButton = getTabBarButton(i);
					tabs.width = tabs.width - newtabwidthdiff;
				}
			}*/
			
			for(var i:int=0; i< totaltab ; i++){
				
			
				var object:* = dataGroup.dataProvider.getItemAt(i);
				
				 if(newwidth > 70 ){ // display icon and close buuton if tab size is gretaed then 70
					setCloseableTab(i,true);
					
					if(!object.hasOwnProperty('icon'))
						setIconImage(i,false);
					else
						setIconImage(i,true);
					setHeaderDisplay(i,true);
				}
				else if(newwidth <= 70 && newwidth >= 50)
				{
					setCloseableTab(i ,true);	// hide icon and close buuton if tab size is gretaed then 70
					if(!object.hasOwnProperty('icon'))
					{
						setIconImage(i,false);
						setHeaderDisplay(i,true);
					}
					else
					{
						setIconImage(i,true);
						setHeaderDisplay(i,false);
					}
					//setCloseButtonXPos(i,newwidth-24);
				}
				else
				{
					
					setCloseableTab(i ,false);	// hide icon and close buuton if tab size is gretaed then 70
					setIconImage(i,false);
					setHeaderDisplay(i,false);
				}
					
				if(newwidth>=40)
				{	
					setCloseButtonXPos(i,newwidth-24);//Here 24 is Padding Right
				}
				else
				{
					setCloseButtonXPos(i,(newwidth/2)-6);//set close button at the middle of tab
					
				}
				setTabBarButton(newwidth,i);
				
				
			}
			if(newwidth<=40)
				setTabBarButton(40,totaltab-1); // set tab size 40 for last added tab if tab size is smaller then 40
			selectedIndex = this.parentApplication.tabBar.dataProvider.length-1;
			tabwidth = newwidth;
			tabsWidth= newwidth;//Store Tabs Width For using it in change handler 
			
			//Set selected tab's close button property visible= true;
			setCloseableTab(selectedIndex ,true);
			
			//set x position of add new tab image
			img_addnewtab.x=xpos;
		}
		private function setTabbar():void{
			
			img_addnewtab.x = dataGroup.width;
			selectedIndex = this.parentApplication.tabBar.dataProvider.length-1;
		}
		
		
		//Add Item into Tab
		private function addTabItem(lbl:String,icn:String):void{
			
			dataGroup.dataProvider.addItem({label:lbl,icon:icn});
			totaltab +=1;
			
		}
		
		protected function tabBar_changeHandler(event:IndexChangeEvent):void
		{
			if(tabsWidth == 0) return;
			
			// TODO Auto-generated method stub
			var totaltabwidth:Number=0;
			
			totaltab = dataGroup.numChildren;
			
			
			var tb:TerrificTabBarButton = getTabBarButton(event.newIndex);
			var newwidth:Number = totaltabwidth / totaltab; 
			totaltabwidth = dataGroup.width + img_addnewtab.width + 3;
			var object:* = dataGroup.dataProvider.getItemAt(event.newIndex);
			
			if(tabsWidth <= 70 && tabsWidth >= 50) // 70 is max limit for display all image icon and label
			{
				setCloseableTab(event.oldIndex ,true);	// hide icon and close buuton if tab size is gretaed then 70
				setCloseableTab(event.newIndex ,true);
				setCloseButtonXPos(event.newIndex,tb.width-24);
			}
			else if(tabsWidth <= 50 && tabsWidth >= 40) // if less then 50 then hide label	
			{
				setCloseableTab(event.oldIndex ,false);
				setCloseableTab(event.newIndex ,true);
				setCloseButtonXPos(event.newIndex,tb.width-24);
			}
			else if(tabsWidth <= 40) // if less then 40 then everything
			{
				for(var i:int=0;i<totaltab;i++) // set all button with same size then set selected button size 40 
				{
					var tabs:TerrificTabBarButton = getTabBarButton(i);
					tabs.width = tb.width;
				}
				tb.width = 40; // Fix Width 40 for selected Tab id tab size is small
				setCloseableTab(event.oldIndex ,false);
				setCloseableTab(event.newIndex ,true);
				setCloseButtonXPos(event.newIndex,(tb.width/2)-6);
			}
			
			else // display all 3 component
			{
				setCloseableTab(event.oldIndex ,true);
				setCloseableTab(event.newIndex ,true);
				setCloseButtonXPos(event.newIndex,tb.width-24);
			}
			
		/*	if(tb.width>=40)
				setCloseButtonXPos(event.newIndex,tb.width-24); // Here 24 is padding of close button from right side
			else
				setCloseButtonXPos(event.newIndex,(tb.width/2)-6);*///If Tab size is not big then set close button in middle
			
			
			/*setIconImage(event.newIndex,true);
			setIconImage(event.oldIndex,false);*/
		}
		
		public function setSelectedTabWidth(newIndex:Number,tabWidth:Number):void{
			if(tabWidth!=tabsWidth)
			{
				for(var i:int=0;i<totaltab;i++)
				{
					var tabs:TerrificTabBarButton = getTabBarButton(i);
					tabs.width = tabsWidth;
					
				}
			}
			var widthDiff:Number=  40 - tabsWidth;
			var newtabwidthdiff:Number = widthDiff/(totaltab-1);
			for(var j:int=0;j<totaltab;j++)
			{
				if(j!= newIndex)
				{
					var tabs2:TerrificTabBarButton = getTabBarButton(j) as TerrificTabBarButton;
					tabs2.width = tabs2.width - newtabwidthdiff;
				}
			}
			
		}
		
		public function setTabWidth(e:*=null):void
		{
			if(dataGroup!=null && dataGroup.numChildren>0)
			{
				
				var totaltabwidth:Number=0;
				
				totaltab = dataGroup.numChildren;
				
				totaltabwidth = (totaltab * btnmaxwidth) - ( ( totaltab - 1 ) * 15 ) ;
				
				if( totaltabwidth < parent.width )
				{
					
					for(var i:int=0; i< totaltab ; i++)
					{
						setTabBarButton(btnmaxwidth,i);
						var object:* = dataGroup.dataProvider.getItemAt(i);
						//Set selected tab's close button property visible= true;
						setCloseableTab(i ,true);
						
						if(!object.hasOwnProperty('icon'))
							setIconImage(i,false);
						else
							setIconImage(i,true);
						
						setHeaderDisplay(i,true);
						setCloseButtonXPos(i,btnmaxwidth-24);//Here 24 is Padding Right
						
					}
					
					//set x position of add new tab image
					setAddNewTabXPOS(totaltabwidth);
					
				}else
					callLater(ResizeTabBar);
				
			}
		}
		
		
		public function ResizeTabBar():void{
			
				var tabwidth:Number =  (parent.width - 27) + ( ( totaltab - 1 ) * 15 ); // Here 27 is add new tab button's width and gap between tab button and image
				
				var newwidth:Number = tabwidth / totaltab;
				
				var addNewXPos:Number=0;
				
				if(newwidth>btnmaxwidth)
				{
					newwidth=btnmaxwidth;
					addNewXPos = (btnmaxwidth * totaltab) - ((totaltab-1) *15);
				}
				else
					addNewXPos = parent.width - 27
				tabsWidth= newwidth;
				
				for(var i:int=0; i< totaltab ; i++)
				{
					var object:Object=dataGroup.dataProvider.getItemAt(i);
					if(newwidth > 70 ){  // 70 is max limit for display all image icon and label
						setCloseableTab(i,true);
						if(!object.hasOwnProperty('icon'))
							setIconImage(i,false);
						else
							setIconImage(i,true);
						setHeaderDisplay(i,true);
						
					}
					else if(newwidth <= 70 && newwidth >= 50) // if less then 50 then hide label	
					{
						setCloseableTab(i ,true);	// hide icon and close buuton if tab size is gretaed then 70
						if(!object.hasOwnProperty('icon'))
						{
							setIconImage(i,false);
							setHeaderDisplay(i,true);
						}
						else
						{
							setIconImage(i,true);
							setHeaderDisplay(i,false);
						}
						//setCloseButtonXPos(i,newwidth-24);
					}
					else // Hide everythinf if size is small then 50
					{
						setCloseableTab(i ,false);	// hide icon and close buuton if tab size is gretaed then 70
						setIconImage(i,false);
						setHeaderDisplay(i,false);
					}
					
					if(newwidth>=40)// set close button in middle if size is 40 otherwise set at right side
					{	
						setCloseButtonXPos(i,newwidth-24);//Here 24 is Padding Right
						//setCloseButtonXPos(event.newIndex,(newwidth/2)+7);
						
					}	
					else
						setCloseButtonXPos(i,(newwidth/2)-6);
					
					setTabBarButton(newwidth,i);
				}
				
				setCloseableTab(this.parentApplication.tabBar.selectedIndex ,true);
				
				if(newwidth>=40)
					setCloseButtonXPos(this.parentApplication.tabBar.selectedIndex,newwidth-24);//Here 24 is Padding Right
				else
					setCloseButtonXPos(this.parentApplication.tabBar.selectedIndex,(newwidth/2)-6);//Set close button in middle
				
				if(newwidth < 40)//For set 40 width of selected Index
				{
					setSelectedTabWidth(this.selectedIndex,newwidth);
					setTabBarButton(40,selectedIndex);
					setCloseButtonXPos(this.parentApplication.tabBar.selectedIndex,14);//Set close button in middle
				}
				//Set selected tab's close button property visible= true;
				
				
				
				//set x position of add new tab image
				setAddNewTabXPOS(addNewXPos);
			}
	
		//Added by Dhwani - for setting icon image visible true/false
		public function setIconImage(index:int,val:Boolean):void{
			
			var tb:TerrificTabBarButton = getTabBarButton(index);
		
			if(tb) tb.IconVisible = val;
		}
		
		//Added by Dhwani - for getting icon image visible true/false
		public function getIconImage(index:int):Boolean{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) return tb.IconVisible;
			
			return false;
		}	
		
		//Added by Dhwani - for getting icon image visible true/false
		public function getHeaderDisplay(index:int):Boolean{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) return tb.HeaderVisible;
			
			return false;
		}
		public function setHeaderDisplay(index:int,val:Boolean):void{
			
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) tb.HeaderVisible = val;
		}
		
		
			
		public function setCloseButtonXPos(index:int,value:Number):void{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			if(tb) tb.closebtnX = value;
		}
		
		public function getCloseButtonXPos(index:int):Number{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			if(tb) return tb.closeButton.x;
			else
				return 0;
		}
		
		public function setCloseableTab(index:int, value:Boolean):void
		{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) tb.closeable = value;
		}
		
		
		public function getCloseableTab(index:int):Boolean
		{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) return tb.closeable;
			
			return false;
		}
		
		
		/**Setting Enablity of Tab Button bar*/
		public function setTabEnablity(index:int, value:Boolean):void
		{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) tb.enabled = value;
		}
		
		
		/**Setting Visiblity of Tab Button bar*/
		public function setTabVisiblity(index:int, value:Boolean):void
		{
			var tb:TerrificTabBarButton = getTabBarButton(index);
			
			if(tb) tb.visible = value;
		}
		
		
		/** <p>Getting Tab Bar Button Bar of a Tab<p/>
		 * 
		 * @param index - Index of Tab
		 * @return TerrificTabBarButton
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function getTabBarButton(index:int):TerrificTabBarButton
		{
			if (index >= 0 && index < dataGroup.numElements)
			{
				return dataGroup.getElementAt(index) as TerrificTabBarButton;
			}
			
			return null;
		}
		
		public function setAddNewTabXPOS(xpos:Number):void{
			var tb:TerrificTabBarSkin = this.skin as TerrificTabBarSkin;
			tb.img_addnewtab.x = xpos
			//addnewtabxpos = xpos;
		}
		
		public function getAddNewTabXPOS():Number{
			return addnewtabxpos;
		}
		
		public function setTabBarButton(w:Number,index:int):TerrificTabBarButton
		{
			
			var tb:TerrificTabBarButton = getTabBarButton(index);
			tb.width = w;
			
		
			return null;
		}
		
	
		private function closeHandler(e:TerrificTabBarEvent):void {
			closeTab(e.index, selectedIndex);
		}
		
		
		public function closeTab(closedTab:int, selectedTab:int):void
		{
			if(dataProvider.length==1 && selectedTab == 0 && autoCloseWhenEmpty==true)
			{
				//close the App
				NativeApplication.nativeApplication.exit();
			}
			else
			{	
				if (dataProvider.length == 0) return;
				
				
					 if(dataProvider is IList)		dataProvider.removeItemAt(closedTab);
				else if(dataProvider is ViewStack) (dataProvider as ViewStack).removeChildAt(closedTab); //remove the entire child from the dataProvider, which also removes it from the ViewStack
				
				
				//adjust selectedIndex appropriately
					 if (dataProvider.length == 0)
					 {
						 selectedIndex = -1;
						 //added by Kinjal for set add new button X position
						 img_addnewtab.x=10;
					 }
				else if (closedTab < selectedTab)	selectedIndex = selectedTab - 1;
				else if (closedTab == selectedTab)	selectedIndex = (selectedTab == 0 ? 0 : selectedTab - 1);
				else								selectedIndex = selectedTab;
					 
				//Added by Dhwani for setting tabs width	
				 setTabWidth();
			}
		}

		
		
		protected override function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);

			if(instance == dataGroup) 
				dataGroup.addEventListener(TerrificTabBarEvent.CLOSE_TAB, closeHandler);
		}

		protected override function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);

			if (instance == dataGroup)
				dataGroup.removeEventListener(TerrificTabBarEvent.CLOSE_TAB, closeHandler);
		}
		
		
		
	}
}