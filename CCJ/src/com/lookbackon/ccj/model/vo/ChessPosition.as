package com.lookbackon.ccj.model.vo
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPosition
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//generation.
		public var allPieces:BitBoard;
		public var player:int;//1:blue,0:red;
		//blue
		public var bluePawns:BitBoard;
		public var blueCastles:BitBoard;
		public var blueKnihgts:BitBoard;
		public var blueBishops:BitBoard;
		public var blueOfficals:BitBoard;
		public var blueMarshal:BitBoard;
		public var blueCannons:BitBoard;
		//red
		public var redPawns:BitBoard;
		public var redCastles:BitBoard;
		public var redKnihgts:BitBoard;
		public var redBishops:BitBoard;
		public var redOfficals:BitBoard;
		public var redMarshal:BitBoard;
		public var redCannons:BitBoard;
		//TODO.other structs.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
	}
}