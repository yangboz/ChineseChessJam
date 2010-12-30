package com.lookbackon.AI.hierarchicalFiniteStateMachine
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.finiteStateMachine.Agent;
	import com.lookbackon.AI.finiteStateMachine.FiniteStateMachine;
	import com.lookbackon.AI.finiteStateMachine.states.IState;
	
	
	/**
	 * HierarchicalFiniteStateMachine.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 27, 2010 5:56:15 PM
	 */   	 
	public class HierarchicalFiniteStateMachine extends FiniteStateMachine implements IHierarchicalFiniteStateMachine
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
		public function HierarchicalFiniteStateMachine(owner:Agent, currentState:IState=null, previousState:IState=null, nextState:IState=null)
		{
			//TODO: implement function
			super(owner, currentState, previousState, nextState);
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function onMessage(message:Message):void
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