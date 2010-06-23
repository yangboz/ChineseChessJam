package com.lookbackon.ccj.model.vos
{
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	/**
	 * This conduct entity model with basic information as follows:</p>
	 * 1.moved chess prototype(ChessPieces);</br>
	 * 2.moved destination position(Point(x,y));</br>
	 * 3.a brevity string such as "Pg3g4(兵3进4)";</br>
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public class ConductVO extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _target:ChessPiece;  
		private var _newPosition:Point=new Point(-1,-1);
		private var _brevity:String="";
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  target(read-write)
		//----------------------------------
		public function get target():ChessPiece
		{
			return _target;
		}
		public function set target(value:ChessPiece):void
		{
			_target = value;
			//update brevity.
			_brevity = _brevity.concat(value.name);
			_brevity = _brevity.concat(value.position.x,value.position.y);
		}
		//----------------------------------
		//  newPosition(read-write)
		//----------------------------------
		public function get newPosition():Point
		{
			return _newPosition;
		}
		public function set newPosition(value:Point):void
		{
			_newPosition = value;
			//update brevity.
			_brevity = _brevity.concat(value.x,value.y);
		}
		//----------------------------------
		//  brevity(read-only)
		//----------------------------------
		public function get brevity():String
		{
			return _brevity;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Prints out all elements (for debug/demo purposes).
		 * 
		 * @return A human-readable representation of the structure.
		 */
		public function dump():String
		{
			var s:String = "ConductVO";
			s += "\n{";
			s += "\n" + "\t";
			s += "target:"+target
				+","+"oldPosition:"+target.position.toString()
				+","+"newPosition:"+newPosition.toString()
				+","+"brevity:"+brevity.toString();
			s += "\n}";
			return s;
		}
		
	}
}
