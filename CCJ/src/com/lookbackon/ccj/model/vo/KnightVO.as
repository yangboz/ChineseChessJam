package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author knight.zhou
	 * 
	 */	
	public class KnightVO extends ChessVOBase
	{
		public function KnightVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			// * - - - *
			// - - s - -
			// * - - - *
			//left
			if(colIndex>=2)
			{
				//top
				if(rowIndex>=1)
				{
					this.setBitt(rowIndex-1,colIndex-2,true);
				}
				//bottom
				if(rowIndex<=9)
				{
					this.setBitt(rowIndex+1,colIndex-2,true);
				}
			}
			//right
			if(colIndex<=6)
			{
				//top
				if(rowIndex>=1)
				{
					this.setBitt(rowIndex-1,colIndex+2,true);
				}
				//bottom
				if(rowIndex<=9)
				{
					this.setBitt(rowIndex+1,colIndex+2,true);
				}
			}
		}
	}
}