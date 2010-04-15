package com.lookbackon.ccj
{
	/**
	 * 
	 * @author knight.zhou
	 * 
	 */	
	public class CcjConstants
	{
		//global board config.
		public static const BOARD_H_LINES:int 		= 9;
		public static const BOARD_V_LINES:int		= 10;
		//about board style.
		public static const BOARD_SCALE_XY:Number	= 1.5;
		public static const BOARD_WIDTH:Number 		= 400*BOARD_SCALE_XY;
		public static const BOARD_HEIGHT:Number 	= 450*BOARD_SCALE_XY;
		public static const BOARD_LATTICE:Number	= 50*BOARD_SCALE_XY;
		//about chess pieces' flag
		public static const FLAG_RED:int  			= 0;
		public static const FLAG_BLUE:int 			= 1;
		//
		public static const COLOR_RED:String 		= "red";//above;
		public static const COLOR_BLUE:String 		= "blue";//below;
	}
}