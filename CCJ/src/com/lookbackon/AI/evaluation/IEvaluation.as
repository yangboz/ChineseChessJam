package com.lookbackon.AI.evaluation
{
	import com.lookbackon.ccj.model.vos.ConductVO;
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
		function doEvaluation(conductVO:ConductVO):int;
	}
}