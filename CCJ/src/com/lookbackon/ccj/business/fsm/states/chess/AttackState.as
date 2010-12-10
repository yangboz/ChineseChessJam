package com.lookbackon.ccj.business.fsm.states.chess
{
	import com.lookbackon.ccj.business.fsm.ChessAgent;
	import com.lookbackon.ccj.business.fsm.StateBase;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class AttackState extends StateBase
	{
		public function AttackState(agent:ChessAgent,resource:Object,description:String=null)
		{
			super(agent,resource,description);
		}
		override public function enter():void
		{
			//TODO: implement function
		}
		
		override public function exit():void
		{
			//TODO: implement function
		}
		
		override public function update(time:Number=0):void
		{
			//TODO: implement function
		}
	}
}