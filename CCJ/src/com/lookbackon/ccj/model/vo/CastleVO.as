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
			for(var h:int=0;h<this.height;h++)
			{
				for(var w:int=0;w<this.width;w++)
				{
					//horizontally.
					if(h==rowIndex)
					{
						for(var hh:int=0;hh<this.width;hh++)
						{
							if(hh!=rowIndex)
							{
								this.setBitt(rowIndex,hh,true);
							}
						}
					}
					//vertically.
					if(h==colIndex)
					{
						for(var v:int=0;v<this.height;v++)
						{
							if(v!=colIndex)
							{
								this.setBitt(v,colIndex,true);
							}
						}
					}
				}
			}
		}
	}
}