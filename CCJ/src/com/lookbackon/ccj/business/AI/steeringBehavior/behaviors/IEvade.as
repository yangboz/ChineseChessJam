package com.lookbackon.ccj.business.AI.steeringBehavior.behaviors
{
	import com.lookbackon.ccj.business.AI.steeringBehavior.VehicleSample;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public interface IEvade
	{
		function evade(target:VehicleSample):void;
	}
}