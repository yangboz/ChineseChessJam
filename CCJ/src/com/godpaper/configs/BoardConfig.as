package com.godpaper.configs
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * BoardConfig.as class.Global board configuration,(which one) set up at application's initialization stage.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 19, 2011 2:20:20 PM
	 */   	 
	public class BoardConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//global board config.
		private static var _xLines:Number;
		private static var _yLines:Number;
		//board scale
		private static var _xScale:Number;
		private static var _yScale:Number;
		//board lattic
		private static var _xOffset:Number;
		private static var _yOffset:Number;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public static function get yOffset():Number
		{
			return _yOffset;
		}
		
		public static function set yOffset(value:Number):void
		{
			_yOffset = value;
		}
		//
		public static function get xOffset():Number
		{
			return _xOffset;
		}
		
		public static function set xOffset(value:Number):void
		{
			_xOffset = value;
		}
		//
		public static function get yLines():Number
		{
			return _yLines;
		}
		
		public static function set yLines(value:Number):void
		{
			_yLines = value;
		}
		//
		public static function get xLines():Number
		{
			return _xLines;
		}
		
		public static function set xLines(value:Number):void
		{
			_xLines = value;
		}
		//
		public static function get yScale():Number
		{
			return _yScale;
		}
		
		public static function set yScale(value:Number):void
		{
			_yScale = value;
		}
		//
		public static function get xScale():Number
		{
			return _xScale;
		}
		
		public static function set xScale(value:Number):void
		{
			_xScale = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

	}
	
}