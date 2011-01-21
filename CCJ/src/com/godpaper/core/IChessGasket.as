package com.godpaper.core
{
	import mx.core.IVisualElement;

	/**
	 * The interface of ChessGasket.
	 *
	 * @author Knight.zhou
	 *
	 */	
	public interface IChessGasket extends IVisualElement,IPosition
	{
		function get chessPiece():IChessPiece;
		function set chessPiece(value:IChessPiece):void;
	}
}

