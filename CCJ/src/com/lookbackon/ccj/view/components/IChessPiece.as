package com.lookbackon.ccj.view.components
{
	import com.lookbackon.ccj.business.fsm.ChessAgent;
	
	import mx.core.IVisualElement;

	/**
	 * The interface of ChessPiece.
	 * @author Knight.zhou
	 * 
	 */	
	public interface IChessPiece extends IVisualElement
	{
		function set agent(value:ChessAgent):void;
		function get agent():ChessAgent;
	}
}