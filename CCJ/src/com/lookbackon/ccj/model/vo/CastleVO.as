package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CastleVO extends ChessVOBase
	{
		/**
		 * @inheritDoc
		 */
		public function CastleVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height,rowIndex,colIndex);
		}
		/**
		 * @inheritDoc
		 */
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			//    *
			// ***s*****
			//    *
			//horizontally.
			for(var hh:int=0;hh<this.width;hh++)
			{
				if(hh!=colIndex)
				{
					this.setBitt(rowIndex,hh,true);
				}
			}
			//vertically.
			for(var v:int=0;v<this.height;v++)
			{
				if(v!=rowIndex)
				{
					this.setBitt(v,colIndex,true);
				}
			}
			//iteself
		}
	}
}