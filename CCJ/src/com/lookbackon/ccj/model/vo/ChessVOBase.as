package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ds.BitBoard;

	/**
	 * This is our bitboard:
	 * ---------
	 * rkbomobkr
	 * 
	 *  c     c
	 * p p p p p
	 * 
	 * 
	 * 
	 * P P P P P
	 *  C     C
	 * 
	 * RKBOMOBKR
	 * ---------
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessVOBase extends BitBoard
	{
		/**
		 * 
		 * @param the width value of bitboard;
		 * @param the height value of bitboard;
		 * @param the rowIndex of destination point;
		 * @param the colIndex of destination point;
		 * @param the flag you wanna set(red is 0,blue is 1).
		 */		
		public function ChessVOBase(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height);
			this.initialization(rowIndex,colIndex,flag);
		}
		/**
		 * 
		 * @param the rowIndex you wanna set bit flag.
		 * @param the colIndex you wanna set big flag.
		 * @param the flag you wanna set(red is 0,blue is 1).
		 * @see mx.utils.BitFlagUtil#update
		 */
		virtual protected function initialization( rowIndex:int, colIndex:int,flag:int=0):void
		{
			//TODO: override function.
			throw new CcjErrors(CcjErrors.INITIALIZE_VIRTUAL_FUNCTION);
		}
	}
}