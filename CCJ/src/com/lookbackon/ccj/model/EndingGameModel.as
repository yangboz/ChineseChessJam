package com.lookbackon.ccj.model
{
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
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold chess board opening book information.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class EndingGameModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of EndGameModel;
		private static var instance:EndingGameModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(EndingGameModel);
		//generation.
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function EndingGameModel(access:Private)
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
		 * @return the singleton instance of EndGameModel
		 *
		 */
		public static function getInstance():EndingGameModel 
		{
			if (instance == null) 
			{
				instance=new EndingGameModel(new Private());
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