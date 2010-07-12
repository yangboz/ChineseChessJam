package com.lookbackon.ccj.business.command
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.lookbackon.ccj.events.GameEvent;
	import com.lookbackon.ccj.managers.GameManager;
	
	
	/**
	 * GameTurnCommand.as class.   	
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 12, 2010 11:01:03 AM
	 */   	 
	public class GameCommand implements Command
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
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
		public function GameCommand()
		{
			//TODO: implement function
		}
		
		public function execute(event:CairngormEvent):void
		{
			//TODO: implement function
			if(event.type==GameEvent.IS_COMPUTER_TURN_NOW)
			{
				GameManager.isComputerTurnNow();
			}else
			{
				GameManager.isHumanTurnNow();
			}
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