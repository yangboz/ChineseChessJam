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
		private var _column:int;
		private var _row:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * @param column the number column of bit board.
		 * @param row the number row of bit board.
		 *   
		 */
		public function BitBoard(column:int,row:int)
		{
			this._column  = column;
			this._row = row;
			//TODO: implement function
			super(column*row);
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  column(read-only)
		//----------------------------------
		public function get column():int
		{
			return _column;
		}
		//----------------------------------
		//  row(read-only)
		//----------------------------------
		public function get row():int
		{
			return _row;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  and(IBitBoard)
		//----------------------------------
		public function and(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(value.column,value.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean((value.getBitt(h,w)&this.getBitt(h,w))));
				}
			}
			return bb;
		}
		//----------------------------------
		//  not(IBitBoard)
		//----------------------------------
		public function not():BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean(~this.getBitt(h,w)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  or(IBitBoard)
		//----------------------------------
		public function or(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(value.column,value.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean((value.getBitt(h,w)|this.getBitt(h,w))));
				}
			}
			return bb;
		}
		//----------------------------------
		//  xor(IBitBoard)
		//----------------------------------
		public function xor(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(value.column,value.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean((value.getBitt(h,w)^this.getBitt(h,w))));
				}
			}
			return bb;
		}
		//----------------------------------
		//  getBitt
		//----------------------------------
		/**
		 * Gets a bit from a given row and column.
		 * @param row the row number.
		 * @param column the column number.
		 * @return the index bool value.
		 * 
		 */		
		public function getBitt(row:int,column:int):int
		{
			return this.getBit(row*_column+column);
		}
		/**
		 * Sets a bit at a given row and column.
		 * @param row the row number.
		 * @param column the column number.
		 * @param b the index bool value.
		 * 
		 */
		//----------------------------------
		//  setBitt
		//----------------------------------
		public function setBitt(row:int,column:int,b:Boolean):void
		{
			var index:int = (row*_column+column);
			if(index>=0&&index<=_column*_row)
			{
				this.setBit(index,b);
			}else
			{
				throw new CcjErrors(CcjErrors.INVALID_CHESS_VO);
			}
		}
		//----------------------------------
		//  toString
		//----------------------------------
		/**
		 * @inheritDoc
		 */		
		override public function toString() : String
		{
			return "[BitBoard, size=" + (_column*_row) + "]";
		}
		//----------------------------------
		//  clone
		//----------------------------------
		public function clone():BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean(this.getBitt(h,w)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  isEmtpy
		//----------------------------------
		public function get isEmtpty():Boolean
		{
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					if(this.getBitt(h,w))
					{
						return false;
					}
				}
			}
			return true;
		}
		//----------------------------------
		//  dump
		//----------------------------------
		/**
		 * Dump out a string representing the current object.
		 * 
		 * @return A string representing the current object.
		 */	
		public function dump():String
		{
			var result:String = "[BitBoard, size=";
			result = result.concat((_column*_row).toString(),"\n","{");
			//
			for(var h:int=0;h<_row;h++)
			{
				result = result.concat("\n","\t");
				for(var w:int=0;w<_column;w++)
				{
					result = result.concat("[",this.getBit(this._column*h+w).toString(),"]");
				}
			}
			result = result.concat("\n","}","]");
			return result;
		}
	}
}