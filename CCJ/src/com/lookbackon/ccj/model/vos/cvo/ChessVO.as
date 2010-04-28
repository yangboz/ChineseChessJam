package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.ChessPiecesModel;
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
	 * </p>
	 * <strong>about X-ray attacks</strong></p>
	 * Here is another type of double attack in which the targets are threatened in one direction. </p>
	 * The attacking piece threatens two units, one behind the other, </p>
	 * on the same rank, file or diagonal. This double threat has lacked a good descriptive name. </p>
	 * We suggest ‘X-Ray’ attack.</p>
	 * 
	 * The classical approach works ray-wise and uses pre-calculated ray-attacks </p>
	 * for each of the eight ray-directions and each of the 64 squares. </p>
	 * It has to distinguish between positive and negative directions, </p>
	 * because it has to bitscan the ray-attack intersection with the occupancy in different orders. </p>
	 * That usually don't cares for getting line- or piece attacks, </p>
	 * since one likely unrolls all directions needed for a particular line or piece - otherwise one may rely on a generalized bitscan.</p>
	 * 
	 * @see http://chessprogramming.wikispaces.com/X-ray+Attacks
	 * @see http://chessprogramming.wikispaces.com/Classical+Approach
	 * 
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
		//for Rook/Cannon condition filter.
		protected var blocker:BitBoard;
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
		/**
		 * 
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under west direction.
		 * 
		 */	
		protected function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=colIndex-1;w>=0;w--)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex,w)) break;
				bb.setBitt(rowIndex,w,true);
			}
			return bb;
		}
		/**
		 * 
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under north direction.
		 * 
		 */	
		//north
		protected function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var n:int=rowIndex-1;n>=0;n--)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(n,colIndex)) break;
				bb.setBitt(n,colIndex,true);
			}
			return bb;
		}
		/**
		 * 
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under east direction.
		 * 
		 */	
		//east
		protected function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var e:int=colIndex+1;e<this.column;e++)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex,e)) break;
				bb.setBitt(rowIndex,e,true);
			}
			return bb;
		}
		/**
		 * 
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under south direction.
		 * 
		 */	
		//south
		protected function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var s:int=rowIndex+1;s<this.row;s++)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(s,colIndex)) break;
				bb.setBitt(s,colIndex,true);
			}
			return bb;
		}
	}
}