/**<p>Smile for storing smiles data</p>
 * <p>Creatd By: Akbar Goldust</p>
 * <p>Last modification date: May 31, 2012</p>
 * 
 * @langversion 3.0
 * @playerversion Flash 10, AIR 1.5
 * @productversion Flex 4
 */
package com.alborzsoft.components.types
{
	import flashx.textLayout.elements.InlineGraphicElement;

	public class Smile
	{
		public var label:String;
		public var indicator:String;
		public var image:InlineGraphicElement;
		
		
		public function Smile(indicator:String, image:InlineGraphicElement, label:String='')
		{
			this.indicator = indicator;
			this.image = image;
			this.label = label;
		}
	}
}