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
			//blue
			if(rowIndex>=7)
			{
				//marshall face to face.
				this.setBitt(0,colIndex,true);
				this.setBitt(1,colIndex,true);
				this.setBitt(2,colIndex,true);
				//itself
				//right
				if(colIndex<5)
				{
					this.setBitt(rowIndex,colIndex+1,true);
				}
				//left
				if(colIndex>3)
				{
					this.setBitt(rowIndex,colIndex-1,true);
				}
				//top
				if(rowIndex>7)
				{
					this.setBitt(rowIndex-1,colIndex,true);
				}
				//bottom
				if(rowIndex<9)
				{
					this.setBitt(rowIndex+1,colIndex,true);
				}
			}else
			//red	
			{
				//marshall face to face.
				this.setBitt(7,colIndex,true);
				this.setBitt(8,colIndex,true);
				this.setBitt(9,colIndex,true);
				//itself
				//right
				if(colIndex<5)
				{
					this.setBitt(rowIndex,colIndex+1,true);
				}
				//left
				if(colIndex>3)
				{
					this.setBitt(rowIndex,colIndex-1,true);
				}
				//top
				if(rowIndex<2)
				{
					this.setBitt(rowIndex+1,colIndex,true);
				}
				//bottom
				if(rowIndex>0)
				{
					this.setBitt(rowIndex-1,colIndex,true);
				}
			}
		}
	}
}