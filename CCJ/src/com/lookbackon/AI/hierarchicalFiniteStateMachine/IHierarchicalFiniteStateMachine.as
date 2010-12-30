package com.lookbackon.AI.hierarchicalFiniteStateMachine
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.finiteStateMachine.IFiniteStateMachine;
	
	
	/**
	 * IHierarchicalFiniteStateMachine.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 27, 2010 5:47:27 PM
	 */ 
	public interface IHierarchicalFiniteStateMachine extends IFiniteStateMachine
	{
		function onMessage(message:Message):void;
	}
}