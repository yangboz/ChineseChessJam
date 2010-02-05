package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class MarshalVO extends ChessVOBase
	{
		/**
		 * @inheritDoc
		 */		
		public function MarshalVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		/**
		 * @inheritDoc
		 */	
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			//TODO: implement function
			//left or right
			if(colIndex!=5)
			{
				this.setBitt(rowIndex,colIndex+1,true);
			}
			if(colIndex!=3)
			{
				this.setBitt(rowIndex,colIndex-1,true);
			}
			//up or bottom
			if(rowIndex!=2 || rowIndex!=9)
			{
				this.setBitt(rowIndex+1,colIndex,true);
			}
			if(rowIndex!=0 || rowIndex!=7)
			{
				this.setBitt(rowIndex-1,colIndex,true);
			}
			//marshall face to face.
			if(rowIndex>=0&&rowIndex<=2)
			{
				this.setBitt(7,colIndex,true);
				this.setBitt(8,colIndex,true);
				this.setBitt(9,colIndex,true);
			}else
			{
				this.setBitt(0,colIndex,true);
				this.setBitt(1,colIndex,true);
				this.setBitt(2,colIndex,true);
			}
		}
	}
}