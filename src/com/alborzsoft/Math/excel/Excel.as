package com.alborzsoft.Math.excel
{
	/** This Class Created By Abar Goldust, in Jan 11 2011.
	 * 
	 * refrence site for creating the Formulas is http://www.techonthenet.com/excel/formulas/
	 */
	public class Excel
	{
		
		/** Microsoft Exel Paymet Function
		 * @param ir - the annual Interest Rate for the loan
		 * @param np - the total Number of Payments for the loan
		 * @param pv - the Present Value or the amount borrowed or the principal of the loan. 
		 * @param fv - Future Value, for a loan this will be $0.00. For loans this argument can be omitted. 
		 * @param t  - indicates when payments are due:
		 * @result Number - Payment Amount
		 */
		public static function PMT(ir:Number, np:Number, pv:Number, fv:Number=0, t:Number=0):Number
		{
			var vPow:Number = Math.pow( ( 1 + ir ), np );
			var vT:Number = (t == 0) ? ir : ( ir /( 1 + ir ) );
			var sum:Number = ((vPow * pv) - fv ) / (vPow - 1) * vT;
			
			return sum;
		}
	}
}