package com.godpaper.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.model.ChessGasketsModel;
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.model.vos.PositionVO;
	import com.godpaper.views.components.ChessGasket;
	import com.godpaper.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;

	import flash.geom.Point;


	/**
	 * The chess piece manager(TwoHitOne) manage chess piece move's validation/makeMove/unMakeMove.</br>
	 * Also a way for the originator to be responsible for saving and restoring its states.</br>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 17, 2011 10:15:55 AM
	 */   	 
	public class ThoChessPieceManager extends CcjChessPieceManager
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 

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
		public function ThoChessPieceManager()
		{
			//TODO: implement function
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @inheritDoc
		 *
		 */		
		override public function applyMove(conductVO:ConductVO):void
		{
			//clean up firstly.
			super.currentRemovedPieces.length = 0;
			//
			var chessGasketModel:ChessGasketsModel = ChessGasketsModel.getInstance();
			var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
			//
			var rowOfGaskets:Array = chessGasketModel.gaskets.getRow(conductVO.nextPosition.y);
			var colOfGaskets:Array = chessGasketModel.gaskets.getCol(conductVO.nextPosition.x);
			//
//			var currentGasket:ChessGasket = chessGasketModel.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			//
			var roCounter:int=0;//capture organzier counter in row.
			var rtCounter:int=0;//capture target counter in row.
			for each( var rGasket:ChessGasket in rowOfGaskets)
			{
				if(rGasket.chessPiece)
				{
					if (conductVO.target.type == rGasket.chessPiece.type)
					{
						roCounter++;
					}else
					{
						rtCounter++;
					}
				}
			}
			if(roCounter==2 && rtCounter==1)
			{
				super.currentRemovedPieces.push( ChessGasket(rowOfGaskets[0]).chessPiece );
			}
			//
			var coCounter:int=0;//capture organzier counter in column.
			var ctCounter:int=0;//capture target counter in column.
			for each( var cGasket:ChessGasket in colOfGaskets)
			{
				if(cGasket.chessPiece)
				{
					if (conductVO.target.type == cGasket.chessPiece.type)
					{
						coCounter++;
					}else
					{
						ctCounter++;
					}
				}	
			}
			if(coCounter==2 && ctCounter==1)
			{
				super.currentRemovedPieces.push( ChessGasket(colOfGaskets[0]).chessPiece );
			}
			//

			//
			super.applyMove(conductVO);
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

