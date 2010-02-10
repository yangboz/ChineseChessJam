package com.lookbackon.AI.finiteStateMachine
{
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	
	/**
	 * The agent uses an instance of the FiniteStateMachine class the handle its AI.
	 * The agent class is a lot more manageable without the FSM implementation
	 * and all the states inside it. and must have a single FSM class
	 * that can be used by all agents(who)can even share states across agents too.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class Agent
	{
		private var fsm:FiniteStateMachine;
		public var name:String = "unnamed";
		public var carrier:IVisualElement;
		public var traceTarget:IVisualElement;
		/**
		 * 
		 * @param the name of agent;
		 * @param the carrier of agent;
		 * @param the agen's traceTarget;
		 * 
		 */		
		public function Agent(name:String,carrier:IVisualElement,traceTarget:IVisualElement=null)
		{
			fsm = new FiniteStateMachine(this);
			this.name = name;
			this.carrier = carrier;
			this.traceTarget = traceTarget;
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * delegate fsm to update; 
		 */		
		public function update():void
		{
			fsm.update();
		}
		/**
		 * 
		 * @return agent's FiniteStateMachine
		 * 
		 */		
		public function getFSM():FiniteStateMachine
		{
			return fsm;
		}
	}
}