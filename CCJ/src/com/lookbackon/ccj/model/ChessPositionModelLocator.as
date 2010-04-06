package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;

	/**
	 * A singleton model hold Chess Position.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	[Bindable]
	public class ChessPositionModelLocator
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ChessPositionModelLocator;
		private static var instance:ChessPositionModelLocator;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//generation.
		//
		private var _bluePieces:BitBoard;
		private var _redPieces:BitBoard;
		//special.
		//red
		private var _redRook:BitBoard;
		private var _redKnight:BitBoard;
		private var _redBishop:BitBoard;
		private var _redOffical:BitBoard;
		private var _redMarshal:BitBoard;
		private var _redCannon:BitBoard;
		private var _redPawn:BitBoard;
		//blue
		private var _blueRook:BitBoard;
		private var _blueKnight:BitBoard;
		private var _blueBishop:BitBoard;
		private var _blueOffical:BitBoard;
		private var _blueMarshal:BitBoard;
		private var _blueCannon:BitBoard;
		private var _bluePawn:BitBoard;
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPositionModelLocator(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
//					allPieces = new Vector.<int>(90,true);
//					allPieces = new Array2(9,10);
					//red
					redRook = new BitBoard(9,10);
					redKnight = new BitBoard(9,10);
					redBishop = new BitBoard(9,10);
					redOffical = new BitBoard(9,10);
					redMarshal = new BitBoard(9,10);
					redCannon = new BitBoard(9,10);
					redPawn = new BitBoard(9,10);
					//blue
					blueRook = new BitBoard(9,10);
					blueKnight = new BitBoard(9,10);
					blueBishop = new BitBoard(9,10);
					blueOffical = new BitBoard(9,10);
					blueMarshal = new BitBoard(9,10);
					blueCannon = new BitBoard(9,10);
					bluePawn = new BitBoard(9,10);
					//
					redPieces = new BitBoard(9,10);
					bluePieces = new BitBoard(9,10);
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  allPieces
		//----------------------------------
		/**
		 * 
		 * @return our bitboard:(allPieces)
		 * ---------
		 * rkbomobkr
		 * .........
		 * .c.....c.
		 * p.p.p.p.p
		 * .........
		 * ......... 
		 * P.P.P.P.P
		 * .C.....C.
		 * .........
		 * RKBOMOBKR
		 * ---------
		 * 
		 */		
		public function get allPieces():BitBoard
		{
			return redPieces.or(bluePieces);
		}
		//----------------------------------
		//  bluePieces
		//----------------------------------
		/**
		 * 
		 * @return a BitBoard as follows:
		 * ---------
		 * 000000000
		 * 000000000
		 * 000000000
		 * 000000000
		 * 101010101
		 * 010000010
		 * 000000000
		 * 111111111
		 * ---------
		 * 
		 */		
		public function get bluePieces():BitBoard
		{
			return blueRook.or(blueKnight.or(blueBishop.or(blueOffical.or(blueMarshal.or(blueCannon.or(bluePawn))))));
		}
		/**
		 * 
		 * @param value a BitBoard representation of bluePieces.
		 * 
		 */		
		public function set bluePieces(value:BitBoard):void
		{
			_bluePieces = value;
		}
		//----------------------------------
		//  redPieces
		//----------------------------------
		/**
		 * 
		 * @return a BitBoard as follows:
		 * ---------
		 * 111111111
		 * 000000000
		 * 010000010
		 * 000000000
		 * 101010101
		 * 000000000
		 * 000000000
		 * 000000000
		 * 000000000
		 * ---------
		 * 
		 */		
		public function get redPieces():BitBoard
		{
			return redRook.or(redKnight.or(redBishop.or(redOffical.or(redMarshal.or(redCannon.or(redPawn))))));
		}
		/**
		 * 
		 * @param value a BitBoard representation of redPieces.
		 * 
		 */		
		public function set redPieces(value:BitBoard):void
		{
			_redPieces = value;
		}
		//----------------------------------
		//  redRook
		//----------------------------------
		public function get redRook():BitBoard
		{
			return _redRook;
		}
		public function set redRook(value:BitBoard):void
		{
			_redRook = value;
		}
		//----------------------------------
		//  redKnight
		//----------------------------------
		public function get redKnight():BitBoard
		{
			return _redKnight;
		}
		public function set redKnight(value:BitBoard):void
		{
			_redKnight = value;
		}
		//----------------------------------
		//  redBishop
		//----------------------------------
		public function get redBishop():BitBoard
		{
			return _redBishop;
		}
		public function set redBishop(value:BitBoard):void
		{
			_redBishop = value;
		}
		//----------------------------------
		//  redOffical
		//----------------------------------
		public function get redOffical():BitBoard
		{
			return _redOffical;
		}
		public function set redOffical(value:BitBoard):void
		{
			_redOffical = value;
		}
		//----------------------------------
		//  redMarshal
		//----------------------------------
		public function get redMarshal():BitBoard
		{
			return _redMarshal;
		}
		public function set redMarshal(value:BitBoard):void
		{
			_redMarshal = value;
		}
		//----------------------------------
		//  redCannon
		//----------------------------------
		public function get redCannon():BitBoard
		{
			return _redCannon;
		}
		public function set redCannon(value:BitBoard):void
		{
			_redCannon = value;
		}
		//----------------------------------
		//  redPawn
		//----------------------------------
		public function get redPawn():BitBoard
		{
			return _redPawn;
		}
		public function set redPawn(value:BitBoard):void
		{
			_redPawn = value;
		}
		//----------------------------------
		//  blueRook
		//----------------------------------
		public function get blueRook():BitBoard
		{
			return _blueRook;
		}
		public function set blueRook(value:BitBoard):void
		{
			_blueRook = value;
		}
		//----------------------------------
		//  blueKnight
		//----------------------------------
		public function get blueKnight():BitBoard
		{
			return _blueKnight;
		}
		public function set blueKnight(value:BitBoard):void
		{
			_blueKnight = value;
		}
		//----------------------------------
		//  blueBishop
		//----------------------------------
		public function get blueBishop():BitBoard
		{
			return _blueBishop;
		}
		public function set blueBishop(value:BitBoard):void
		{
			_blueBishop = value;
		}
		//----------------------------------
		//  blueOffical
		//----------------------------------
		public function get blueOffical():BitBoard
		{
			return _blueOffical;
		}
		public function set blueOffical(value:BitBoard):void
		{
			_blueOffical = value;
		}
		//----------------------------------
		//  blueMarshal
		//----------------------------------
		public function get blueMarshal():BitBoard
		{
			return _blueMarshal;
		}
		public function set blueMarshal(value:BitBoard):void
		{
			_blueMarshal = value;
		}
		//----------------------------------
		//  blueCannon
		//----------------------------------
		public function get blueCannon():BitBoard
		{
			return _blueCannon;
		}
		public function set blueCannon(value:BitBoard):void
		{
			_blueCannon = value;
		}
		//----------------------------------
		//  bluePawn
		//----------------------------------
		public function get bluePawn():BitBoard
		{
			return _bluePawn;
		}
		public function set bluePawn(value:BitBoard):void
		{
			_bluePawn = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of ChessPositionModelLocator
		 *
		 */
		public static function getInstance():ChessPositionModelLocator 
		{
			if (instance == null) 
			{
				instance=new ChessPositionModelLocator(new Private());
			}
			return instance;
		}
	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}