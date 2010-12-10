package com.lookbackon.ccj.business.fsm.states.game
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.finiteStateMachine.IAgent;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.fsm.StateBase;
	import com.lookbackon.ccj.managers.GameManager;
	
	
	/**
	 * HumanState.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 10, 2010 11:12:15 AM
	 */   	 
	public class HumanState extends StateBase
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
		public function HumanState(agent:IAgent, resource:Object, description:String=null)
		{
			//TODO: implement function
			super(agent, resource, description);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function enter():void
		{
			//hold turn flag
			GameManager.turnFlag = CcjConstants.FLAG_RED;
			//
			GameManager.indicatorReadOut=false;
			//about data
		}
		
		override public function exit():void
		{
			//TODO: implement function
		}
		
		override public function update(time:Number=0):void
		{
			//TODO: implement function
		}
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