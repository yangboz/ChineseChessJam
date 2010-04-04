package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPositionModelLocator;

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
		public function MarshalVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */	
		override protected function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//TODO: implement function
			/*var getCols:Array = ChessPositionModelLocator.getInstance().allPieces.getCol(colIndex);
			var getIndex:int = getCols.indexOf(CcjConstants.RED_MARSHAL);
			var getColsReverse:Array = getCols.reverse();
			//blue
			if(rowIndex>=7)
			{
				//right
				if(colIndex<5)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex,colIndex+1,true);
					}else
					{
						if(getCols[getCols.length-1]!=CcjConstants.RED_MARSHAL)
						{
							this.setBitt(rowIndex,colIndex+1,true);
						}
					}
				}
				//left
				if(colIndex>3)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex,colIndex-1,true);
					}else
					{
						if(getCols[getCols.length-1]!=CcjConstants.RED_MARSHAL)
						{
							this.setBitt(rowIndex,colIndex-1,true);
						}
					}
				}
				//top
				if(rowIndex>7)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex-1,colIndex,true);
					}else
					{
						if(getCols[getCols.length-1]!=CcjConstants.RED_MARSHAL)
						{
							this.setBitt(rowIndex-1,colIndex,true);
						}
					}
				}
				//bottom
				if(rowIndex<9)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex+1,colIndex,true);
					}else
					{
						if(getCols[getCols.length-1]!=CcjConstants.RED_MARSHAL)
						{
							this.setBitt(rowIndex+1,colIndex,true);
						}
					}
				}
			}else
			//red	
			{
				//right
				if(colIndex<5)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex,colIndex+1,true);
					}else
					{
						if(getColsReverse[getCols.length-1]!=CcjConstants.BLUE_MARSHAL)
						{
							this.setBitt(rowIndex,colIndex+1,true);
						}
					}
				}
				//left
				if(colIndex>3)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex,colIndex-1,true);
					}else
					{
						if(getColsReverse[getCols.length-1]!=CcjConstants.BLUE_MARSHAL)
						{
							this.setBitt(rowIndex,colIndex-1,true);
						}
					}
				}
				//top
				if(rowIndex<2)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex+1,colIndex,true);
					}else
					{
						if(getColsReverse[getCols.length-1]!=CcjConstants.BLUE_MARSHAL)
						{
							this.setBitt(rowIndex+1,colIndex,true);
						}
					}
				}
				//bottom
				if(rowIndex>0)
				{
					//several amendments.
					//avoid marshall face to face.
					if(getIndex==-1)
					{
						this.setBitt(rowIndex-1,colIndex,true);
					}else
					{
						if(getColsReverse[getCols.length-1]!=CcjConstants.BLUE_MARSHAL)
						{
							this.setBitt(rowIndex-1,colIndex,true);
						}
					}
				}
			}*/
		}
	}
}