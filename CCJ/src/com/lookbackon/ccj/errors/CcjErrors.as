package com.lookbackon.ccj.errors
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CcjErrors extends Error
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const INITIALIZE_VIRTUAL_FUNCTION:String  = "Virtual function initialized!!!";
		public static const INITIALIZE_SINGLETON_CLASS:String   = "Try initialize singleton class!!!";
		public static const INVALID_CHESS_VO:String 			= "Try initialize invalid chess value object!";
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function CcjErrors(message:*="", id:*=0)
		{
			//TODO: implement function
			super(message, id);
		}
	}
}