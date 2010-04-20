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
	 * <b>A singleton model hold chess board opening book information.</b></p>
	 * Whether you like it or not,opening book are very important in many games.
	 * Some games already have a large body of thory produced by humams(e.g. chess,checker),
	 * for other games,particularly for relatively new or less popular games, there is nothing to go on. 
	 * For those games where humans are competitive (like in chess), 
	 * there is a simple approach to generating an opening book: produce it manually, 
	 * selecting moves played by strong players. 
	 * This type of approach is obivously not very interesting for our purposes, 
	 * and for games where there is no theory or where computers are already superior to humans (like checkers), 
	 * it is impossible or pointless. I will only look at approaches to generating books without manual intervention.</p>
	 * 
	 * <b>Automated generation from a database</b></p>
	 * A simple way to generate an opening book is to take a database of games,
	 * and select promising moves based on the results of games in that database.</p>
	 * 
	 * <b>Automated computation by drop-out expansion</b></p>
	 * If there is no human theory available, then you will have to compute an opening book with your program itself. </p>
	 * 
	 * <b>DOE in the real world</b></p>
	 * DOE is a relatively new technique and has been applied successfully to checkers (by Ed Gilbert and Fierz) and Awari (by Thomas Lincke).</p>
	 * 
	 * @see http://www.fierz.ch/strategy4.htm
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class OpeningBookModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of OpeningBookModel;
		private static var instance:OpeningBookModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(OpeningBookModel);
		//generation.
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function OpeningBookModel(access:Private)
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
		 * @return the singleton instance of OpeningBookModel
		 *
		 */
		public static function getInstance():OpeningBookModel 
		{
			if (instance == null) 
			{
				instance=new OpeningBookModel(new Private());
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