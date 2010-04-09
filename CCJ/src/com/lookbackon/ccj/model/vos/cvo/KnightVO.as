package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.model.ChessPositionModelLocator;

	/**
	 * 
	 * @author knight.zhou
	 * 
	 */	
	public class KnightVO extends ChessVO
	{
		/**
		 * @inheritDoc
		 */
		public function KnightVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			// - * - * -
			// * - - - *
			// - - s - -
			// * - - - *
			// - * - * -
			//serveral admental(马撇脚问题)
			//left direction.
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex,colIndex-1))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex+1,colIndex-2,true);
				this.occupies.setBitt(rowIndex-1,colIndex-2,true);
			}
			//up direction.
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex-1,colIndex))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex+2,colIndex-1,true);
				this.occupies.setBitt(rowIndex-2,colIndex+1,true);
			}
			//right direction.
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex,colIndex+1))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex+1,colIndex+2,true);
				this.occupies.setBitt(rowIndex-1,colIndex+2,true);
			}
			//down direction.
			if(!ChessPositionModelLocator.getInstance().allPieces.getBitt(rowIndex+1,colIndex))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex-2,colIndex+1,true);
				this.occupies.setBitt(rowIndex-2,colIndex-1,true);
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