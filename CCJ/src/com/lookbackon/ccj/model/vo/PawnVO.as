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
		public function PawnVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
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
			//* -
			//TODO:
			//before over river and territory.
			if(flag)
			{
				//only top
				this.setBitt(rowIndex+1,colIndex,true);
			}else
			{
				//only bottom
				this.setBitt(rowIndex-1,colIndex,true);
			}
			//after over river and territory.
			if(flag)
			{
				if(rowIndex>=5)
				{
					//left or right
					this.setBitt(rowIndex,colIndex+1,true);
					this.setBitt(rowIndex,colIndex-1,true);
				}
			}else
			{
				if(rowIndex<=5)
				{
					//left or right
					this.setBitt(rowIndex,colIndex+1,true);
					this.setBitt(rowIndex,colIndex-1,true);
				}
			}
		}
	}
}