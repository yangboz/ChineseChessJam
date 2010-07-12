package com.lookbackon.AI.evaluation
{
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IEvaluation
	{
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
		function doEvaluation(conductVO:ConductVO,gamePosition:PositionVO):int;
	}
}