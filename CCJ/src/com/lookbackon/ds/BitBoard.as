package com.lookbackon.ds
{
	import com.lookbackon.ccj.errors.CcjErrors;
	
	import de.polygonal.ds.BitVector;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class BitBoard extends BitVector
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var width:int;
		protected var height:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function BitBoard(width:int,height:int)
		{
			this.width  = width;
			this.height = height;
			//TODO: implement function
			super(width*height);
		}
		/**
		 * Gets a bit from a given row and column.
		 * @param row the row number.
		 * @param column the column number.
		 * @return the index bool value.
		 * 
		 */		
		public function getBitt(row:int,column:int):int
		{
			return this.getBit(row*width+column);
		}
		/**
		 * Sets a bit at a given row and column.
		 * @param row the row number.
		 * @param column the column number.
		 * @param b the index bool value.
		 * 
		 */		
		public function setBitt(row:int,column:int,b:Boolean):void
		{
			var index:int = (row*width+column);
			if(index>=0&&index<=width*height)
			{
				this.setBit(index,b);
			}else
			{
				throw new CcjErrors(CcjErrors.INVALID_CHESS_VO);
			}
		}
		/**
		 * @inheritDoc
		 */		
		override public function toString() : String
		{
			return "[BitBoard, size=" + (width*height) + "]";
		}
		/**
		 * Dump out a string representing the current object.
		 * 
		 * @return A string representing the current object.
		 */	
		public function dump():String
		{
			var result:String = "[BitBoard, size=";
			result = result.concat((width*height).toString(),"\n","{");
			//
			for(var h:int=0;h<height;h++)
			{
				result = result.concat("\n","\t");
				for(var w:int=0;w<width;w++)
				{
					result = result.concat("[",this.getBit(this.width*h+w).toString(),"]");
				}
			}
			result = result.concat("\n","}","]");
			return result;
		}
	}
}