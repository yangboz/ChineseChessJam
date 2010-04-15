package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.ZobristConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	import com.lookbackon.ds.ZobristHashTable;
	
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.HashTable;
	
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold chess board history table information.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class HistoryTableModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of HistoryTableModel;
		private static var instance:HistoryTableModel;
		private static const MAX_SIZE:int = MAX_SIZE;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(HistoryTableModel);
		//generation.
		//red
		private var _redRook:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_ROOK.key);
		private var _redKnight:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_KNIGHT.key);
		private var _redBishop:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_BISHOP.key);
		private var _redOffical:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_OFFICAL.key);
		private var _redMarshal:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_MARSHAL.key);
		private var _redCannon:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_CANNON.key);
		private var _redPawn:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_PAWN.key);
		//blue
		private var _blueRook:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_ROOK.key);
		private var _blueKnight:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_KNIGHT.key);
		private var _blueBishop:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_BISHOP.key);
		private var _blueOffical:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_OFFICAL.key);
		private var _blueMarshal:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_MARSHAL.key);
		private var _blueCannon:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_CANNON.key);
		private var _bluePawn:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_PAWN.key);
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function HistoryTableModel(access:Private)
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
		//  allPieces
		//----------------------------------
		public function get redRook():ZobristHashTable
		{
			return _redRook;
		}
		
		public function set redRook(value:ZobristHashTable):void
		{
			_redRook = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of HistoryTableModel
		 *
		 */
		public static function getInstance():HistoryTableModel 
		{
			if (instance == null) 
			{
				instance=new HistoryTableModel(new Private());
			}
			return instance;
		}
	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}