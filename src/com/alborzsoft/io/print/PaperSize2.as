package com.alborzsoft.io.print
{
	import flash.geom.Rectangle;

	/**<p>This class provides the available values for the paperSize parameter of the PrintJob.selectPaperSize() method.
	 * Each constant represents a paper size that is used to print a page.</p></p>
	 * 
	 * <p>The following table shows the approximate size for each paper type.
	 * The size is approximate because there is some variation among printer drivers.
	 * For example, the width of A4 paper can be 595.0, 595.2, 595.22 or 595.28 points depending on the driver.</p></p>
	 * 
	 * 
	 * <table>
			  <tbody>
			    <tr>
			      <th>Value</th>
			      <th>Size in points</th>
			      <th>Size in Centimeters</th>
			      <th>Size in Inches</th>
			    </tr>
			    <tr>
			      <td>CARD1</td>
			      <td>184 x 269</td>
			      <td>6.5 x 9.5</td>
			      <td>2.55 x 3.74</td>
			    </tr>
			  </tbody>
			</table>
	 * 
	 * <p/>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: May 16, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Lite 4, Flash 9, AIR 1.0
	 */
	public class PaperSize2
	{
		
		
		//============================= CONSTS SIZES ==============================
		/** <P>small Visit Card size</P>
		 *  <table>
			  <tbody>
			    <tr>
			      <th>Value</th>
			      <th>Size in points</th>
			      <th>Size in Centimeters</th>
			      <th>Size in Inches</th>
			    </tr>
			    <tr>
			      <td>CARD1</td>
			      <td>184 x 269</td>
			      <td>6.5 x 9.5</td>
			      <td>2.55 x 3.74</td>
			    </tr>
			  </tbody>
			</table>
		 */
		public static const CARD1:String = '184 x 269';

		
		public static const DL:String = 'DL';
		public static const A6:String = 'A6';
		public static const A5:String = 'A5';
		public static const A4:String = 'A4';
		public static const A3:String = 'A3';
		public static const A2:String = 'A2';
		public static const A1:String = 'A1';
		public static const A0:String = 'A0';
		
		
		
		/** A0 Width in mm*/
		public static const A0_WIDTH:int = 841;
		/** A0 Height in mm*/
		public static const A0_HEIGHT:int = 1189;
		
		
		/** A1 Width in mm*/
		public static const A1_WIDTH:int = 594;
		/** A1 Height in mm*/
		public static const A1_HEIGHT:int = 841;
		
		
		/** A2 Width in mm*/
		public static const A2_WIDTH:int = 420;
		/** A2 Height in mm*/
		public static const A2_HEIGHT:int = 594;
		
		
		/** A3 Width in mm*/
		public static const A3_WIDTH:int = 297;
		/** A3 Height in mm*/
		public static const A3_HEIGHT:int = 420;
		
		
		/** A3+ Width in pixels*/
		public static const A3p_WIDTH_pixels:int = 935;
		/** A3+ Height in pixels*/
		public static const A3p_HEIGHT_pixels:int = 1369;
		
		
		
		
		
		
		/** A4 Width in mm*/
		public static const A4_WIDTH:int = 210;
		/** A4 Height in mm*/
		public static const A4_HEIGHT:int = 297;
		
		/** A4 Width in pixels*/
		public static const A4_WIDTH_pixels:int = 595;
		/** A4 Height in pixels*/
		public static const A4_HEIGHT_pixels:int = 842;
		
		
		
		
		/** A5 Width in mm*/
		public static const A5_WIDTH:int = 148;
		/** A5 Height in mm*/
		public static const A5_HEIGHT:int = 210;
		
		
		/** A6 Width in mm*/
		public static const A6_WIDTH:int = 105;
		/** A6 Height in mm*/
		public static const A6_HEIGHT:int = 148;
		
		
		/** DL Width in mm*/
		public static const DL_WIDTH:int = 210;
		/** DL Height in mm*/
		public static const DL_HEIGHT:int = 98;
		
		
		
		
		
		public function PaperSize2()
		{
		}
		
		
		
		/** <p>Getting the Width of A4 Paper Based on the Height<p/>
		 * 
		 * @param height - int value of height - unit is milimeter
		 * @return width - int value of width - unit is milimeter
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getWidthA4(height:int):int 
		{
			var scaleH:Number = height / PaperSize2.A4_HEIGHT;
			var scaleW:Number = PaperSize2.A4_WIDTH * scaleH;
			
			return scaleW;
		}
		
		
		/** <p>Getting Size of Paper Based PaperSize<p/>
		 * 
		 * @param paperSize - it will be from PaperSize2.A4, PaperSize2.A3 etc.
		 * @return rectange - Rectangle class that width and height will be valued - unit of values are Millimeters
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getSize(paperSize:String, isPortrate:Boolean=true):Rectangle 
		{
			var rect:Rectangle = new Rectangle;
			
			switch(paperSize)
			{
				case PaperSize2.A0: {
					rect.width = PaperSize2.A0_WIDTH;
					rect.height = PaperSize2.A0_HEIGHT;
					break;
				}
					
				case PaperSize2.A1: {
					rect.width = PaperSize2.A1_WIDTH;
					rect.height = PaperSize2.A1_HEIGHT;
					break;
				}
					
				case PaperSize2.A2: {
					rect.width = PaperSize2.A2_WIDTH;
					rect.height = PaperSize2.A2_HEIGHT;
					break;
				}
					
				case PaperSize2.A3: {
					rect.width = PaperSize2.A3_WIDTH;
					rect.height = PaperSize2.A3_HEIGHT;
					break;
				}
					
				case PaperSize2.A4: {
					rect.width = PaperSize2.A4_WIDTH;
					rect.height = PaperSize2.A4_HEIGHT;
					break;
				}
					
				case PaperSize2.A5: {
					rect.width = PaperSize2.A5_WIDTH;
					rect.height = PaperSize2.A5_HEIGHT;
					break;
				}
					
				case PaperSize2.A6: {
					rect.width = PaperSize2.A6_WIDTH;
					rect.height = PaperSize2.A6_HEIGHT;
					break;
				}
					
				case PaperSize2.DL: {
					rect.width = PaperSize2.DL_WIDTH;
					rect.height = PaperSize2.DL_HEIGHT;
					break;
				}
				
					
				default:
				{
					break;
				}
			}
			
			
			
			// chaning the width with height when is on Landscape Mode
			if(isPortrate == false)
			{
				var temp:Number = rect.height;
				rect.height = rect.width;
				rect.width  = temp;
			}
			
			
			return rect;
		}
		
		
	}
}
















