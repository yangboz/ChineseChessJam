package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author knight.zhou
	 * 
	 */	
	public class KnightVO extends ChessVOBase
	{
		/**
		 * @inheritDoc
		 */
		public function KnightVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		/**
		 * @inheritDoc
		 */
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			// - * - * -
			// * - - - *
			// - - s - -
			// * - - - *
			// - * - * -
			if(rowIndex<=8 && colIndex>=2)
			{
				this.setBitt(rowIndex+1,colIndex-2,true);
			}
			if(rowIndex<=8 && colIndex<=6)
			{
				this.setBitt(rowIndex+1,colIndex+2,true);
			}
			//
			if(rowIndex>=1 && colIndex>=2)
			{
				this.setBitt(rowIndex-1,colIndex-2,true);
			}
			if(rowIndex>=1 && colIndex<=6)
			{
				this.setBitt(rowIndex-1,colIndex+2,true);
			}
			//
			if(rowIndex<=7 && colIndex>=1)
			{
				this.setBitt(rowIndex+2,colIndex-1,true);
			}
			if(rowIndex<=7 && colIndex<=7)
			{
				this.setBitt(rowIndex+2,colIndex+1,true);
			}
			//
			if(rowIndex>=2 && colIndex>=1)
			{
				this.setBitt(rowIndex-2,colIndex-1,true);
			}
			if(rowIndex>=2 && colIndex<=7)
			{
				this.setBitt(rowIndex-2,colIndex+1,true);
			}
		}
	}
}