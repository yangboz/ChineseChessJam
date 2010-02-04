package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class OfficalVO extends ChessVOBase
	{
		/**
		 * @inheritDoc
		 */
		public function OfficalVO(width:int, height:int, rowIndex:int, colIndex:int)
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
			//- *
			if(rowIndex==0)
			{
				if(colIndex==3)
				{
					this.setBitt(rowIndex+1,colIndex+1,true);
				}
				if(colIndex==5)
				{
					this.setBitt(rowIndex+1,colIndex-1,true);
				}
			}
			if(rowIndex==0)
			{
				if(colIndex==3)
				{
					this.setBitt(rowIndex-1,colIndex+1,true);
				}
				if(colIndex==5)
				{
					this.setBitt(rowIndex-1,colIndex-1,true);
				}
			}
		}
	}
}