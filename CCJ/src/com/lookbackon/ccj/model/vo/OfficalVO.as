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
		public function OfficalVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override protected function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//* -
			//- *
			var colIndexOffset:int = (colIndex==3?1:-1);
			//row index(0,7);
			if(rowIndex==0 || rowIndex==7)
			{
				//bottom
				this.setBitt(rowIndex+1,colIndex+colIndexOffset,true);
			}
			//row index(1,8);
			if(rowIndex==1 || rowIndex==8)
			{
				//top
				this.setBitt(rowIndex-1,colIndex-1,true);
				this.setBitt(rowIndex-1,colIndex+1,true);
				//bottom
				this.setBitt(rowIndex+1,colIndex-1,true);
				this.setBitt(rowIndex+1,colIndex+1,true);
			}
			//row index(2,9);
			if(rowIndex==2 || rowIndex==9)
			{
				//top
				this.setBitt(rowIndex-1,colIndex+colIndexOffset,true);
			}
		}
	}
}