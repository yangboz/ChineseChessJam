package com.lookbackon.ccj.view.components
{
	import com.lookbackon.ccj.business.fsm.ChessAgent;
	
	import mx.core.IUIComponent;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IChessPiece extends IUIComponent
	{
		function set agent(value:ChessAgent):void;
		function get agent():ChessAgent;
	}
}