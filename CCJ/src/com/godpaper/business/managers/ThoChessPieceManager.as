package com.godpaper.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.impl.ChessPieceManagerBase;
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
	public class ThoChessPieceManager extends ChessPieceManagerBase
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
			var currentGasket:ChessGasket = chessGasketModel.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			//
			var roCounter:int=0;//capture organzier counter in row.
			var rtCounter:int=0;//capture target counter in row.
			var rtGasket:ChessGasket;//captured chess gasket.
			var roGasket:ChessGasket//capture organzier gasket in row.
			for each( var rGasket:ChessGasket in rowOfGaskets)
			{
				if(rGasket.chessPiece)
				{
					if (conductVO.target.type == rGasket.chessPiece.type)
					{
						roCounter++;
						//
						roGasket = rGasket;
					}else
					{
						rtCounter++;
						//
						rtGasket = rGasket;
					}
				}
			}
			if(roCounter==1 && rtCounter==1)
			{
				trace("row t:",rtGasket.position,"o:",currentGasket.position,"o':",roGasket.position);
				if(rtGasket == currentGasket.rightNode &&  roGasket == currentGasket.leftNode)//o'-o-t
				{
					super.currentRemovedPieces.push( ChessGasket(rowOfGaskets[0]).chessPiece );
				}
				if(rtGasket == currentGasket.rightNode.rightNode &&  roGasket == currentGasket.rightNode)//o-o'-t
				{
					super.currentRemovedPieces.push( ChessGasket(rowOfGaskets[0]).chessPiece );
				}
				if(rtGasket == currentGasket.leftNode &&  roGasket == currentGasket.rightNode)//t-o-o'
				{
					super.currentRemovedPieces.push( ChessGasket(rowOfGaskets[0]).chessPiece );
				}
				if(rtGasket == currentGasket.leftNode.leftNode &&  roGasket == currentGasket.leftNode)//t-o'-o
				{
					super.currentRemovedPieces.push( ChessGasket(rowOfGaskets[0]).chessPiece );
				}
			}
			//
			var coCounter:int=0;//capture organzier counter in column.
			var ctCounter:int=0;//capture target counter in column.
			var ctGasket:ChessGasket;//captured chess gasket.
			var coGasket:ChessGasket//capture organzier gasket in column.
			for each( var cGasket:ChessGasket in colOfGaskets)
			{
				if(cGasket.chessPiece)
				{
					if (conductVO.target.type == cGasket.chessPiece.type)
					{
						coCounter++;
						//
						coGasket = cGasket;
					}else
					{
						ctCounter++;
						//
						ctGasket = cGasket;
					}
				}	
			}
			if(coCounter==1 && ctCounter==1)
			{
				trace("column t:",ctGasket.position,"o:",currentGasket.position,"o':",coGasket.position);
				if( ctGasket==currentGasket.bottomNode && coGasket==currentGasket.upNode  )		//o'
				{
					super.currentRemovedPieces.push( ChessGasket(colOfGaskets[0]).chessPiece ); //o

				}																			    //t
				//
				if( ctGasket==currentGasket.bottomNode.bottomNode && coGasket==currentGasket.bottomNode  )		//o
				{
					super.currentRemovedPieces.push( ChessGasket(colOfGaskets[0]).chessPiece ); 				//o'

				}																			    				//t
				//
				if( ctGasket==currentGasket.upNode && coGasket==currentGasket.bottomNode  )		//t
				{
					super.currentRemovedPieces.push( ChessGasket(colOfGaskets[0]).chessPiece ); //o

				}																			    //o'
				//
				if( ctGasket==currentGasket.upNode.upNode && coGasket==currentGasket.upNode  )		//t
				{
					super.currentRemovedPieces.push( ChessGasket(colOfGaskets[0]).chessPiece ); 	//o'

				}																			    	//o
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

