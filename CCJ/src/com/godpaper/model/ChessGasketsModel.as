package com.godpaper.model
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.configs.BoardConfig;
	import com.godpaper.consts.CcjConstants;
	import com.godpaper.errors.CcjErrors;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.model.vos.PositionVO;
	import com.godpaper.model.vos.ccjVO.BishopVO;
	import com.godpaper.model.vos.ccjVO.CannonVO;
	import com.godpaper.model.vos.ccjVO.KnightVO;
	import com.godpaper.model.vos.ccjVO.MarshalVO;
	import com.godpaper.model.vos.ccjVO.OfficalVO;
	import com.godpaper.model.vos.ccjVO.PawnVO;
	import com.godpaper.model.vos.ccjVO.RookVO;
	import com.godpaper.utils.LogUtil;
	import com.godpaper.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;

	import de.polygonal.ds.Array2;

	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;


	/**
	 * ChessGasketsModel.as class. A singleton model hold all Chess gaskets' information.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 26, 2011 12:37:31 PM
	 */   	 
	public class ChessGasketsModel
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ChessGasketsModel;
		private static var instance:ChessGasketsModel;
		//
		private var _gaskets:Array2=new Array2(BoardConfig.xLines, BoardConfig.yLines);
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  gaskets
		//----------------------------------
		public function get gaskets():Array2
		{
			return _gaskets;
		}
		public function set gaskets(value:Array2):void
		{
			_gaskets = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessGasketsModel(access:Private)
		{
			if (access != null)
			{
				if (instance == null)
				{
					instance=this;
				}
			}
			else
			{
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @return the singleton instance of ChessGasketsModel
		 *
		 */
		public static function getInstance():ChessGasketsModel
		{
			if (instance == null)
			{
				instance=new ChessGasketsModel(new Private());
			}
			return instance;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private
{
}


