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
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const BLUE_PAWN:String 		= "-pawn";
		private static const BLUE_CASTLE:String 	= "-castle";
		private static const BLUE_KNIGHT:String		= "-knight";
		private static const BLUE_BISHOP:String		= "-bishop";
		private static const BLUE_OFFICAL:String 	= "-offcial";
		private static const BLUE_MARSHAL:String	= "-marshal";
		private static const BLUE_CANNON:String		= "-cannon";
		
		private static const RED_PAWN:String 		= "+pawn";
		private static const RED_CASTLE:String 		= "+castle";
		private static const RED_KNIGHT:String		= "+knight";
		private static const RED_BISHOP:String		= "+bishop";
		private static const RED_OFFICAL:String 	= "+offcial";
		private static const RED_MARSHAL:String		= "+marshal";
		private static const RED_CANNON:String		= "+cannon";
		//generation.
		//A. 0表示空格(没有棋子)；
		//B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；
		//C. 16~22依次表示黑方的将、士、象、马、车、炮和卒。
//		public var allPieces:BitBoard;
		public var allPieces:Vector.<int>;
		public var player:int;//1:blue,0:red;
		//blue
		public var bluePawns:BitBoard;//
		public var blueCastles:BitBoard;
		public var blueKnights:BitBoard;
		public var blueBishops:BitBoard;
		public var blueOfficals:BitBoard;
		public var blueMarshal:BitBoard;
		public var blueCannons:BitBoard;
		//red
		public var redPawns:BitBoard;
		public var redCastles:BitBoard;
		public var redKnights:BitBoard;
		public var redBishops:BitBoard;
		public var redOfficals:BitBoard;
		public var redMarshal:BitBoard;
		public var redCannons:BitBoard;
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPosition()
		{
			allPieces = new Vector.<int>(81,true);
			
		}
	}
}