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
		/**
		 * @inheritDoc
		 */
		public function CannonVO(width:int, height:int, rowIndex:int, colIndex:int)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex);
		}
		/**
		 * @inheritDoc
		 */
		override protected function initialization(rowIndex:int, colIndex:int) : void
		{
			// s - *
			// -
			// *
			//horizontally.
			for(var hh:int=0;hh<this.width;hh++)
			{
				if(MathUtil.transactAbs(hh-colIndex)>1)
				{
					this.setBitt(rowIndex,hh,true);
				}
			}
			//vertically.
			for(var v:int=0;v<this.height;v++)
			{
				if(MathUtil.transactAbs(v-rowIndex)>1)
				{
					this.setBitt(v,colIndex,true);
				}
			}
			//iteself
		}
	}
}