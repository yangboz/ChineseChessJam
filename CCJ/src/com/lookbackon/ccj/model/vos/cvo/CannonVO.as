package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.model.ChessPositionModelLocator;
	import com.lookbackon.ccj.utils.MathUtil;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CannonVO extends ChessVO
	{
		/**
		 * @inheritDoc
		 */
		public function CannonVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			// s - *
			// -
			// *
			//about occupies.
			for(var r:int=0;r<this.row;r++)
			{
				if(r!=rowIndex)
				{
					this.occupies.setBitt(r,colIndex,true);
				}
			}
			for(var c:int=0;c<this.row;c++)
			{
				if(c!=colIndex)
				{
					this.occupies.setBitt(rowIndex,c,true);
				}
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
				//serveral admental(炮隔子吃子问题)
				this.captures = this.moves.and(ChessPositionModelLocator.getInstance().bluePieces);
			}
			if(flag==ChessFactory.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPositionModelLocator.getInstance().redPieces);
			}
		}
	}
}