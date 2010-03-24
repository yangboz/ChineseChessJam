package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ccj.model.ChessPositionModelLocator;
	import com.lookbackon.ccj.utils.MathUtil;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CannonVO extends ChessVOBase
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
		override protected function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			// s - *
			// -
			// *
			var getRows:Array = ChessPositionModelLocator.getInstance().allPieces.getRow(rowIndex);
			var getCols:Array = ChessPositionModelLocator.getInstance().allPieces.getCol(colIndex);
			//horizontally.
			for(var hh:int=0;hh<this.column;hh++)
			{
				if(MathUtil.transactAbs(hh-colIndex)>1)
				{
					//several amendments.
					if(getRows[hh])
					{
						this.setBitt(rowIndex,hh+1,true);
					}else
					{
						this.setBitt(rowIndex,hh,true);
					}
				}
			}
			//vertically.
			for(var v:int=0;v<this.row;v++)
			{
				if(MathUtil.transactAbs(v-rowIndex)>1)
				{
					if(getCols[v])
					{
						this.setBitt(v+1,colIndex,true);
					}else
					{
						this.setBitt(v,colIndex,true);
					}
				}
			}
			//iteself
		}
	}
}