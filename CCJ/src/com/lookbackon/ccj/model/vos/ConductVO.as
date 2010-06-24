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
	 * @history 2010-6-24,re-construct:newPositon to currentPosition,keep previousPosition.
	 */
	public class ConductVO extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _target:ChessPiece;  
		private var _prviousPosition:Point	=	new Point(-1,-1);
		//private var _currentPosition:Point  =  	new Point(-1,-1);
		private var _nextPosition:Point 	=	new Point(-1,-1);

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
		}
		//----------------------------------
		//  previousPosition(read-write)
		//----------------------------------
		public function get previousPosition():Point
		{
			return _prviousPosition;
		}
		public function set previousPosition(value:Point):void
		{
			_prviousPosition = value;
		}
		//----------------------------------
		//  brevity(read-only)
		//----------------------------------
		public function get brevity():String
		{
			//generate brevity.
			return _brevity.concat(target.name,previousPosition.x,previousPosition.y,nextPosition.x,nextPosition.y);;
		}
		//----------------------------------
		//  currentPosition(read-only)
		//----------------------------------
		public function get currentPosition():Point
		{
			return _target.position;
		}
		//----------------------------------
		//  nextPosition(read-write)
		//----------------------------------
		public function set nextPosition(value:Point):void
		{
			_nextPosition = value;
		}
		public function get nextPosition():Point
		{
			return _nextPosition;
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
			s += "target:"+target+","
				+"\n" + "\t"
				+"previousPosition:"+previousPosition.toString()+","
				+"\n" + "\t"
				+"currentPosition:"+currentPosition.toString()+","
				+"\n" + "\t"
				+"nextPosition:"+nextPosition.toString()+","
				+"\n" + "\t"
				+"brevity:"+brevity.toString();
			s += "\n}";
			return s;
		}
		
	}
}
