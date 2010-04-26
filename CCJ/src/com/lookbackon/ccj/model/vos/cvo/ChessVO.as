package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;

	/**
	 * This is our bitboard:
	 * ---------
	 * rkbomobkr
	 * 
	 *  c     c
	 * p p p p p
	 * 
	 * 
	 * 
	 * P P P P P
	 *  C     C
	 * 
	 * RKBOMOBKR
	 * ---------
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessVO extends BitBoard implements IChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _occupies:BitBoard;
		private var _moves:BitBoard;
		private var _captures:BitBoard;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		protected static const LOG:ILogger = LogUtil.getLogger(ChessVO);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * @param the width value of bitboard;
		 * @param the height value of bitboard;
		 * @param the rowIndex of destination point;
		 * @param the colIndex of destination point;
		 * @param the flag you wanna set(red is 0,blue is 1).
		 */		
		public function ChessVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height);
			//init.
			this.occupies = new BitBoard(width,height);
			this.moves = new BitBoard(width,height);
			this.captures = new BitBoard(width,height);
			this.initialization(rowIndex,colIndex,flag);
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  occupies(implements)
		//----------------------------------
		public function get occupies():BitBoard
		{
			return _occupies;
		}
		/**
		 * 
		 * @param value occupied by red/blue pieces.
		 * 
		 */		
		public function set occupies(value:BitBoard):void
		{
			_occupies = value;
//			LOG.info("anew occupies:{0}",value.dump());
		}
		//----------------------------------
		//  moves(implements)
		//----------------------------------
		public function get moves():BitBoard
		{
			return _moves;
		}
		/**
		 * 
		 * @param value legal moves by red/blue pieces.
		 * 
		 */		
		public function set moves(value:BitBoard):void
		{
			_moves = value;
//			LOG.info("anew moves:{0}",value.dump());
		}
		//----------------------------------
		//  captures(implements)
		//----------------------------------
		public function get captures():BitBoard
		{
			return _captures;
		}
		/**
		 * 
		 * @param value attacked by red/blue pieces.
		 * 
		 */		
		public function set captures(value:BitBoard):void
		{
			_captures = value;
//			LOG.info("anew captures:{0}",value.dump());
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  initialization
		//----------------------------------
		/**
		 * 
		 * @param the rowIndex you wanna set bit flag.
		 * @param the colIndex you wanna set big flag.
		 * @param the flag you wanna set(red is 0,blue is 1).
		 * @see mx.utils.BitFlagUtil#update
		 */
		public function initialization( rowIndex:int, colIndex:int,flag:int=0):void
		{
			//TODO: override function.
			throw new CcjErrors(CcjErrors.INITIALIZE_VIRTUAL_FUNCTION);
		}
		//----------------------------------
		//  X-ray attacks
		//----------------------------------
		//west
		protected function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			bb.setBitt(rowIndex,colIndex-1,Boolean(this.getBitt(rowIndex,colIndex-1)));
			return bb;
		}
		//north
		protected function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			bb.setBitt(rowIndex-1,colIndex,Boolean(this.getBitt(rowIndex-1,colIndex)));
			return bb;
		}
		//east
		protected function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			bb.setBitt(rowIndex,colIndex+1,Boolean(this.getBitt(rowIndex,colIndex+1)));
			return bb;
		}
		//south
		protected function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			bb.setBitt(rowIndex+1,colIndex,Boolean(this.getBitt(rowIndex+1,colIndex)));
			return bb;
		}
	}
}