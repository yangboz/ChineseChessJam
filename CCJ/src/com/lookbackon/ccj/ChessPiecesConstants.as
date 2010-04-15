package com.lookbackon.ccj
{
	import com.lookbackon.ccj.utils.Enum;
	/**
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
		public static const BLUE_PAWN:ChessPiecesConstants 		= new ChessPiecesConstants("p",22);//pawn-
		public static const BLUE_ROOK:ChessPiecesConstants 		= new ChessPiecesConstants("r",20);//castle-
		public static const BLUE_KNIGHT:ChessPiecesConstants	= new ChessPiecesConstants("k",19);//knight-
		public static const BLUE_BISHOP:ChessPiecesConstants	= new ChessPiecesConstants("b",18);//bishop-
		public static const BLUE_OFFICAL:ChessPiecesConstants 	= new ChessPiecesConstants("o",16);//offcial-
		public static const BLUE_MARSHAL:ChessPiecesConstants	= new ChessPiecesConstants("m",17);//marshal-
		public static const BLUE_CANNON:ChessPiecesConstants	= new ChessPiecesConstants("c",21);//cannon-
		//red(at bottom)
		public static const RED_PAWN:ChessPiecesConstants 		= new ChessPiecesConstants("P",14);//pawn+
		public static const RED_ROOK:ChessPiecesConstants 		= new ChessPiecesConstants("R",12);//castle+
		public static const RED_KNIGHT:ChessPiecesConstants		= new ChessPiecesConstants("K",11);//knight+
		public static const RED_BISHOP:ChessPiecesConstants		= new ChessPiecesConstants("B",10);//bishop+
		public static const RED_OFFICAL:ChessPiecesConstants 	= new ChessPiecesConstants("O",8);//offcial+
		public static const RED_MARSHAL:ChessPiecesConstants	= new ChessPiecesConstants("M",9);//marshal+
		public static const RED_CANNON:ChessPiecesConstants		= new ChessPiecesConstants("C",13);//cannon+
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		//
		public var label:String;//for labeling on chess pieces.
		public var value:int;//B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；//C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
		public function ChessPiecesConstants(label:String,value:int)
		{
			this.label = label;
			this.value = value;
		}
	}
}
