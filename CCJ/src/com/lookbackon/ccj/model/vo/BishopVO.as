package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ccj.model.ChessPositionModelLocator;

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
		public function BishopVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override protected function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			// * - -
			// - - -
			// - - *
			if(rowIndex==0)
			{
				//several amendments.
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex+1))
				{
					this.setBitt(rowIndex+2,colIndex-2,true);
				}
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex+1,rowIndex+1))
				{
					this.setBitt(rowIndex+2,colIndex+2,true);
				}
			}
			if(rowIndex==2 || rowIndex==7)
			{
				if(colIndex>2)
				{
					if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex-1))
					{
						this.setBitt(rowIndex-2,colIndex-2,true);
					}
					if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex+1,rowIndex-1))
					{
						this.setBitt(rowIndex+2,colIndex-2,true);
					}
				}
				if(colIndex<6)
				{
					if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex+1))
					{
						this.setBitt(rowIndex-2,colIndex+2,true);
					}
					if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex+1,rowIndex+1))
					{
						this.setBitt(rowIndex+2,colIndex+2,true);
					}
				}
			}
			if(rowIndex==4)
			{
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex-1))
				{
					this.setBitt(rowIndex-2,colIndex-2,true);
				}
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex+1))
				{
					this.setBitt(rowIndex-2,colIndex+2,true);
				}
			}
			if(rowIndex==5)
			{
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex+1,rowIndex-1))
				{
					this.setBitt(rowIndex+2,colIndex-2,true);
				}
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex+1))
				{
					this.setBitt(rowIndex+2,colIndex+2,true);
				}
			}
			if(rowIndex==9)
			{
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex-1))
				{
					this.setBitt(rowIndex-2,colIndex-2,true);
				}
				if(!ChessPositionModelLocator.getInstance().allPieces.gett(colIndex-1,rowIndex+1))
				{
					this.setBitt(rowIndex-2,colIndex+2,true);
				}
			}
		}
	}
}