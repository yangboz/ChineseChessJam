package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ds.BitBoard;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
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
		public var bluePawns:BitBoard;//14
		public var blueCastles:BitBoard;//12
		public var blueKnights:BitBoard;//11
		public var blueBishops:BitBoard;//10
		public var blueOfficals:BitBoard;//9
		public var blueMarshal:BitBoard;//8
		public var blueCannons:BitBoard;//13
		//red
		public var redPawns:BitBoard;//22
		public var redCastles:BitBoard;//20
		public var redKnights:BitBoard;//19
		public var redBishops:BitBoard;//18
		public var redOfficals:BitBoard;//17
		public var redMarshal:BitBoard;//16
		public var redCannons:BitBoard;//21
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
					allPieces = new Vector.<int>(90,true);
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
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
		public static function getInstance():ChessPositionModelLocator {
			if (instance == null) {
				instance=new ChessPositionModelLocator(new Private());
			}
			return instance;
		}

	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private {
}