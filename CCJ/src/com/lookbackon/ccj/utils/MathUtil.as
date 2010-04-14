package com.lookbackon.ccj.utils
{
	/**
	 *
	 * @author Knight.zhou
	 *
	 */
	public class MathUtil
	{
		private static var UINT_MAX_RATIO:Number = 1/uint.MAX_VALUE;
		private static var INT_MAX_RATIO:Number = 1/int.MAX_VALUE;
		private static var UINT_RANDOM:uint = Math.random()*uint.MAX_VALUE;
		private static var NEGA_INT_MAX_RATIO:Number = -INT_MAX_RATIO;
		private static var INT_RANDOM:int	 = Math.random()*int.MAX_VALUE;
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
		/**
		 * Using XOR algorithm with integer, 
		 * primarily because AS3 is lightning-quick with bit operations, 
		 * and the algorithm is only 4 lines of code. 
		 * Notice: it is 2 time faster than Math.random();
		 * @return random number between 0~1.
		 * 
		 */		
		public static function intXORrandom():Number
		{
			INT_RANDOM ^= (INT_RANDOM << 21);
			INT_RANDOM ^= (INT_RANDOM >>> 35);
			INT_RANDOM ^= (INT_RANDOM << 4);//comment out this line for -1 ~ 1
			if(INT_RANDOM < 0) return INT_RANDOM * INT_MAX_RATIO;
			return INT_RANDOM * NEGA_INT_MAX_RATIO;
		}
		/**
		 * Using XOR algorithm with un-integer, 
		 * primarily because AS3 is lightning-quick with bit operations, 
		 * and the algorithm is only 4 lines of code. 
		 * Notice: it is 4 time faster than Math.random();
		 * @return random number between 0~1.
		 * 
		 */		
		public static function uintXORrandom():Number
		{
			UINT_RANDOM ^= (UINT_RANDOM << 21);
			UINT_RANDOM ^= (UINT_RANDOM >>> 35);
			UINT_RANDOM ^= (UINT_RANDOM << 4);
			return (UINT_RANDOM * UINT_MAX_RATIO);
		}
	}
}