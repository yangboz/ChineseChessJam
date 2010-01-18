package com.lookbackon.ccj.business.AI.steeringBehavior.behaviors
{
	import com.lookbackon.ccj.business.AI.steeringBehavior.Vector2D;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public interface ISeek
	{
		function seek(target:Vector2D):void;
	}
}