package com.lookbackon.ccj
{
	import com.lookbackon.ccj.utils.Enum;
	/**
	 * <b>ChessPieces value/label global setting</b></p>
	 * 1.label for labeling chess pieces button;</p>
	 * 2.value for chess pieces' evaluation;</p>
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	final public class ChessPiecesConstants extends Enum
	{
		{initEnum(ChessPiecesConstants);}//static construct.
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//chessPieceType
		//blue(at top)
		public static const BLUE_PAWN:ChessPiecesConstants 		= new ChessPiecesConstants("p",22,30);//pawn-
		public static const BLUE_ROOK:ChessPiecesConstants 		= new ChessPiecesConstants("r",20,600);//castle-
		public static const BLUE_KNIGHT:ChessPiecesConstants	= new ChessPiecesConstants("k",19,270);//knight-
		public static const BLUE_BISHOP:ChessPiecesConstants	= new ChessPiecesConstants("b",18,120);//bishop-
		public static const BLUE_OFFICAL:ChessPiecesConstants 	= new ChessPiecesConstants("o",16,120);//offcial-
		public static const BLUE_MARSHAL:ChessPiecesConstants	= new ChessPiecesConstants("m",17,600);//marshal-
		public static const BLUE_CANNON:ChessPiecesConstants	= new ChessPiecesConstants("c",21,285);//cannon-
		//red(at bottom)
		public static const RED_PAWN:ChessPiecesConstants 		= new ChessPiecesConstants("P",14,30);//pawn+
		public static const RED_ROOK:ChessPiecesConstants 		= new ChessPiecesConstants("R",12,600);//castle+
		public static const RED_KNIGHT:ChessPiecesConstants		= new ChessPiecesConstants("K",11,270);//knight+
		public static const RED_BISHOP:ChessPiecesConstants		= new ChessPiecesConstants("B",10,120);//bishop+
		public static const RED_OFFICAL:ChessPiecesConstants 	= new ChessPiecesConstants("O",8,120);//offcial+
		public static const RED_MARSHAL:ChessPiecesConstants	= new ChessPiecesConstants("M",9,600);//marshal+
		public static const RED_CANNON:ChessPiecesConstants		= new ChessPiecesConstants("C",13,285);//cannon+
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		//
		public var label:String;//for labeling on chess pieces.
		public var value:int;//B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；
							 //C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
		public var strength:int;//Piece: King Assistant Elephant Rook Horse Cannon Pawn
								 //Value: 6000 120 		120 	 600  270    285    30
		public function ChessPiecesConstants(label:String,value:int,strength:int=-1)
		{
			this.label = label;
			this.value = value;
			this.strength = strength;
		}
	}
}
