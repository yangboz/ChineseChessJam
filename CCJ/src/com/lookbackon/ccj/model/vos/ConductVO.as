package com.lookbackon.ccj.model.vos
{
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import flash.events.EventDispatcher;

	/**
	 * 
	 * @author knight.zhou
	 * 
	 */
	[Bindable]
	public class ConductVO extends EventDispatcher
	{
		public var target:ChessPiece;  
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
			s += "target:"+target+","+"newPosition:"+newPosition;
			s += "\n}";
			return s;
		}
	}
}
