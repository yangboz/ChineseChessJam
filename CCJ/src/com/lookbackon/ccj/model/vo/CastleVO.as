package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ds.BitBoard;
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CastleVO extends ChessVOBase
	{
		public function CastleVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height,rowIndex,colIndex);
		}
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			for(var h:int=0;h<this.height;h++)
			{
				for(var w:int=0;w<this.width;w++)
				{
					//horizontally.
					if(h==rowIndex)
					{
						for(var hh:int=1;hh<this.width;hh++)
						{
							this.setBitt(rowIndex,hh,true);
						}
					}
					//vertically.
					if(v==colIndex)
					{
						for(var v:int=1;v<this.height;v++)
						{
							this.setBitt(v,colIndex,true);
						}
					}
				}
			}
		}
	}
}