package com.lookbackon.ds
{
	import com.lookbackon.ccj.errors.CcjErrors;
	
	import de.polygonal.ds.BitVector;

	/**
	 * Pros and Cons of Using BitBoard Flags:
	 * Pros:
     * Efficient: Very small storage space to hold a lot of information.
     * Efficient: Ultra-fast (actually fastest possible) for making programmatic decisions, 
	 * especially when looking for combinations of attributes or options.
     * Efficient: Concise storage means fast data transfer.
     * Extensible:  New code does not "break" old code.  Additional (new) data can be packed into 
	 * the same variable without causing backward compatibility problems.
     * Extensible:  New data does not require new database schema or changed record layouts.  
	 * Only the program code changes.
	 * Cons:
     * Idiomatic.  Not all programmers understand what's going on.  
	 * Possible increased documentation requirements.
	 * @see http://blog.lookbackon.com/?p=371
	 * @author Knight.zhou
	 * 
	 */	
	public class BitBoard extends BitVector implements IBitBoard
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
			var bb:BitBoard = new BitBoard(this.column,this.row);
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
					bb.setBitt(h,w,!Boolean(this.getBitt(h,w)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  or(IBitBoard)
		//----------------------------------
		public function or(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
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
			var bb:BitBoard = new BitBoard(this.column,this.row);
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
		//  rotate45=(IBitBoard)
		//----------------------------------
		/**
		 * notice:this function is suitable for which board column equals to row.
		 * @return Fliped rows with cols such as clockwise rotatation 45 degree.
		 */	
		public function rotate45():BitBoard
		{
			//TODO:
			return new BitBoard(0,0);
		}
		//----------------------------------
		//  rotate90=(IBitBoard)
		//----------------------------------
		/**
		 * @return Fliped rows with cols such as clockwise rotatation 90 degree.
		 */		
		public function rotate90():BitBoard
		{
			var bb:BitBoard = new BitBoard(_row,_column);
			for(var w:int=0;w<_row;w++)
			{
				for(var h:int=0;h<_column;h++)
				{
					bb.setBitt(h,w,Boolean(this.getBitt(w,h)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  reverse(IBitBoard)
		//----------------------------------
		/**
		 * @return reversed rows with cols such as mirror rotatation 180 degree.
		 */		
		public function reverse():BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=0;w<_column;w++)
			{
				for(var h:int=0;h<_row;h++)
				{
					bb.setBitt(h,w,Boolean(this.getBitt(_row-h-1,w)));
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
				return;//Maybe handle this illegal operation.
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
		//  isEmpty
		//----------------------------------
		public function get isEmpty():Boolean
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
		//  getRows
		//----------------------------------
		public function getRows(rowIndex:int):Array
		{
			var result:Array = [];
			for(var r:int=0;r<this.row;r++)
			{
				result.push(this.getBitt(r,rowIndex));
			}
			return result;
		}
		//----------------------------------
		//  getCols
		//----------------------------------
		public function getCols(colIndex:int):Array
		{
			var result:Array = [];
			for(var c:int=0;c<this.column;c++)
			{
				result.push(this.getBitt(colIndex,c));
			}
			return result;
		}
		//----------------------------------
		//  dump
		//----------------------------------
		/**
		 * Dump out a string representing the current object.
		 * 
		 * @return A "human-readable" string representing the current object.
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