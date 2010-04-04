package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.errors.CcjErrors;
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
		private var _allPieces:BitBoard;
//		public var allPieces:Vector.<int>;
		public var player:int;//1:blue,0:red;
		//
		private var _bluePieces:BitBoard;
		private var _redPieces:BitBoard;
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
					allPieces = new BitBoard(10,9);
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
			return _allPieces;
		}
		/**
		 * 
		 * @param value a BitBoard representation of allPieces.
		 * 
		 */		
		public function set allPieces(value:BitBoard):void
		{
			_allPieces = value;
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
			return _bluePieces;
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
			return _redPieces;
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