package com.lookbackon.ccj.utils
{
	import com.lookbackon.ccj.model.vos.ConductVO;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * SortUtil.as class.   	
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 13, 2010 1:56:49 PM
	 */   	 
	public class VectorUtil
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//About filter
		//
		public static function filterOnCaptures(item:ConductVO, index:int, vector:Vector.<ConductVO>):Boolean
		{
			return Boolean(item.target.chessVO.captures.celled);
		}
		public static function filterOnEatOff(item:ConductVO, index:int, vector:Vector.<ConductVO>):Boolean
		{
			return Boolean(item.eatOff!=null);
		}
		//About sort
		//
		public static function sortOnCaptures(cd1:ConductVO,cd2:ConductVO):int
		{
			return cd1.target.chessVO.captures.celled-cd2.target.chessVO.captures.celled;
		}
		//
		public static function sortOnMoves(cd1:ConductVO,cd2:ConductVO):int
		{
			return cd1.target.chessVO.moves.celled-cd2.target.chessVO.moves.celled;
		}
		//
		public static function sortOnOccupies(cd1:ConductVO,cd2:ConductVO):int
		{
			return cd1.target.chessVO.occupies.celled-cd2.target.chessVO.occupies.celled;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		// http://www.kirupa.com/developer/actionscript/quickSort.htm
		private static function quickSort(arrayInput:Vector.<ConductVO>, left:int, right:int): void
		{
			var i:int = left;
			var j:int = right;
			var pivotPoint:ConductVO = arrayInput[Math.round((left+right)*.5)];
			
			// Loop
			while (i<=j)
			{
				while (arrayInput[i].target.chessVO.captures.celled < pivotPoint.target.chessVO.captures.celled)
				{
					i++;
				}
				while (arrayInput[j].target.chessVO.captures.celled> pivotPoint.target.chessVO.captures.celled)
				{
					j--;
				}
				if (i <= j)
				{
					var tempStore:ConductVO = arrayInput[i];
					arrayInput[i] = arrayInput[j];
					i++;
					arrayInput[j] = tempStore;
					j--;
				}
			}
			// Swap
			if (left < j)
			{
				quickSort(arrayInput, left, j);
			}
			if (i < right)
			{
				quickSort(arrayInput, i, right);
			}
		}
		
		// http://www.valveblog.com/2009/06/as3-sorting-algorithm-faster-than-native-sorting.html
		private static function shellSort(data:Vector.<ConductVO>): void
		{
			var n:int = data.length;
			var inc:int = int(n/2);
			while (inc)
			{
				for (var i:int = inc; i < n; i++)
				{
					var temp:ConductVO= data[i], j:int = i;
					while (j >= inc && data[int(j - inc)].target.chessVO.captures.celled > temp.target.chessVO.captures.celled)
					{
						data[j] = data[int(j - inc)];
						j = int(j - inc);
					}
					data[j] = temp
				}
				inc = int(inc / 2.2);
			}
		}
	}
	
}