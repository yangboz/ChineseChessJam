package com.godpaper.business.managers
{
	import com.godpaper.model.ChessGasketsModel;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.utils.LogUtil;
	import com.godpaper.views.components.ChessGasket;
	import com.godpaper.views.components.ChessPiece;

	import mx.logging.ILogger;
	import com.godpaper.impl.ChessPieceManagerBase;

	/**
	 * The chess piece manager manage chess piece move's validation/makeMove/unMakeMove.</br>
	 * Also a way for the originator to be responsible for saving and restoring its states.</br>
	 * @author Knight.zhou
	 * @history 2010-12-02 using memento design pattern to implment make/unmake functions.
	 */
	public class CcjChessPieceManager extends ChessPieceManagerBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private const LOG:ILogger=LogUtil.getLogger(CcjChessPieceManager);

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//generation.
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//
		/**
		 * Apply make move data and piece entity change behaviors,to be overrided.
		 * @param conductVO
		 */
		override public function applyMove(conductVO:ConductVO):void
		{
			//clean up firstly.
			super.currentRemovedPieces.length = 0;
			//TODO:with roll back function support.
			var cGasket:ChessGasket=ChessGasketsModel.getInstance().gaskets.gett(conductVO.nextPosition.x, conductVO.nextPosition.y) as ChessGasket;
			if (cGasket.numElements >= 1)
			{
				//TODO:chess piece eat off.
				var removedPiece:ChessPiece=cGasket.getElementAt(0) as ChessPiece;
				LOG.info("Eat Off@{0} target:{1}", cGasket.position.toString(), removedPiece.toString());
				//
				currentRemovedPieces.push(removedPiece);
			}	
			//
			super.applyMove(conductVO);
		}

	}

}


