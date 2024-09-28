package com.alborzsoft.components
{
	/**<p>TextAreaChat is a class to show the Chat List</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: May 23, 2012</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10, AIR 1.5
	 * @productversion Flex 4
	 */
	import com.alborzsoft.components.types.ChatText;
	import com.alborzsoft.components.types.PersonChat;
	import com.alborzsoft.components.types.Smile;
	import com.alborzsoft.components.types.TextStyle;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.IConfiguration;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.IconPlacement;
	import spark.components.TextArea;
	import spark.events.TextOperationEvent;
	import spark.utils.TextFlowUtil;
	
	
	
	
	public class TextAreaChat extends TextArea
	{
		
	//=============================== VAIRRIABELS ================================
		//------------- PUBLIC
		/**If true, that will scroll to last item of chat list*/
		public var autoScroll:Boolean = false
		
		/**List of Persons in the Chat*/
		public var persons:Vector.<PersonChat> = new Vector.<PersonChat>;
		
		/**List of styles that will be used for Formatting Name of User*/
		public var styles:Vector.<TextStyle> = new Vector.<TextStyle>;
		
		/**List of styles that will be used for formatting Text of User*/
		public var styles_content:Vector.<TextStyle> = new Vector.<TextStyle>;
		
		/**List of Smiles that will be used for formatting Text of User*/
		public var smiles:Vector.<Smile> = new Vector.<Smile>;
		
		
		
		
		/** List of Chat texts that can be bind to a List to show the Chat List*/
		[Bindable] public var chatList:ArrayCollection = new ArrayCollection;
		
		/** History of Chat texts (All Texts) */
		[Bindable] public var history:ArrayCollection = new ArrayCollection;
		
		
		
		
		
		//------------- PRIVATE
		private var _maxListItems:uint = 30;
		private var ts:TextStyle;
		private var ts2:TextStyle;
		

		private var currentEntery:uint = 0;
		
		
		
	//=============================== METHODS ================================
		public function TextAreaChat()
		{
			super();
			
			super.textFlow = new TextFlow;
		}
		

		
		
		
		/** <p>Chat Text Class to Store each record of chat list<p/>
		 * 
		 * @param text - String of text
		 * @param person - Person
		 * @param timestamp - Date of insertion
		 * @param textStyle - style of the name
		 * @param textStyleContent - style of the text
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function addText(text:String, personID:uint, timestamp:Date=null):void
		{
			// setting the date if that is not valued
			if(timestamp == null) timestamp = new Date; 
			
			var person:PersonChat = this.getPerson(personID);
			var style:TextStyle = this.getUserStyle(personID);
			var style_content:TextStyle = this.getUserStyleContent(personID);
			
			var chatText:ChatText = new ChatText(text, person, timestamp, style, style_content, smiles); // making Chat Text Var
			
			addText2TextFlow(chatText);
		}
		
		
		
		
		
		/** <p>adding text to TextArea<p/>
		 * 
		 * @param ct - ChatText
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function addText2TextFlow(ct:ChatText):void
		{
			if(currentEntery >= _maxListItems || history.length == 0)
			{
				super.textFlow.removeChildAt(0);
			}
			
			
			super.textFlow.addChild(ct.paragragh); 
			history.addItem(ct); // adding to history list
			currentEntery++;
			
			
			// scrolling to end
			if(autoScroll) scrollToEnd();
		}
		
		
		
		
		/** <p>Updating List of ChatText Items<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function updateTextList():void 
		{
			var c:uint = 0;
			var tf:TextFlow = new TextFlow();
			var arr:Array = new Array;
			
			// replicating the array of list
			for each(var ct:ChatText in history.source)  arr.push(ct);
			
			
			// making start Index
			var si:uint = (arr.length > _maxListItems) ? (arr.length - _maxListItems) : 0;
			
			
			// making the paragraph
			if(arr.length)
				for(var i:int=si; i<arr.length; i++) 
					tf.addChild(arr[i].paragragh); 
			
			
			// adding to display
			super.textFlow = tf;
		}
		
		
		
		/** <p>Scrolling to the end of vertical scrool bar<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function scrollToEnd():void
		{
			var t:Timer = new Timer(10, 3);
			t.start();
			
			t.addEventListener(TimerEvent.TIMER, function():void
			{
				if(scroller)
					scroller.verticalScrollBar.value = uint.MAX_VALUE;
			});
		}
		
		
		
		
		
		/** <p>Adding A Person to the Chat List with Style format<p/>
		 * 
		 * @param person - details of Person  (id and name is required)
		 * @param style - Text Style that will be shown in the chat area
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function addPerson(person:PersonChat, style:TextStyle, style_content:TextStyle):void
		{
			persons.push(person);
			styles.push(style);
			styles_content.push(style_content);
		}
		
		
		
		/** <p>Removing A Person from chat list<br/>
		 * notice: style of that person will be remove from styles peroperty<p/>
		 * 
		 * @param id - ID of user
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		private function removePerson(id:uint):void
		{
			for(var i:int=0; i<persons.length; i++) 
				if(id == persons[i].id) break;
			
			
			persons.splice(i, 1);
			styles.splice(i, 1);
		}
		
		
		
		/** <p>getting Person from chat list<br/>
		 * notice: style of that person will be remove from styles peroperty<p/>
		 * 
		 * @param id - ID of user
		 * @return Person - null if that not found any person
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		private function getPerson(id:uint):PersonChat
		{
			for each (var person:PersonChat in persons) 
				if(id == person.id)
					return person;
			
			return null;
		}
		
		
		
		/** <p>getting current Style of a Name of a user<br/>
		 * notice: style of that person will be remove from styles peroperty<p/>
		 * 
		 * @param id - ID of user
		 * @return TextStyle - style of Name of user <br/>null if that not found any person
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		private function getUserStyle(id:uint):TextStyle
		{			
			for(var i:int=0; i<persons.length; i++) {
				if(id == persons[i].id){
					return styles[i];
				}
			}			
			
			return null;
		}
		
		

		/** <p>getting current Style of a Text of a user<br/>
		 * notice: style of that person will be remove from styles peroperty<p/>
		 * 
		 * @param id - ID of user
		 * @return TextStyle - style of text of user <br/>null if that not found any person
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		private function getUserStyleContent(id:uint):TextStyle
		{			
			for(var i:int=0; i<persons.length; i++) {
				if(id == persons[i].id){
					return styles_content[i];
				}
			}			
			
			return null;
		}
		
		
		
		/** Maximum Number of Items that will be shown on the List*/
		public function set maxListItems(value:uint):void 
		{
			this._maxListItems = value;
			updateTextList();
		}
		public function get maxListItems():uint 
		{
			return this._maxListItems;
		}
		
		
		
	}
}