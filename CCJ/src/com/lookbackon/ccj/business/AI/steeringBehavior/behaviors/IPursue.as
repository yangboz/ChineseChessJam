package com.lookbackon.ccj.business.AI.steeringBehavior.behaviors
{
	import com.lookbackon.ccj.business.AI.steeringBehavior.VehicleSample;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public interface IPursue
	{
		function pursue(target:VehicleSample):void;
	}
}