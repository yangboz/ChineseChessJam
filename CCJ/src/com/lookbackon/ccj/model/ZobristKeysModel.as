package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.ZobristConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ds.ZobristKey;
	
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold all Chess Piece's position info.
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
		
		private var _redRook:ZobristKey = new ZobristKey();														)

		public function get redRook():ZobristKey
		{
			return _redRook;
		}

		public function set redRook(value:ZobristKey):void
		{
			_redRook = value;
			LOG.info("redRook ZobristHashTable:{0}",value.dump(0));
		}

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