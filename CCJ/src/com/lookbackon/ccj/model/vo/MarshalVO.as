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
		}
	}
}