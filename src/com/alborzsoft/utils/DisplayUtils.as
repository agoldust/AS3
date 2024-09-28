package com.alborzsoft.utils
{
	import com.alborzsoft.io.print.PaperSize2;
	import com.flashdynamix.motion.Tweensy;
	
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	
	import org.hamcrest.mxml.object.Null;
	
	import spark.components.ComboBox;

	public class DisplayUtils
	{
		public function DisplayUtils()
		{
		}
		
		
		/** <p>Showing or Hididin an Object<p/>
		 * 
		 * @param object - DisplayObject
		 * @param show - if true, it will show the Object - true default
		 * @param transitionTime - number of Transitioning time - 0.5 default
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function showObj(object:Object, show:Boolean=true, transitionTime:Number=0.5, delay:Number=0):void
		{
			if(show)
			{
				object.visible = true;
				Tweensy.to(object, {alpha:1, visible:true}, transitionTime, null, delay);
			}
			else {
				Tweensy.to(object, {alpha:0.01, visible:false}, transitionTime, null, delay);
			}
		}
		
		
		
		
		
		/** <p>Showing or Hididin an Object<p/>
		 * 
		 * @param dis - DisplayObject that will be scale to Parent
		 * @param parentWidth - Width of Parent
		 * @param parentHeight - Height of Parent
		 * @param paperSize - name of the size of Paper
		 * @param isPortrate - if true
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function scaleToParet(dis:DisplayObject, parentWidth:Number, parentHeight:Number, paperSize:String='A4', isPortrate:Boolean=true):void
		{
			var scaleH:Number = parentHeight / dis.height;
			var scaleW:Number = parentWidth / dis.width;
			
			
			// chaning the child's width and height
			dis.width  = PaperSize2.getSize(paperSize, isPortrate).width;
			dis.height = PaperSize2.getSize(paperSize, isPortrate).height;
			
			
			// when height is more than it's parent on Landscape mode
			if(scaleW * dis.height > parentHeight) scaleW = scaleH;
			
			
			// when width is more than it's parent on portrate mode
			if(scaleH * dis.width > parentWidth) scaleH = scaleW;
			
			
			
			// chanign the scaleX and scale Y of Child
			dis.scaleX = dis.scaleY = (isPortrate) ? scaleH : scaleW;
		}
		
		
		
		
		
		/** <p>Expanding and UnExpanding width of a ComboBox from minWidth and maxWidth  when Focuse Event accured<br>
		 *  minWidth and maxWidth have to be set for functioning properly<p/>
		 * 
		 * @param cbo - ComboBox
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function expandComboBox(cbo:ComboBox):void
		{
			cbo.addEventListener(FocusEvent.FOCUS_IN,	function():void{ Tweensy.to(cbo, {width: cbo.maxWidth}) });
			cbo.addEventListener(FocusEvent.FOCUS_OUT,	function():void{ Tweensy.to(cbo, {width: cbo.minWidth}) });
		}
		
		
		
		
		
		
	}
}





























