package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import mx.collections.ArrayCollection;

	/**
	 * The basic chess game AI behaviors to be implemented.
	 * @author Knight.zhou
	 * @history before 2010-7-12 generateMoves/makeMove/unmakeMove/applyMove
	 * @history 2010-7-12 noneMove/willNoneMove.
	 * @history 2010-7-13 moves/captures/orderingMoves.
	 */	
	public interface ISearching
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		function get moves():Vector.<ConductVO>;
		function get captures():Vector.<ConductVO>;
		
		function set orderingMoves(value:Vector.<ConductVO>):void;
		function get orderingMoves():Vector.<ConductVO>;
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		function generateMoves(blues:Vector.<ChessPiece>):Vector.<ConductVO>;
		function makeMove(conductVO:ConductVO):void;
		function unmakeMove(conductVO:ConductVO):void;
		function applyMove(conductVO:ConductVO):void;
		//
		function noneMove():int;
		function willNoneMove(gamePosition:PositionVO):Boolean;
	}
}