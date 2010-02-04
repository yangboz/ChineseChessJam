package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class BishopVO extends ChessVOBase
	{
		/**
		 * @inheritDoc
		 */
		public function BishopVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		/**
		 * @inheritDoc
		 */
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			// * - -
			// - - -
			// - - *
			if(rowIndex==0 || rowIndex==9)
			{
				if(colIndex==2 || colIndex==6)
				{
					this.setBitt(rowIndex+2,colIndex-2,true);
					this.setBitt(rowIndex+2,colIndex+2,true);
				}
			}
			if(rowIndex==2 || rowIndex==7)
			{
				if(colIndex==0)
				{
					this.setBitt(rowIndex-2,colIndex+2,true);
					this.setBitt(rowIndex+2,colIndex+2,true);
				}
				if(colIndex==4)
				{
					this.setBitt(rowIndex-2,colIndex+2,true);
					this.setBitt(rowIndex-2,colIndex-2,true);
					this.setBitt(rowIndex+2,colIndex-2,true);
					this.setBitt(rowIndex+2,colIndex+2,true);
				}
				if(colIndex==8)
				{
					this.setBitt(rowIndex-2,colIndex-2,true);
					this.setBitt(rowIndex+2,colIndex-2,true);
				}
			}
			if(rowIndex==4)
			{
				if(colIndex==2 || colIndex==6)
				{
					this.setBitt(rowIndex-2,colIndex-2,true);
					this.setBitt(rowIndex-2,colIndex+2,true);
				}
			}
			if(rowIndex==5)
			{
				if(colIndex==2 || colIndex==6)
				{
					this.setBitt(rowIndex+2,colIndex-2,true);
					this.setBitt(rowIndex+2,colIndex+2,true);
				}
			}
		}
	}
}