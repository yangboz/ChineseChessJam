package com.lookbackon.ccj
{
	import com.lookbackon.ccj.utils.Enum;
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	final public class CcjConstants extends Enum
	{
		{initEnum(CcjConstants);}//static construct.
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//chessPieceType
		//blue
		public static const BLUE_PAWN:CcjConstants 		= new CcjConstants("p",22);//pawn-
		public static const BLUE_ROOK:CcjConstants 		= new CcjConstants("r",20);//castle-
		public static const BLUE_KNIGHT:CcjConstants	= new CcjConstants("k",19);//knight-
		public static const BLUE_BISHOP:CcjConstants	= new CcjConstants("b",18);//bishop-
		public static const BLUE_OFFICAL:CcjConstants 	= new CcjConstants("o",16);//offcial-
		public static const BLUE_MARSHAL:CcjConstants	= new CcjConstants("m",17);//marshal-
		public static const BLUE_CANNON:CcjConstants	= new CcjConstants("c",21);//cannon-
		//red
		public static const RED_PAWN:CcjConstants 		= new CcjConstants("P",14);//pawn+
		public static const RED_ROOK:CcjConstants 		= new CcjConstants("R",12);//castle+
		public static const RED_KNIGHT:CcjConstants		= new CcjConstants("K",11);//knight+
		public static const RED_BISHOP:CcjConstants		= new CcjConstants("B",10);//bishop+
		public static const RED_OFFICAL:CcjConstants 	= new CcjConstants("O",8);//offcial+
		public static const RED_MARSHAL:CcjConstants	= new CcjConstants("M",9);//marshal+
		public static const RED_CANNON:CcjConstants		= new CcjConstants("C",13);//cannon+
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		//
		public var label:String;//for labeling on chess pieces.
		public var value:int;//B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；//C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
		public function CcjConstants(label:String,value:int)
		{
			this.label = label;
			this.value = value;
		}
	}
}
