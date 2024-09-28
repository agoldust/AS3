package com.alborzsoft.UI
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.engine.TextLine;
	
	import mx.charts.chartClasses.BoundedValue;
	import mx.core.mx_internal;
	
	import spark.components.RichText;
	import spark.primitives.Rect;
	import spark.utils.TextFlowUtil;
	
	public class TextOnCircle extends RichText
	{
		
		
		/**
		 *  The radius of the circle used as the path for the text.
		 *  The text is placed outside of the circle with the letter base tangent to the circle.
		 *  @default 200
		 *
		 **/
		private var _radius:Number = 200;
		public function get radius():Number
		{
			return _radius;
		}
		
		public function set radius(value:Number):void
		{
			_radius = value;
			invalidateDisplayList();
		}
		
		/**
		 *  The angle in radians that is left blank before starting the text.
		 *  @default 0
		 *
		 **/
		
		private var _startAngle:Number = 0;
		public function get startAngle():Number
		{
			return _startAngle;
		}
		
		public function set startAngle(value:Number):void
		{
			_startAngle = value;
			invalidateDisplayList();
		}
		
		/**
		 *  Represents the length of the arc in pixels that is left blank before placing the text.
		 *  This adds to the blank space defined by the startAngle.
		 *  @default 0
		 *
		 **/
		private var _startOffset:Number = 0;
		public function get startOffset():Number
		{
			return _startOffset;
		}
		
		public function set startOffset(value:Number):void
		{
			_startOffset = value;
			invalidateDisplayList();
		}
		
		/**
		 *  Text that is displayed.
		 * 	HTML text is not supported.
		 * 
		 **/
		private var _text:String;
		override public function get text():String {
			return _text;
		}
		
		override public function set text(value:String):void {
			_text = value;
			xmltext = convertToTextFlow(text);
			textFlow = TextFlowUtil.importFromXML(new XML(xmltext));
		}
		
		private var xmltext:String;
		
		protected function convertToTextFlow(str:String):String {
			var textFlowString:String = "<?xml version='1.0' encoding='utf-8'?><flow:TextFlow xmlns:flow='http://ns.adobe.com/textLayout/2008'>";
			
			if(str) {
				var letters:Array = str.split("");
				for (var i:int = 0; i < letters.length; i++) {
					textFlowString += "<flow:p><flow:span>";
					textFlowString += letters[i];
					textFlowString += "</flow:span></flow:p>";
				}
			}
			
			textFlowString += "</flow:TextFlow>";
			return textFlowString;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var angle:Number = startAngle*Math.PI/180 + startOffset/radius;
			graphics.clear();
			var line:TextLine, atomBounds:flash.geom.Rectangle;
			var letterW:Number, letterH:Number, arcAngle:Number;
			var dx:Number, dy:Number, ddx:Number, ddy:Number;
			for (var i:int = 0; i < mx_internal::textLines.length; i++) {
				line = mx_internal::textLines[i] as TextLine;
				atomBounds = line.getAtomBounds(0);
				letterW = atomBounds.width;
				letterH = atomBounds.height;
				
				arcAngle = letterW/radius;
				angle+= arcAngle/2;
				dx = Math.cos(angle) * radius;
				dy = Math.sin(angle) * radius;
				ddx = Math.sin(angle)*letterW/2;
				ddy = Math.cos(angle)*letterW/2;
				line.x = dx+ddx;
				line.y = dy-ddy;
				line.rotation = (Math.PI/2+angle)*180/Math.PI;
				
				angle+= arcAngle/2;
			}
			
		}
	}
}