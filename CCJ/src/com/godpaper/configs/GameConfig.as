package com.godpaper.configs
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * GameConfig.as class. Global game configuration,(which one) set up at application's initialization stage.     	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 20, 2011 11:34:56 AM
	 */   	 
	public class GameConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//global game config.
		private static var _turnFlag:int;
		private static var _tollgates:Array;
		private static var _tollgateTips:Array;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  tollgateTips(read-write)
		//----------------------------------
		public static function get tollgateTips():Array
		{
			return _tollgateTips;
		}
		public static function set tollgateTips(value:Array):void
		{
			_tollgateTips = value;
		}
		//----------------------------------
		//  tollgates(read-write)
		//----------------------------------
		public static function get tollgates():Array
		{
			return _tollgates;
		}
		public static function set tollgates(value:Array):void
		{
			_tollgates = value;
		}
		//----------------------------------
		//  turnFlag(read-write)
		//----------------------------------
		public static function get turnFlag():int
		{
			return _turnFlag;
		}
		public static function set turnFlag(value:int):void
		{
			_turnFlag = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
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