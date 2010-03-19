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
		public static const BLUE_PAWN:CcjConstants 		= new CcjConstants("pawn-",22);
		public static const BLUE_CASTLE:CcjConstants 	= new CcjConstants("castle-",20);
		public static const BLUE_KNIGHT:CcjConstants	= new CcjConstants("knight-",19);
		public static const BLUE_BISHOP:CcjConstants	= new CcjConstants("bishop-",18);
		public static const BLUE_OFFICAL:CcjConstants 	= new CcjConstants("offcial-",16);
		public static const BLUE_MARSHAL:CcjConstants	= new CcjConstants("marshal-",17);
		public static const BLUE_CANNON:CcjConstants	= new CcjConstants("cannon-",21);
		//red
		public static const RED_PAWN:CcjConstants 		= new CcjConstants("pawn+",14);
		public static const RED_CASTLE:CcjConstants 	= new CcjConstants("castle+",12);
		public static const RED_KNIGHT:CcjConstants		= new CcjConstants("knight+",11);
		public static const RED_BISHOP:CcjConstants		= new CcjConstants("bishop+",10);
		public static const RED_OFFICAL:CcjConstants 	= new CcjConstants("offcial+",8);
		public static const RED_MARSHAL:CcjConstants	= new CcjConstants("marshal+",9);
		public static const RED_CANNON:CcjConstants		= new CcjConstants("cannon+",13);
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
