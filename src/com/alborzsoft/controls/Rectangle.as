package com.alborzsoft.controls
{
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.graphics.Stroke;
	
	import spark.primitives.Rect;
	
	
	// Icon of Compontn
	[IconFile("Rectangle.png")]
	
	
	/**
	 *  The background color of the application. This color is used as the stage color for the
	 *  application and the background color for the HTML embed tag.
	 *   
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]
	
	
	
	public class Rectangle extends Rect
	{
	//=========================== VARRIABLES ================================
		//------ PRIVATE
		private var _color:uint = 0x000000;
		
	//=========================== METHODS ================================
		public function Rectangle()
		{
			super();
			
			
			color = _color;
		}
		
		
		/** <p>The default corner radius to use for the <b>x</b> and <b>y</b> axis on all corners.  
		 * The topLeftRadiusX, topRightRadiusX, bottomLeftRadiusX, and bottomRightRadiusX and topRightRadiusY, 
		 * bottomLeftRadiusY, and bottomRightRadiusYproperties take precedence over this property<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function set radius(value:Number):void 
		{
			super.radiusX = super.radiusY = value;
		}
		
		
		/** <p>Color of Rectangle<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function set color(color:uint):void
		{
			_color = color;
			
			this.fill = new SolidColor(color);
		}
		public function get color():uint 
		{
			return _color;
		}
		
		
		
		/** <p>Enabling or Disabling the Stroke of rectangle - Default is false<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function set strokeEnable(value:Boolean):void 
		{
			if(value)
			{
				super.stroke = new Stroke;
				super.stroke.weight = 1;
			}
			else {
				super.stroke = null;
			}
		}
		
		
		
		/** <p>The line weight, in pixels. For many chart lines, the default value is 1 pixel<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function set strokeWeight(value:Number):void 
		{
			if(super.stroke == null) super.stroke = new Stroke;
			
			super.stroke.weight = value;
		}
		
		/** <p>The line weight, in pixels. For many chart lines, the default value is 1 pixel<p/>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function set strokeColorAlpha(arr:Array):void 
		{
			super.stroke = new Stroke(arr[0], super.stroke.weight, arr[1]);
		}
		
		
		
		
		
		
		/** <p>Length of the diagonal of a rectangle<p/>
		 * 
		 * @return Number of Lenght of Diagonal
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function get diagonal():Number 
		{
			return Math.sqrt((width*width) + (height*height));
		}
		
		
		
		
		/** <p>Setting All Left, Top, Right, Bottom properties<p/>
		 * 
		 * @param value - Number
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public function set LRTB(value:Number):void
		{
			super.left = super.top = super.right = super.bottom = value;
		}
		
	}
}