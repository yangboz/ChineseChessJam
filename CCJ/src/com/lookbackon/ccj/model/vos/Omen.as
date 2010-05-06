package com.lookbackon.ccj.model.vos
{
	/**
	 * 
	 * @author RoYan
	 */
	public class Omen
	{
		public var threat:int = 0;		//The number of pieces this piece can kill, now point;
		public var threaten:int = 0;	//The number of pieces which can kill this piece, now point.
		
		public var newThreat:int = 0;	//The number of pieces this piece can kill, new point;
		public var newThreaten:int = 0;//The number of pieces which can kill this piece, new point;
		
		public var killed:int = 0;		//The number of pieces was killed by this piece.
		public var moved:int;			//The times of this piece was moved;
		
		public function Omen()
		{
			
		}
	}
}