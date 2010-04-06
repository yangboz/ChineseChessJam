package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
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
			//serveral admental(象田心问题)
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex+1,colIndex+1))
			{
				this.occupies.setBitt(rowIndex+2,colIndex+2,true);
			}
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex+1,colIndex-1))
			{
				this.occupies.setBitt(rowIndex+2,colIndex-2,true);
			}
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex-1,colIndex+1))
			{
				this.occupies.setBitt(rowIndex-2,colIndex+2,true);
			}
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex-1,colIndex-1))
			{
				this.occupies.setBitt(rowIndex-2,colIndex-2,true);
			}
			//about legal moves.
			if(flag==ChessFactory.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPositionModelLocator.getInstance().redPieces));
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPositionModelLocator.getInstance().bluePieces));
			}
			//about attacked captures.
			if(flag==ChessFactory.FLAG_RED)
			{
				this.captures = this.occupies.and(ChessPositionModelLocator.getInstance().bluePieces);
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.captures = this.occupies.and(ChessPositionModelLocator.getInstance().redPieces);
			}
		}
	}
}