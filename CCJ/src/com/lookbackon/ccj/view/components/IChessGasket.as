package com.lookbackon.ccj.view.components
{
	import mx.core.IVisualElement;

	/**
	 * The interface of ChessGasket.
	 * @author Knight.zhou
	 * 
	 */	
	public interface IChessGasket extends IVisualElement
	{
		function set position(value:Array):void;
		function get position():Array;
	}
}