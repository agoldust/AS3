/**<p>ChatText for storing and making well formed textFlow data</p>
 * <p>Creatd By: Akbar Goldust</p>
 * <p>Last modification date: May 31, 2012</p>
 * 
 * @langversion 3.0
 * @playerversion Flash 10, AIR 1.5
 * @productversion Flex 4
 */
package com.alborzsoft.components.types
{
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	import com.alborzsoft.utils.Util;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	

	[Bindable]
	public class ChatText
	{
		/** Actual Text of Inserted Text */
		public var text:String;
		
		/** ID of person That Insetred the Text */
		public var person:PersonChat;
		
		
		/** Insertion Date of Text */
		public var timestamp:Date;
		
		/** style that is using for Styling the Username*/
		public var textStyle:TextStyle;
		
		/** style that is using for Styling the Text of Chat*/
		public var textStyleContent:TextStyle;
		
		/**Array of Smiles*/
		public var smiles:Vector.<Smile>;
		
		
		
		/** <p>Chat Text Class to Store each record of chat list<p/>
		 * 
		 * @param text - String of text
		 * @param personID - ID of Person
		 * @param timestamp - Date of insertion
		 * @param textStyle - style of the name
		 * @param textStyleContent - style of the text
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function ChatText(text:String, person:PersonChat, timestamp:Date, textStyle:TextStyle=null, textStyleContent:TextStyle=null, smiles:Vector.<Smile>=null)
		{
			this.text = text;
			this.person = person;
			this.timestamp = timestamp;
			
			
			if(textStyle == null) textStyle = new TextStyle;
			if(textStyleContent == null) textStyleContent = new TextStyle;
			
			this.textStyle = textStyle;
			this.textStyleContent = textStyleContent;
			
			this.smiles = smiles;
		}
		
		
		
		/** <p>Paragraph element of current version of Text<p/>*/
		public function get paragragh():ParagraphElement
		{
			var paragraph:ParagraphElement = new ParagraphElement;
			
			//adding shape before username
			if(person.mode) 
				paragraph.addChild(Util.clone(person.mode) as FlowElement);
			
			
			//adding username
			paragraph.addChild(PersonHTMLText());
			
			
			//adding text of chat
			for each (var fe:FlowElement in ContentHTMLText()) 
				paragraph.addChild(fe);
			
			
			return paragraph;
		}
		
		
		/** <p>Span Element of Content of Text of this Entery<p/>*/
		public function ContentHTMLText():Vector.<FlowElement> 
		{
			var vec:Vector.<FlowElement> = new Vector.<FlowElement>;
			
			
			// adding space in next and before id smiles
			for each (var s:Smile in smiles) 
			{
				text = StrUtils.replaceAll(text, s.indicator, ' ' + s.indicator + ' ');
			}
			
			
			
			
			text = StringUtils.removeExtraWhitespace(text);	// removing the extra white space
			var arr_text:Array = text.split(' ');			// slicing the Text
			
			
			for(var i:int=0; i<arr_text.length; i++) 
			{
				for each(var smile:Smile in smiles) 
				{
					if(arr_text[i] == smile.indicator){
						arr_text[i] = smile.image;
						break;
					}
				}
			}
			
			
			
			// stiching the sliced sentence til imageInlineGraphic
			var temp:String = '';
			var arr:Array = new Array;
			var imgAdded:Boolean = false;
			
			for each (var obj:Object in arr_text) 
			{
				if(obj.hasOwnProperty('actualWidth'))
				{
					vec.push(getSpanElement(temp + ' '));
					vec.push(Util.clone(obj));
					
					temp = ' ';
					imgAdded = true;
				}
				
				else{
					temp += (imgAdded ? '' : ' ') + obj.toString();
					imgAdded = false;
				}
			}
			
			
			// when there is no smiles in the text
			if(temp.length) vec.push(getSpanElement(temp));
			
			
			return vec;
		}
		
		
		/** <p>Span Element of Persons Name<p/>*/
		public function PersonHTMLText():SpanElement 
		{
			var span:SpanElement = new SpanElement;
			var space:String = person.mode ? ' ' : '';
			
			span.text = space + person.name + ':';
			span.color = textStyle.color;
			span.fontSize = textStyle.fontSize;
			span.fontFamily = textStyle.fontFamily;
			
			if(textStyle.isBold)	span.fontWeight = 'bold';
			if(textStyle.isItalic) span.fontStyle = 'italic';
			if(textStyle.isUnderline) span.textDecoration = 'underline';
			
			return span;
		}
		
		
		/** <p>Making Span Element<p/>
		 * 
		 * @param text - Text of Span Element
		 * @return SpanElement
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		private function getSpanElement(text:String):SpanElement
		{
			var span:SpanElement = new SpanElement;
			
			span.text = text;
			span.color = textStyleContent.color;
			span.fontSize = textStyleContent.fontSize;
			span.fontFamily = textStyleContent.fontFamily;
			
			if(textStyleContent.isBold)	span.fontWeight = 'bold';
			if(textStyleContent.isItalic) span.fontStyle = 'italic';
			if(textStyleContent.isUnderline) span.textDecoration = 'underline';
			
			return span;
		}
		
		
	}
}