package com.lookbackon.ccj.utils
{
	/**
	 *
	 * @author Knight.zhou
	 *
	 */
	public class MathUtil
	{
		/**
		 *
		 * @param the minium of random ranges.
		 * @param the maxium of random ranges.
		 * @return the random number between min and max.
		 *
		 */
		public static function transactRandomNumberInRange(min:Number, max:Number):Number
		{
			return (Math.floor(Math.random() * (max - min + 1)) + min);
		}
		
		private static var returnedResult:Array = [];
		/**
		 * 
		 * @param min
		 * @param max
		 * @return the random number between min and max but diff from previous result.
		 * 
		 */		
		public static function transactDiffRandomNumberInRange(min:Number, max:Number):Number
		{
			var result:Number = (Math.floor(Math.random() * (max - min + 1)) + min);
			if(result in returnedResult)
			{
				if(returnedResult.length>=max-1)
				{
					returnedResult = [];
				}
				return transactDiffRandomNumberInRange(min,max);
			}else
			{
				returnedResult.push(result);
				return result;
			}
			//default return value.
			return min;
		}
		/**
		 * 
		 * @param value wheather negative or postive number.
		 * @return postive number.
		 * 
		 */		
		public static function transactAbs(value:Number):Number
		{
			var i:Number;
			//version 1
			//			i = x < 0 ? -x : x;
			//version 2
			i = (value ^ (value >> 31)) - (value >> 31);
			return i;
		}
	}
}