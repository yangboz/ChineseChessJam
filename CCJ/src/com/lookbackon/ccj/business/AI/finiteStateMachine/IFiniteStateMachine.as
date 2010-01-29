package com.lookbackon.ccj.business.AI.finiteStateMachine
{
	import com.lookbackon.ccj.business.AI.finiteStateMachine.states.IState;
	
	/**
	 * Our FiniteStateMachine must implment this interface.
	 * 
	 * @author Knight.zhou
	 * 
	 */    
	public interface IFiniteStateMachine
	{
		function set globalState(s:IState):void;
		function get globalState():IState;
		
		function set currentState(s:IState):void;
		function get currentState():IState;
		
		function set previousState(s:IState):void;
		function get previousState():IState;
		
		function set nextState(s:IState):void;
		function get nextState():IState;
	}
}