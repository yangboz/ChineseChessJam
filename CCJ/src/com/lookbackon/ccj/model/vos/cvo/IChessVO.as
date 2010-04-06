package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ds.BitBoard;
	/**
	 * The interface of chess pieces,about occupy,moves,captures.
	 * 
	 * @author knight.zhou
	 * 
	 */	
	public interface IChessVO
	{
		//for initialization.
		function initialization(rowIndex:int, colIndex:int,flag:int=0):void;
		//spaces occupied by red/blue pieces:
		function set occupies(value:BitBoard):void;
		function get occupies():BitBoard;
		//legal moves for these chess types.
		function set moves(value:BitBoard):void;
		function get moves():BitBoard;
		//red/blue piece positions to compute captures.
		function set captures(value:BitBoard):void;
		function get captures():BitBoard;
	}
}