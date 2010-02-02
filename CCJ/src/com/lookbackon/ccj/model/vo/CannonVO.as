package com.lookbackon.ccj.model.vo
{
	import com.lookbackon.ccj.utils.MathUtil;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CannonVO extends ChessVOBase
	{
		public function CannonVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			// s - *
			// -
			// *
			for(var h:int=0;h<this.height;h++)
			{
				for(var w:int=0;w<this.width;w++)
				{
					//horizontally.
					if(h==rowIndex)
					{
						for(var hh:int=0;hh<this.width;hh++)
						{
							if(MathUtil.transactAbs(hh-rowIndex)!=1 && hh!=colIndex)
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
							if(MathUtil.transactAbs(v-colIndex)!=1 && v!=rowIndex)
							{
								this.setBitt(v,colIndex,true);
							}
						}
					}
					//iteself
				}
			}
		}
	}
}