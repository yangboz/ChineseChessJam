package com.godpaper.consts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * DefaultConstants.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 5:15:29 PM
	 */   	 
	public class DefaultConstants
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//about chess pieces' flag
		public static const FLAG_RED:int=0;
		public static const FLAG_BLUE:int=1;
		//
		public static const COLOR_RED:String="red"; //above;
		public static const COLOR_BLUE:String="blue"; //below;
		//chess pieces type consts
		public static const BLUE:String="BLUE";
		public static const RED:String="RED";
		//chess pieces state label
		public static const STATE_ATTACK:String="Attack";
		public static const STATE_DEFENCE:String="Defence";
		public static const STATE_NASCENCE:String="Nascence";
		public static const STATE_RENASCENCE:String="Renascence";
		//game states' label
		public static const STATE_HUMAN:String="HumanTurn";
		public static const STATE_ANOTHER_HUMAN:String="AnotherHumanTurn";
		public static const STATE_COMPUTER:String="ComputerTurn";
		public static const STATE_HUMAN_WIN:String="HumanWin";
		public static const STATE_COMPUTER_WIN:String="ComputerWin";
		//indications
		public static const INDICATION_THINK:String="Thinking..";
		public static const INDICATION_CHECK:String="Eschequier";
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 

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
		public function DefaultConstants()
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

