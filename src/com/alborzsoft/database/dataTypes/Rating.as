package com.alborzsoft.database.dataTypes
{
	/**<p>Rating Class for holding the rating data</p>
	 * <p>Creatd By: Akbar Goldust</p>
	 * <p>Last modification date: Nov 25, 2011</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9, AIR 1.0
	 */
	public class Rating
	{
		/** Avarage Rating value*/
		public var average:Number;
		
		/** Minimum Rating value*/
		public var min:Number;
		
		/** Maximum Rating value*/
		public var max:Number;
		
		/** Number of person that rated*/
		public var numRaters:uint;
		
		/** Rating time*/
		public var timestamp:Date;
		
		
		public function Rating(average:Number, min:Number, max:Number, numRaters:uint, timestamp:Date=null)
		{
			this.average = average;
			this.min = min;
			this.max = max;
			this.numRaters = numRaters;
			this.timestamp = timestamp;
		}
	}
}