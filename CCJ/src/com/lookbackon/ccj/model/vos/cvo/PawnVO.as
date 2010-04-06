package com.lookbackon.ccj.model.vos.cvo
{
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
			
			//about attacked captures.
		}
	}
}