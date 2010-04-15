package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.ZobristConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
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
		//red
		private var _redRook:ZobristKeyVO 		= new ZobristKeyVO();
		private var _redKnight:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redBishop:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redOffical:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redMarshal:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redCannon:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redPawn:ZobristKeyVO 		= new ZobristKeyVO();
		//blue
		private var _blueRook:ZobristKeyVO 		= new ZobristKeyVO();
		private var _blueKnight:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueBishop:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueOffical:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueMarshal:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueCannon:ZobristKeyVO 	= new ZobristKeyVO();
		private var _bluePawn:ZobristKeyVO 		= new ZobristKeyVO();
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
		//  bluePawn
		//----------------------------------
		public function get bluePawn():ZobristKeyVO
		{
			return _bluePawn;
		}
		public function set bluePawn(value:ZobristKeyVO):void
		{
			_bluePawn = value;
		}
		//----------------------------------
		//  blueCannon
		//----------------------------------
		public function get blueCannon():ZobristKeyVO
		{
			return _blueCannon;
		}
		public function set blueCannon(value:ZobristKeyVO):void
		{
			_blueCannon = value;
		}
		//----------------------------------
		//  blueMarshal
		//----------------------------------
		public function get blueMarshal():ZobristKeyVO
		{
			return _blueMarshal;
		}
		public function set blueMarshal(value:ZobristKeyVO):void
		{
			_blueMarshal = value;
		}
		//----------------------------------
		//  blueOffical
		//----------------------------------
		public function get blueOffical():ZobristKeyVO
		{
			return _blueOffical;
		}
		public function set blueOffical(value:ZobristKeyVO):void
		{
			_blueOffical = value;
		}
		//----------------------------------
		//  blueBishop
		//----------------------------------
		public function get blueBishop():ZobristKeyVO
		{
			return _blueBishop;
		}
		public function set blueBishop(value:ZobristKeyVO):void
		{
			_blueBishop = value;
		}
		//----------------------------------
		//  blueKnight
		//----------------------------------
		public function get blueKnight():ZobristKeyVO
		{
			return _blueKnight;
		}
		public function set blueKnight(value:ZobristKeyVO):void
		{
			_blueKnight = value;
		}
		//----------------------------------
		//  blueRook
		//----------------------------------
		public function get blueRook():ZobristKeyVO
		{
			return _blueRook;
		}
		public function set blueRook(value:ZobristKeyVO):void
		{
			_blueRook = value;
		}
		//----------------------------------
		//  redPawn
		//----------------------------------
		public function get redPawn():ZobristKeyVO
		{
			return _redPawn;
		}
		public function set redPawn(value:ZobristKeyVO):void
		{
			_redPawn = value;
		}
		//----------------------------------
		//  redCannon
		//----------------------------------
		public function get redCannon():ZobristKeyVO
		{
			return _redCannon;
		}
		public function set redCannon(value:ZobristKeyVO):void
		{
			_redCannon = value;
		}
		//----------------------------------
		//  redMarshal
		//----------------------------------
		public function get redMarshal():ZobristKeyVO
		{
			return _redMarshal;
		}
		public function set redMarshal(value:ZobristKeyVO):void
		{
			_redMarshal = value;
		}
		//----------------------------------
		//  redOffical
		//----------------------------------
		public function get redOffical():ZobristKeyVO
		{
			return _redOffical;
		}
		public function set redOffical(value:ZobristKeyVO):void
		{
			_redOffical = value;
		}
		//----------------------------------
		//  redBishop
		//----------------------------------
		public function get redBishop():ZobristKeyVO
		{
			return _redBishop;
		}
		public function set redBishop(value:ZobristKeyVO):void
		{
			_redBishop = value;
		}
		//----------------------------------
		//  redKnight
		//----------------------------------
		public function get redKnight():ZobristKeyVO
		{
			return _redKnight;
		}
		public function set redKnight(value:ZobristKeyVO):void
		{
			_redKnight = value;
		}
		//----------------------------------
		//  redRook
		//----------------------------------
		public function get redRook():ZobristKeyVO
		{
			return _redRook;
		}
		public function set redRook(value:ZobristKeyVO):void
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
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}
