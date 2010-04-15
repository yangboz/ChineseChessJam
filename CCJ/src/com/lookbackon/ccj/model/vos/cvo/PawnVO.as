package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.model.ChessPiecesModel;

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
			//serveral admental(兵横向移动问题)
			//right or left direction.
			if(flag==ChessFactory.FLAG_BLUE)
			{
				if(rowIndex>=5)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
				}
			}
			if(flag==ChessFactory.FLAG_RED)
			{
				if(rowIndex<=4)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
				}
			}
			//serveral admental(兵后退问题)
			//up direction
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.occupies.setBitt(rowIndex+1,colIndex,true);
			}
			//down direction
			if(flag==ChessFactory.FLAG_RED)
			{
				this.occupies.setBitt(rowIndex-1,colIndex,true);
			}
			//about legal moves.
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