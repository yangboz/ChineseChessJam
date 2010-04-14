package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.utils.MathUtil;

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
			if(!ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex+1,colIndex+1))
			{
				//serveral admental(象过河问题)
				if(flag==ChessFactory.FLAG_BLUE)
				{
					if(rowIndex<4)
					{
						this.occupies.setBitt(rowIndex+2,colIndex+2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex+2,colIndex+2,true);
				}
			}
			if(!ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex+1,colIndex-1))
			{
				//serveral admental(象过河问题)
				if(flag==ChessFactory.FLAG_BLUE)
				{
					if(rowIndex<4)
					{
						this.occupies.setBitt(rowIndex+2,colIndex-2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex+2,colIndex-2,true);
				}
			}
			if(!ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex-1,colIndex+1))
			{
				//serveral admental(象过河问题)
				if(flag==ChessFactory.FLAG_RED)
				{
					if(rowIndex>5)
					{
						this.occupies.setBitt(rowIndex-2,colIndex+2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex-2,colIndex+2,true);
				}
			}
			if(!ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex-1,colIndex-1))
			{
				//serveral admental(象过河问题)
				if(flag==ChessFactory.FLAG_RED)
				{
					if(rowIndex>5)
					{
						this.occupies.setBitt(rowIndex-2,colIndex-2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex-2,colIndex-2,true);
				}
			}
			//about legal moves.
//			LOG.info("redPieces:{0}",ChessPositionModelLocator.getInstance().redPieces.dump());
//			LOG.info("bluePieces:{0}",ChessPositionModelLocator.getInstance().bluePieces.dump());
			if(flag==ChessFactory.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
			//about attacked captures.
			if(flag==ChessFactory.FLAG_RED)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
		}
	}
}