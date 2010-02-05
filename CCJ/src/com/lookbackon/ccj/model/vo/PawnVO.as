package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class PawnVO extends ChessVOBase
	{
		/**
		 * @inheritDoc
		 */
		public function PawnVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		/**
		 * @inheritDoc
		 */		
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			//* -
			//* -
			//left or right
			this.setBitt(rowIndex,colIndex+1,true);
			this.setBitt(rowIndex,colIndex-1,true);
			//top or bottom
			this.setBitt(rowIndex+1,colIndex,true);
			this.setBitt(rowIndex-1,colIndex,true);
			//TODO:
			//before over river and territory.
			//after over river and territory.
		}
	}
}