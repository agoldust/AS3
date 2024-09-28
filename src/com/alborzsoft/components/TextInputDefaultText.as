package com.alborzsoft.components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.events.FlexMouseEvent;
	import mx.styles.IStyleManager2;
	import mx.styles.StyleManager;
	
	import spark.components.RichEditableText;
	
	
	[Style(name="defaultTextColor", inherit="no", type="uint")]
	
	
	
	public class TextInputDefaultText extends RichEditableText
	{
		
	//=============== PUBLIC VARRIABLES =================
		public var defaultText:String = '';
		
		/** Default Color of text */
		public var color:uint;
		
		
		/** array of Ignored Strings that will be erased when a user clicks on that <br>
		 * like ['not found!','search']*/
		public var ignoredStrings:Array;
		
		
		
		public function TextInputDefaultText()
		{
			super();
			super.multiline = false;
			super.setStyle('focusThickness', 0);
			
			super.addEventListener(MouseEvent.CLICK, function():void{setTextIN()});
			super.addEventListener(FocusEvent.FOCUS_IN, setTextIN);
			super.addEventListener(FocusEvent.FOCUS_OUT, setTextOUT);
			super.addEventListener(Event.ADDED_TO_STAGE, function():void{setTextOUT()});
		}
		
		public function clear():void
		{
			if(text2.length > 0)
				text = '';
		}
		
		
		/** <p>Current Text<p/>*/
		public function get text2():String
		{
			if(super.text == defaultText)
				return '';
			
			return super.text;
		}
		
		
		//SET textInput to Default
		public function setTextInput():void
		{
			super.text = defaultText;
			super.setStyle('color', getStyle('defaultTextColor'));
			super.invalidateDisplayList();
		}
		
		
		
		public function get isDefaultText():Boolean 
		{
			// if current text is Default Text
			if(super.text == defaultText) return true;
			
			
			// if current text is one of ignored Texts
			for each(var str:String in ignoredStrings)
				if(super.text == str)
					return true
			
			
			return false;
		}
		
		
		/** make right color and text for this Control */
		private function setTextIN(event:FocusEvent=null):void
		{		
			// if current text is Default Text
			if(isDefaultText) super.text = '';
				
			super.setStyle('color', color);
		}
		
		
		private function setTextOUT(event:FocusEvent=null):void
		{
			if(text == '')
				setTextInput();
		}
		
		
		
	}
}