package com.godpaper.configs
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * PluginConfig.as class.Global plugin(mochimedia,facebook,sns) configuration(gameID,boardID,etc..),(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 30, 2011 3:38:44 PM
	 */   	 
	public class PluginConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _mochiGameID:String;
		private static var _mochiBoardID:String;
		//
		public static var cirrusAddress:String="rtmfp://p2p.rtmfp.net/";
		public static var developerKey:String="40a1c5b634bc4f531ad7757f-2e3cf422214e";
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public static function get mochiBoardID():String
		{
			return _mochiBoardID;
		}

		public static function set mochiBoardID(value:String):void
		{
			_mochiBoardID = value;
		}
		//
		public static function get mochiGameID():String
		{
			return _mochiGameID;
		}

		public static function set mochiGameID(value:String):void
		{
			_mochiGameID = value;
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
		public function PluginConfig()
		{
		}     	
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

