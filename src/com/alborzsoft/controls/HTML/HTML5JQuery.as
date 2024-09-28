package com.alborzsoft.controls.HTML
{
	/**<p>HTML with More contorl on Content and events of Content</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Oct 2, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion AIR 3.0
	 */
	
	import com.alborzsoft.controls.HTML.events.HTMLEvents;
	import com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent;
	import com.alborzsoft.controls.HTML.events.HTMLMouseEvent;
	import com.alborzsoft.controls.HTML.events.HTMLNativeMenuEvent;
	import com.alborzsoft.controls.HTML.events.JSEvents;
	import com.alborzsoft.controls.HTML.types.HTML_A;
	import com.alborzsoft.controls.HTML.types.HTML_IMG;
	import com.alborzsoft.controls.HTML.types.HTML_LINK;
	import com.alborzsoft.controls.HTML.types.Keyboard;
	import com.alborzsoft.utils.StringUtils;
	import com.flashdynamix.motion.Tweensy;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.controls.HTML;
	import mx.controls.Menu;
	import mx.controls.ToolTip;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Label;
	import spark.events.TextOperationEvent;
	
	
	
	
	[IconFile("HTML5JQuery.png")]
	
	
	
//========================================= EVENTS =============================================
	[Event(name="titleChanged",	type="com.alborzsoft.controls.HTML.events.HTMLEvents")]

	//-------------- IMAGE EVENTS
	[Event(name="imageClick",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageDoubleClick",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseDown",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseMove",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseOut",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseOver",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="imageMouseUp",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	
	[Event(name="imageKeyUp",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	[Event(name="imageKeyDown",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	
	[Event(name="imageNewTab",		type="com.alborzsoft.controls.HTML.events.HTMLNativeMenuEvent")]

	
	
	//---------------- LINK EVENTS
	[Event(name="linkClick",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkDoubleClick",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseDown",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseMove",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseOut",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseOver",	type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	[Event(name="linkMouseUp",		type="com.alborzsoft.controls.HTML.events.HTMLMouseEvent")]
	
	[Event(name="linkKeyUp",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	[Event(name="linkKeyDown",		type="com.alborzsoft.controls.HTML.events.HTMLKeyboardEvent")]
	
	[Event(name="linkNewTab",		type="com.alborzsoft.controls.HTML.events.HTMLNativeMenuEvent")]
	
	
	
	//---------------- JAVASCRIPT EVENTS
	[Event(name="jquery_added",		type="com.alborzsoft.controls.HTML.events.JSEvents")]
	[Event(name="hilitor_added",	type="com.alborzsoft.controls.HTML.events.JSEvents")]

	
	
	
	
	[Bindable]
	public class HTML5JQuery extends HTML
	{
		
		
		
		
//=============================== VARRIABLES =================================
		//-------------- Embeded --------------
		[Embed(source="com/alborzsoft/controls/HTML/jquery-1.7.2.min.js", mimeType="application/octet-stream")]
		private var JQ:Class;
		
		[Embed(source="com/alborzsoft/controls/HTML/hilitor.min.js", mimeType="application/octet-stream")]
		private var Hilitor2:Class;
		
		
		//-------------- PUBLIC --------------
		/** JQuery string v1.6.4 **/
		public var JQueryString:String = String(new JQ());
		
		/** Hilitor 2 - HTF-8 **/
		public var HilitorString:String = String(new Hilitor2());
		
		/** Images of loaded web page */
		public var rss:Vector.<HTML_LINK>;
		
		/** Images of loaded web page */
		public var images:Vector.<HTML_IMG>;
		
		/** Links of loaded web page */
		public var links:Vector.<HTML_A>;
		
		private var _title:String = 'New Tab';
		
		/** URL of loading web page */
		public var url:String = '';
		
		/** URL of loading web page */
		public var showImageTooltip:Boolean = false;
		
		/** delay of showing the toolitip of Images - Default = 0.5 */
		public var showImageTooltipDelay:Number = 0;
		
		/** URL of loading web page */
		public var showLinkTooltip:Boolean = false;
		
		/** delay of showing the toolitip of Links - Default = 1 */
		public var showLinkTooltipDelay:Number = 0;
		
		/** Offset of Runtime Objects like Tooltip or NaviveMenu */
		public var offset:Point = new Point(0,0);
		
		/** shift key satate */
		public var keybord:Keyboard = new Keyboard(null);

		
		
		//-------------- PRIVATE --------------
		private var search:SearchBar;

		private var tooltip:ToolTip = new ToolTip;
		private var locationText:Label = new Label;
		
		protected var currentLink:HTML_A; // current link that mouse is over that
		protected var currentImage:HTML_IMG; // current Image that mouse is over that
		
		private var _loadJQuery:Boolean;
		private var _searchEnabled:Boolean = true;
		
		
		
		
		
		
		
	//=============================== METHODS =================================
		public function HTML5JQuery(JQueryString:String='')
		{
			if(JQueryString.length) 
				this.JQueryString = JQueryString;
			
			
			// HTML events
			this.addEventListener(Event.COMPLETE, onLoadedPage);
			this.addEventListener(Event.HTML_DOM_INITIALIZE, domInitialize);
			this.addEventListener(Event.ACTIVATE, addTooltip);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			// Image Events
			this.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_OUT,  imageMouseOut);
			this.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_OVER, imageMouseOver);
			
			// Link Events
			this.addEventListener(HTMLMouseEvent.LINK_MOUSE_OUT,    linkMouseOut);
			this.addEventListener(HTMLMouseEvent.LINK_CLICK,	    linkClick);
			this.addEventListener(HTMLMouseEvent.LINK_MOUSE_OVER,   linkMouseOver);
			this.addEventListener(MouseEvent.RIGHT_CLICK, 			pageRightClick);

			
			// page events
			super.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			super.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowm);
			
			
			
			//pre settings
			this.percentWidth = 100;
			this.percentHeight = 100;
		}
		
		
		
		/** Title of loading web page */
		public function get title():String
		{
			return _title;
		}
		public function set title(value:String):void
		{
			_title = value;
			dispatchEvent(new HTMLEvents(HTMLEvents.TITLE_CHANGED));
		}
		

		/** the visiblity of Vertical Scroll Bar */
		public function get isVScrollBarVisible():Boolean 
		{
			return (super.verticalScrollBar == null || super.verticalScrollBar.visible == false) ? false : true;
		}
		
		/** the visiblity of Horizontal Scroll Bar */
		public function get isHScrollBarVisible():Boolean 
		{
			return (super.horizontalScrollBar == null || super.horizontalScrollBar.visible == false) ? false : true;
		}
		
		
		/** Label that will be shown on tabbar*/
		public function get labelDisplay():String 
		{
			return (title == null || title == '') ? '(Untitled)' : title;
		}
		
		/**if true, it will load jQuery into HTML*/
		public function set loadJQuery(value:Boolean):void 
		{
			_loadJQuery = value;
		}
		
		/**If true, when user press Ctrl+F, it will show search Box*/
		public function set searchEnabled(enabled:Boolean):void
		{
			_searchEnabled = enabled;
		}
		
		
		protected function linkClick(event:HTMLMouseEvent):void
		{
			if(keybord.ctrlKey || event.target2.target == '_blank')
			{
				var t:Timer = new Timer(50, 80);
				t.addEventListener(TimerEvent.TIMER, function():void {
					cancelLoad();
					trace('cancel load!!');  //this.domWindow.WebKitTransitionEvent.prototype.preventDefault();
				});
				t.start();
				
				//dispatchEvent(new HTMLNativeMenuEvent(HTMLNativeMenuEvent.LINK_NEW_TAB, event.target2));
				/*
				$("a").removeAttr('href');
				
				EDIT-
				
				From your updated code:
				
				var location= $('#link1').attr("href");
				$("#link1").removeAttr('href');
				$('ul').addClass('expanded');
				$('ul.expanded').fadeIn(300);
				$("#link1").attr("href", location);

				*/
			}
			
			
			// hiding the link location
			linkMouseOut(null); 
		}
		
		
		
		
		
		/** Adding JQuery and Events to page */
		protected function domInitialize(event:Event):void
		{
			// inject jQuery into the web page
			var timer:Timer = new Timer(500);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, function():void
			{
				if(document)
				if(document.getElementsByTagName("head"))
				if(new Array(document.getElementsByTagName("head")).length)
					if(document.head != null && document.body != null)
					{
						// stopping the timer
						timer.stop(); 
						
						
						// gettim the HEAD and BODY elements
						var head:Object = document.getElementsByTagName("head")[0];
						var body:Object = document.getElementsByTagName("body")[0];
						
						// if is null get directly
						if(head == null) head = document.head;
						if(body == null) body = document.body;
						
						//getting URL and title
						var new_URL:String = body.ownerDocument.URL;
						var new_title:String = body.ownerDocument.title;
						
						
						// adding JQuery to Head of Web page, if not exists
						addJQuery();
						addHilitor();
						
						
						// setting the title value
						if(new Array(document.getElementsByTagName("body")).length)
						{
							if(title != new_title || url != new_URL)
							{
								url = new_URL;
								title = new_title;
							}
						}
						
						timer.stop();
					}
			}
				
			);
			
		}
		
		
		
		/**getting document element*/
		override public function get document():Object
		{
			if(htmlLoader)
			if(htmlLoader.window)
			if(htmlLoader.window.document)
				return this.htmlLoader.window.document;
			
			return super.document;
		}
		
		
		/**true, if page has Hilitor loaded in it*/
		public function get headerLoaded():Boolean 
		{
			if(document.head == null) 
				return false;
			
			return true;
		}
		
		
		
		
		
		/** adding Tag's events and inserting Tag Events and JQuery to loaded page*/
		protected function onLoadedPage(event:Event):void
		{
			if(addJQuery() == false) return;
			
			
			// getting te RSS links application/rss+xml
			rss = new Vector.<HTML_LINK>
			var arrRSS:Object = this.domWindow.$("*").find("link");
			
			for(var k:int=0; k<arrRSS.length; ++k)
			{
				var link:HTML_LINK = new HTML_LINK(this.domWindow.$(arrRSS[k]));
				
				if(link.type == HTML_LINK.RSS_TYPE) 
					rss.push(link);
			}
			
			
			// getting IMG tags and adding events to them
			images = new Vector.<HTML_IMG>;
			var arrIMG:Object = this.domWindow.$("*").find("img");
			
			for(var i:int=0; i<arrIMG.length; ++i)
			{
				var image:HTML_IMG = new HTML_IMG(this.domWindow.$(arrIMG[i]));
				images.push(image);
				
				
				image.addEventListener(HTMLMouseEvent.IMAGE_CLICK, 		 function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_CLICK,			event.target))});
				image.addEventListener(HTMLMouseEvent.IMAGE_DOUBLE_CLICK,function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_DOUBLE_CLICK,	event.target))});
				image.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_DOWN,	 function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_DOWN,		event.target))});
				image.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_MOVE,	 function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_MOVE,		event.target))});
				image.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_OUT,	 function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_OUT,		event.target))});
				image.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_OVER,	 function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_OVER,		event.target))});
				image.addEventListener(HTMLMouseEvent.IMAGE_MOUSE_UP,	 function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.IMAGE_MOUSE_UP,		event.target))});
				
				image.addEventListener(HTMLKeyboardEvent.IMAGE_KEY_DOWN ,function(event:Event):void { dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.IMAGE_KEY_DOWN,	event.target))});
				image.addEventListener(HTMLKeyboardEvent.IMAGE_KEY_UP,	 function(event:Event):void { dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.IMAGE_KEY_UP,	event.target))});
				image.addEventListener(HTMLKeyboardEvent.IMAGE_KEY_PRESS,function(event:Event):void { dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.IMAGE_KEY_PRESS,event.target))});
			}
			
			
			
			// getting IMG tags and adding events to them
			links = new Vector.<HTML_A>;
			var arrLinks:Object = this.domWindow.$("*").find("a");
			
			for(var j:int=0; j<arrLinks.length; ++j)
			{
				var a:HTML_A = new HTML_A(this.domWindow.$(arrLinks[j]))
				links.push(a);
				
				
				a.addEventListener(HTMLMouseEvent.LINK_CLICK,		function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_CLICK,		event.target))});
				a.addEventListener(HTMLMouseEvent.LINK_DOUBLE_CLICK,function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_DOUBLE_CLICK,	event.target))});
				a.addEventListener(HTMLMouseEvent.LINK_MOUSE_DOWN,	function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_DOWN,	event.target))});
				a.addEventListener(HTMLMouseEvent.LINK_MOUSE_MOVE,	function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_MOVE,	event.target))});
				a.addEventListener(HTMLMouseEvent.LINK_MOUSE_OUT,	function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_OUT,	event.target))});
				a.addEventListener(HTMLMouseEvent.LINK_MOUSE_OVER,	function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_OVER,	event.target))});
				a.addEventListener(HTMLMouseEvent.LINK_MOUSE_UP,	function(event:Event):void { dispatchEvent(new HTMLMouseEvent(HTMLMouseEvent.LINK_MOUSE_UP,		event.target))});
				
				a.addEventListener(HTMLKeyboardEvent.LINK_KEY_DOWN,	function(event:Event):void { dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.LINK_KEY_DOWN,	event.target))});
				a.addEventListener(HTMLKeyboardEvent.LINK_KEY_UP,	function(event:Event):void { dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.LINK_KEY_UP,		event.target))});
				a.addEventListener(HTMLKeyboardEvent.LINK_KEY_PRESS,function(event:Event):void { dispatchEvent(new HTMLKeyboardEvent(HTMLKeyboardEvent.LINK_KEY_PRESS,	event.target))});
			}
			
			
			
			
			// adding events for showing Tooltip on IMG and A tags
			
			
			trace('HTML Load Completed!!');
		}
		
		
		
		
		
		/** Adding Tooltip and Location textbox to display list*/
		private function addTooltip(event:Event=null):void
		{
			// adding the Images tooltip
			tooltip.alpha = 0;
			if(root) PopUpManager.addPopUp(tooltip, root);
			
			
			// adding the location text Field
			locationText.alpha = 0;
			locationText.setStyle('color', 0x333333);
			locationText.setStyle('verticalAlign', 'middle');
			locationText.setStyle('backgroundAlpha', 0.9);
			locationText.setStyle('backgroundColor', 0xFFFFFF);
			locationText.setStyle('paddingLeft', 3);
			locationText.setStyle('paddingRight', 3);
			locationText.setStyle('paddingTop', 3);
			locationText.setStyle('lineHeight', 15);
			
			PopUpManager.addPopUp(locationText, this);
			//super.htmlLoader.parent.addChild(locationText);
		}
		
		
		/** Updating the location of tooltip and location object */
		private function onMouseMove(event:MouseEvent):void
		{
			// updating the place of Image Tooltip to mouse position
			tooltip.x = (event.stageX+tooltip.width > this.width) ? (event.stageX - tooltip.width - 2) : event.stageX;
			tooltip.y = (event.stageY<tooltip.height) ? (event.stageY+20) : (event.stageY - tooltip.height - 2);
			
			//Updating the place of Link Tooltip to buttom left pf screen
			locationText.x = event.stageX - mouseX + 1; //offset of Control Componentt
			locationText.y = this.height - locationText.height + (event.stageY - mouseY) - (isHScrollBarVisible ? 15 : 0);
			locationText.maxWidth = this.width;
		}
		
		
		/** showing the location TextField */
		protected function linkMouseOver(event:HTMLMouseEvent):void
		{
			// adding value to current Image varriable
			currentLink = event.target2 as HTML_A; 
			
			// showing that tooltip of that
			if(showLinkTooltip){
				var link:HTML_A = event.target2 as HTML_A;
				
				locationText.height = (StringUtils.hasText(link.title)) ? 36 : 18;
				
				if(StringUtils.hasText(link.location)){
					locationText.alpha = 0;
					locationText.visible = true;
					locationText.text = (link.title.length) ? (link.title + '\n' + link.location) : (link.location);
					Tweensy.to(locationText, {alpha:1}, 0.5, null, showLinkTooltipDelay);
				}
			}
		}
		
		
		
		/** showing the tooltip */
		protected function imageMouseOver(event:HTMLMouseEvent):void
		{
			// adding value to current Image varriable
			currentImage = event.target2 as HTML_IMG; 
			
			// showing that tooltip of that
			if(showImageTooltip){
				var alt:String = event.target2.alt;
				
				if(alt.length) {
					tooltip.alpha = 0;
					tooltip.text = alt;
					Tweensy.to(tooltip, {alpha:1}, 0.5, null, showImageTooltipDelay);
				}
			}
		}
		
		
		/** hiding the tooltip */
		protected function imageMouseOut(event:HTMLMouseEvent):void
		{
			// adding value to current Image varriable
			currentImage = null
			
			// hiding tooltip
			if(showImageTooltip)
				if(tooltip!=null)
					Tweensy.to(tooltip,{alpha:0});
		}
		
		/** hiding the location TextField */
		protected function linkMouseOut(event:HTMLMouseEvent):void
		{
			// removing value to current Image varriable
			currentLink = null
			
			// hiding tooltip
			if(showLinkTooltip)
				if(locationText!=null)
					Tweensy.to(locationText, {alpha:0}, 0.5, null, 0.5, null, function():void { locationText.visible=false});
		}
		
		
		/** Showing native floating menu on mouse */
		protected function pageRightClick(event:MouseEvent):void
		{
			var menu:NativeMenu = new NativeMenu;

			// right click on LINK
			if(currentLink) {
				var menuItem_L1:NativeMenuItem = new NativeMenuItem('Open Link in New Tab');
				menuItem_L1.addEventListener(Event.SELECT, function():void {
					dispatchEvent(new HTMLNativeMenuEvent(HTMLNativeMenuEvent.LINK_NEW_TAB, currentLink));
				});
				
				menu.addItem(menuItem_L1);
			}
			
			
			// right click on IMAGE
			/**
			 * todo - preventing main Native menu shows up
			 * 
			if(currentImage) {
				var menuItem_I1:NativeMenuItem = new NativeMenuItem('Open Image in New Tab');
				
				menu.addItem(menuItem_I1);
			}
			*/
			
			
			// showing the menu
			if(menu.numItems)
				menu.display(this.stage, event.stageX, event.stageY);


		}
		
		
		/** changing the shifKey mode */
		protected function onKeyDowm(event:KeyboardEvent):void
		{
			keybord = new Keyboard(event);
		}
		
		/** changing the shifKey mode */
		protected function onKeyUp(event:KeyboardEvent):void
		{
			keybord = new Keyboard(event);
			
			if(keybord.ctrlKey && keybord.keyCode == 70)
			{
				showSearchBar();
			}
		}
		
		
		
		
		
		
		
		//============================= JQuery FUNCTIONS ========================
		/**inject JQuery to Header of HTML
		 * @return Boolean - true if JQuery is added or avalible<br/> false if it can't add JQuery*/
		private function addJQuery():Boolean
		{
			if(!_loadJQuery || !headerLoaded)
				return false;
			
			// adding JQuery to Head of Web page
			if(hasJQuery == false){
				var jquery_script:Object = document.createElement("script");
				jquery_script.type = "text/javascript";
				jquery_script.innerText = JQueryString;
				
				document.getElementsByTagName("head")[0].appendChild(jquery_script);
				
				dispatchEvent(new JSEvents(JSEvents.JS_JQUERY_ADDED));
				trace('JQuery Added');
			}
			
			return true;
		}
		
		/**true, if page has JQuery loaded in it*/
		public function get hasJQuery():Boolean 
		{
			if(document.head == null) 
				return false;
			
			return this.htmlLoader.window.hasOwnProperty('jQuery');
		}
		
		
		
		
		//=============================== SEARCH FUNCTIONS ================================
		/**showing or hiding searchbar*/
		public function showSearchBar(show:Boolean=true):void
		{
			if(show)
			{
				//showing the Search Bar
				if(search == null){
					search = new SearchBar;
					updateSearchBarPosition();
					updateSearchNavButtons();
					
					this.addChild(search); // adding to screen
					this.addEventListener(ResizeEvent.RESIZE, updateSearchBarPosition); // resize event
					this.addEventListener(Event.HTML_RENDER, updateSearchBarPosition);
					
					
					// adding buttons event
					search.txi.addEventListener(TextOperationEvent.CHANGE, onKeywordChange);
					search.btn_next.addEventListener(MouseEvent.CLICK, search_next_result);
					search.btn_prev.addEventListener(MouseEvent.CLICK, search_prev_result);
					search.btn_close.addEventListener(MouseEvent.CLICK, search_close_result);
				}
				else {
					search.visible = true;
				}
				
				// focusing to searchbra
				search.txi.setFocus();
			}
			else{
				search.visible = false;
			}
		}
		
		// when search keyword changed
		protected function onKeywordChange(event:TextOperationEvent):void
		{
			searchKeyword(search.txi.text);
			
			// updating the result count text
			updateSearchResultCounts();
			
			// updating the buttons avablity
			updateSearchNavButtons();
		}
		
		/** updating the result count text*/
		private function updateSearchResultCounts():void
		{
			if(search.txi.text.length == 0){
				setSearchTotalLable('');
			}
			else {
				var str:String;
					
				if(search_total_matches <= 0) str = '0 of 0';
				else 						  str = (search_focused_index+1) + ' of ' + search_total_matches;
					
				
				var alert:Boolean = (search_total_matches == 0 && search_focused_index <= 0);
				
				setSearchTotalLable(str, alert);
			}
		}
		
		/**Updating the lable of total results*/
		private function setSearchTotalLable(text:String, alert:Boolean=false):void
		{
			search.lbl.text = text;
			search.lbl.setStyle('backgroundColor', (alert) ? 0xFF0000 : 0xFFFFFF); // setting background color
		}		
		
		
		
		
		/**Updating the Navigation Search panel*/
		private function updateSearchNavButtons():void
		{
			search.btn_next.enabled = search_has_next_focuse;
			search.btn_next.alpha = search_has_next_focuse ? 1 : 0.5;
			search.btn_next.source = search_has_next_focuse ? ass_btn_next : ass_btn_next_disabled;
			
			search.btn_prev.enabled = search_has_prev_focuse;
			search.btn_prev.alpha = search_has_prev_focuse ? 1 : 0.5;
			search.btn_prev.source = search_has_prev_focuse ? ass_btn_prev : ass_btn_prev_disabled;
		}
		
		
		/**Updating the y position of SearchBar*/
		private function updateSearchBarPosition(e:*=null):void
		{
			if(search.visible){
				search.x = this.width - search.width - 5;
			
				if(verticalScrollBar)
				if(verticalScrollBar.visible) 
					search.x -= 15;
			}
			
		}
		
		
		
		/**inject JQuery to Header of HTML
		 * @return Boolean - true if JQuery is added or avalible<br/> false if it can't add JQuery*/
		private function addHilitor():Boolean
		{
			if(!headerLoaded || !_searchEnabled)
				return false;
			
			// adding JQuery to Head of Web page
			if(hasHilitor == false){
				var hilitor_script:Object = document.createElement("script");
				hilitor_script.type = "text/javascript";
				hilitor_script.innerText = HilitorString;
				
				document.getElementsByTagName("head")[0].appendChild(hilitor_script);
				
				dispatchEvent(new JSEvents(JSEvents.JS_HILITOR_ADDED));
				trace('Hilitor Added');
			}
			
			return true;
		}
		
		/**true, if page has Hilitor loaded in it*/
		public function get hasHilitor():Boolean 
		{
			if(document.head == null) 
				return false;
			
			return this.htmlLoader.window.hasOwnProperty('Hilitor2');
		}
		
		
		/**Search an string in html page
		 * 
		 * @param keyword - search keyword
		 * @return int - number of results
		 */
		public function searchKeyword(keyword:String=''):uint
		{
			var count:uint = 0;
			search.txi.text = keyword; // updating the text
			
			if(hasHilitor) {
				count = this.domWindow.searchKey(keyword); // searching
				search_next_result(); // selecting the first result
			}
			
			return count;
		}
		
		/**Navigate to Next search Result*/
		private function search_next_result(e:*=null):void
		{
			if(hasHilitor)
				this.domWindow.doNav(1);
			
			updateSearchResultCounts()
			updateSearchNavButtons();
		}
		
		/**Navigate to Previuse search Result*/
		private function search_prev_result(e:*=null):void
		{
			if(hasHilitor)
				this.domWindow.doNav(-1);
			
			updateSearchResultCounts()
			updateSearchNavButtons()
		}
		
		/**Clearing the Search Result*/
		public function search_close_result(e:*=null):void
		{
			if(hasHilitor)
				this.domWindow.clearSearch();
			
			search.txi.text = '';
			setSearchTotalLable('');
			
			updateSearchNavButtons();
			
			// hiding the search panel
			showSearchBar(false);
		}
		
		
		/**Getting Total Matches of Search Query*/
		private function get search_total_matches():int
		{
			return hasHilitor ? this.domWindow.getTotalMatches() : -1;
		}
		
		/**Getting index of Focused Search Key*/
		private function get search_focused_index():int
		{
			return hasHilitor ? this.domWindow.matchIndex : -1;
		}
		
		
		/**True if can goto next search result*/
		private function get search_has_next_focuse():Boolean
		{
			return search_focused_index < search_total_matches-1;
		}
		
		/**True if can goto previuse search result*/
		private function get search_has_prev_focuse():Boolean
		{
			return search_focused_index > 0;
		}
		
		
	}
}