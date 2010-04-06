package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.model.ChessPositionModelLocator;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class BishopVO extends ChessVO
	{
		/**
		 * @inheritDoc
		 */
		public function BishopVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			// * - -
			// - - -
			// - - *
			//about occupies.
			this.occupies.setBitt(rowIndex+2,colIndex+2,true);
			this.occupies.setBitt(rowIndex+2,colIndex-2,true);
			this.occupies.setBitt(rowIndex-2,colIndex+2,true);
			this.occupies.setBitt(rowIndex-2,colIndex-2,true);
			//about legal moves.
			
			//about attacked captures.
		}
	}
}