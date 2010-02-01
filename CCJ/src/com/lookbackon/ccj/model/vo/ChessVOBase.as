package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ds.BitBoard;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessVOBase extends BitBoard
	{
		public function ChessVOBase(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height);
			this.initialization(rowIndex,colIndex);
		}
		virtual protected function initialization( rowIndex:int, colIndex:int):void
		{
			//TODO: override function.
		}
	}
}