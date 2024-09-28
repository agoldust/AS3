package com.alborzsoft.UI.XMLUI
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.xml.XMLNode;
	
	import mx.containers.Canvas;
	import mx.controls.Image;

	public class XMLUI_Creator
	{
		/**=========================== VARRIABLES ============================**/
		private var data:XML;
		
		
		
		/**=========================== FUNCTIONS ============================**/
		// Constructor and loads XML file
		public function XMLUI_Creator()
		{
		}
		
		// format the XMl data
		public function set xml(xml:XML):void
		{
			data = new XML;
			
			if(xml == null) err_xml_null(1);
			data = xml;
		}
		
		
		// will get UI Canvas Component
		public function get canvas():MovieClip
		{
			// error throw
			if(data == null) err_xml_null(2);
			
			// set the var's
			var mc:MovieClip = new MovieClip;
			
			
			// make TextBox's the UI's
			var xmlL:XMLList = data.TextBoxs.*;
			
			for each(var xml:XML in xmlL)
				mc.addChild(makeTextField(xml));
			
			
			/* make TextBox's the UI's
			xmlL = data.Images.*;
			
			for each(var xml2:XML in xmlL)
				mc.addChild(makeImage(xml2));
			*/
			
			
			return mc;
		}
		
		
		// making Text Fields
		private function makeTextField(xml:XML):TextField
		{
			var tf:TextField = new TextField();
			
			tf.x = Number(xml.@x);
			tf.y = Number(xml.@y);
			tf.width = Number(xml.@width);
			tf.height = Number(xml.@height);
			tf.htmlText = xml.toString()			
			
			return tf
		}
		
		
		/* making Text Fields
		private function makeImage(xml:XML):Image
		{
			var img:Image = new Image();
			
			img.autoLoad = true;
			img.x = Number(xml.@x);
			img.y = Number(xml.@y);
			img.width = Number(xml.@width);
			img.height = Number(xml.@height);
			img.source = xml.@source.toString();
			
			return img
		}
		*/
		
		
		
		// Error Throw Function
		private function err_xml_null(num:int):void
		{
			if(num==1) throw new Error("XMLUI: xml is Null, set the XML prpoperty");
			if(num==2) throw new Error("XMLUI: set the XML prpoperty first");
		}
		
		
		
		
		
	}
}