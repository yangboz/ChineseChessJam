package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.model.vos.ConductVO;
	import mx.collections.ArrayCollection;

	/**
	 * The basic gameAI behaviors to be implemented.
	 * @author Knight-errant
	 */	
	public interface ISearching
	{
		function generateMoves(blues:ArrayCollection):ArrayCollection;
		function makeMove(conductVO:ConductVO):void;
		function unmakeMove(conductVO:ConductVO):void;
	}
}