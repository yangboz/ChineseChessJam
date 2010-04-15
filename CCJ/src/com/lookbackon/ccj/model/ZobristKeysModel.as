package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.ZobristConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ds.ZobristHashTable;
	
	import de.polygonal.ds.Array3;
	import de.polygonal.ds.HashTable;
	
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold all Chess Board's tag info for Chess HistoryTable/OpeningBook.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ZobristKeysModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ZobristKeysModel;
		private static var instance:ZobristKeysModel;
		//
		private var _redRook:ZobristKey = new ZobristKey();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ZobristKeysModel);
		//generation.
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ZobristKeysModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  redRook
		//----------------------------------
		public function get redRook():ZobristKey
		{
			return _redRook;
		}
		public function set redRook(value:ZobristKey):void
		{
			_redRook = value;
			HistoryTableModel.getInstance().redRook.insert(ZobristConstants.RED_ROOK.key,value);
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	

		/**
		 *
		 * @return the singleton instance of ZobristKeysModel
		 *
		 */
		public static function getInstance():ZobristKeysModel 
		{
			if (instance == null) 
			{
				instance=new ZobristKeysModel(new Private());
			}
			return instance;
		}
	}
}
import com.lookbackon.ccj.CcjConstants;
import com.lookbackon.ds.BitBoard;

/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}
internal class ZobristKey
{
	//chess colour bit board.
	public var color:BitBoard = new BitBoard(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
	//chess type bit board.
	public var type:BitBoard = new BitBoard(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
	//chess position bit board.
	public var position:BitBoard = new BitBoard(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
}