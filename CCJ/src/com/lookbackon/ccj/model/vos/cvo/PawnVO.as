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
	public class PawnVO extends ChessVO
	{
		/**
		 * @inheritDoc
		 */
		public function PawnVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */		
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//* -
			//* -
			//TODO: implement function
			//about occupies.
			this.occupies.setBitt(rowIndex+1,colIndex,true);
			this.occupies.setBitt(rowIndex-1,colIndex,true);
			this.occupies.setBitt(rowIndex,colIndex+1,true);
			this.occupies.setBitt(rowIndex,colIndex-1,true);
			//about legal moves.
			if(flag==ChessFactory.FLAG_RED)
			{
				//serveral admental(兵横向移动问题)
				this.moves = this.occupies.xor(this.occupies.and(ChessPositionModelLocator.getInstance().redPieces));
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPositionModelLocator.getInstance().bluePieces));
			}
			//about attacked captures.
			if(flag==ChessFactory.FLAG_RED)
			{
				//serveral admental(兵后退问题)
				this.captures = this.occupies.and(ChessPositionModelLocator.getInstance().bluePieces);
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.captures = this.occupies.and(ChessPositionModelLocator.getInstance().redPieces);
			}
		}
	}
}