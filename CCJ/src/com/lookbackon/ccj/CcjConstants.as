package com.lookbackon.ccj
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CcjConstants
	{
		//about chess board
		public static const CHESS_BOARD_VIEW_SCALE_XY:Number = 1.5;
		public static const CHESS_BOARD_H_LINES:int  = 9;
		public static const CHESS_BOARD_V_LINES:int  = 10;
		//chessPieceType
		//blue
		public static const BLUE_PAWN:ChessObject 		= new ChessObject("pawn-",22);
		public static const BLUE_CASTLE:ChessObject 	= new ChessObject("castle-",20);
		public static const BLUE_KNIGHT:ChessObject		= new ChessObject("knight-",19);
		public static const BLUE_BISHOP:ChessObject		= new ChessObject("bishop-",18);
		public static const BLUE_OFFICAL:ChessObject 	= new ChessObject("offcial-",16);
		public static const BLUE_MARSHAL:ChessObject	= new ChessObject("marshal-",17);
		public static const BLUE_CANNON:ChessObject		= new ChessObject("cannon-",21);
		//red
		public static const RED_PAWN:ChessObject 		= new ChessObject("pawn+",14);
		public static const RED_CASTLE:ChessObject 		= new ChessObject("castle+",12);
		public static const RED_KNIGHT:ChessObject		= new ChessObject("knight+",11);
		public static const RED_BISHOP:ChessObject		= new ChessObject("bishop+",10);
		public static const RED_OFFICAL:ChessObject 	= new ChessObject("offcial+",8);
		public static const RED_MARSHAL:ChessObject		= new ChessObject("marshal+",9);
		public static const RED_CANNON:ChessObject		= new ChessObject("cannon+",13);
		//about p2p
		public static const STRATUS_ADDRESS:String 	= "rtmfp://stratus.adobe.com/";
		public static const STRATUS_DEV_KEY:String  = "40a1c5b634bc4f531ad7757f-2e3cf422214e";
	}
}
internal class ChessObject
{
	public var label:String;//
	public var value:int;//B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；//C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
	public function ChessObject(lable:String,value:int)
	{
		this.label = label;
		this.value = value;
	}
}