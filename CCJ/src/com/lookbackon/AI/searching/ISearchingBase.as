package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.model.vos.ConductVO;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;

	/**
	 * The basic gameAI behaviors to be implemented.
	 * @author Knight-errant
	 */	
	public interface ISearchingBase
	{
		function generateMoves(reds:ArrayCollection,gamePosition:Array2):ArrayCollection;
		function applyMovement(conductVO:ConductVO):Array2;
		function doEvaluation(conductVO:ConductVO):int;
	}
}