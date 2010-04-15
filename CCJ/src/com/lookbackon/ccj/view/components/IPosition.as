package com.lookbackon.ccj.view.components
{
	import flash.geom.Point;

	/**
	 * The interface of chess piece and chess gasket.  
	 * @author knight.zhou
	 * 
	 */	
	public interface IPosition
	{
		function set position(value:Point):void;
		function get position():Point;
	}
}