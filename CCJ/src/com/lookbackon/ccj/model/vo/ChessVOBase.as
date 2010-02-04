package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ds.BitBoard;

	/**
	 * 
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
		 * 
		 */		
		public function ChessVOBase(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height);
			this.initialization(rowIndex,colIndex);
		}
		/**
		 * 
		 * @param the rowIndex you wanna set bit flag.
		 * @param the colIndex you wanna set big flag.
		 * @see mx.utils.BitFlagUtil#update
		 */
		virtual protected function initialization( rowIndex:int, colIndex:int):void
		{
			//TODO: override function.
			throw new Error("Virtual function initialized!!!");
		}
	}
}