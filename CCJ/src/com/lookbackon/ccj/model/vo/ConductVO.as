package com.lookbackon.ccj.model.vo
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import mx.core.IVisualElement;
	/**
	 * 
	 * @author knight.zhou
	 * 
	 */
	[Bindable]
	public class ConductVO extends EventDispatcher
	{
		public var target:IVisualElement;  
		public var newDest:Point;
		public var newPosition:Array;
		
		/**
		 * Prints out all elements (for debug/demo purposes).
		 * 
		 * @return A human-readable representation of the structure.
		 */
		public function dump():String
		{
			var s:String = "ConductVO{";
			s += "\n" + "\t";
			s += "target:"+target+","+"newDest:"+newDest+","+"newPosition:"+newPosition;
			s += "\n}";
			return s;
		}
	}
}
