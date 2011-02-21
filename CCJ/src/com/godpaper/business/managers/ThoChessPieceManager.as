package com.godpaper.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.consts.DefaultConstants;
	import com.godpaper.impl.ChessPieceManagerBase;
	import com.godpaper.model.ChessGasketsModel;
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.model.vos.PositionVO;
	import com.godpaper.utils.FilterUtil;
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
			var rowOfAllBitboards:Array = chessPiecesModel.allPieces.getRows(conductVO.nextPosition.y);
			var colOfAllBitboards:Array = chessPiecesModel.allPieces.getCols(conductVO.nextPosition.x);
			var rowOfTargetBitboard:Array = [];
			var rowOfOrganizerBitboard:Array = [];
			var colOfTargetBitboard:Array = [];
			var colOfOrganizerBitboard:Array = [];
			var rowOfTargetBitboardNonNull:Array = [];
			var rowOfOrganizerBitboardNonNull:Array = [];
			var colOfTargetBitboardNonNull:Array = [];
			var colOfOrganizerBitboardNonNull:Array = [];
			//
			var currentGasket:ChessGasket = chessGasketModel.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			var rtGasket:ChessGasket;//captured chess gasket.
			var roGasket:ChessGasket//capture organzier gasket in row.
			var ctGasket:ChessGasket;//captured chess gasket.
			var coGasket:ChessGasket//capture organzier gasket in column.
			//
			if (conductVO.target.type == DefaultConstants.BLUE)
			{
				rowOfTargetBitboard = chessPiecesModel.redPieces.getRows(conductVO.nextPosition.y);
				rowOfOrganizerBitboard = chessPiecesModel.bluePieces.getRows(conductVO.nextPosition.y);
				colOfTargetBitboard = chessPiecesModel.redPieces.getCols(conductVO.nextPosition.x);
				colOfOrganizerBitboard = chessPiecesModel.bluePieces.getCols(conductVO.nextPosition.x);
				//
				rowOfTargetBitboardNonNull = chessPiecesModel.redPieces.getRows(conductVO.nextPosition.y).filter(FilterUtil.onNonNull);
				rowOfOrganizerBitboardNonNull = chessPiecesModel.bluePieces.getRows(conductVO.nextPosition.y).filter(FilterUtil.onNonNull);
				colOfTargetBitboardNonNull = chessPiecesModel.redPieces.getCols(conductVO.nextPosition.x).filter(FilterUtil.onNonNull);
				colOfOrganizerBitboardNonNull = chessPiecesModel.bluePieces.getCols(conductVO.nextPosition.x).filter(FilterUtil.onNonNull);
			}else
			{
				rowOfTargetBitboard = chessPiecesModel.bluePieces.getRows(conductVO.nextPosition.y);
				rowOfOrganizerBitboard = chessPiecesModel.redPieces.getRows(conductVO.nextPosition.y);
				colOfTargetBitboard = chessPiecesModel.bluePieces.getCols(conductVO.nextPosition.x);
				colOfOrganizerBitboard = chessPiecesModel.redPieces.getCols(conductVO.nextPosition.x);
				//
				rowOfTargetBitboardNonNull = chessPiecesModel.bluePieces.getRows(conductVO.nextPosition.y).filter(FilterUtil.onNonNull);
				rowOfOrganizerBitboardNonNull = chessPiecesModel.redPieces.getRows(conductVO.nextPosition.y).filter(FilterUtil.onNonNull);
				colOfTargetBitboardNonNull = chessPiecesModel.bluePieces.getCols(conductVO.nextPosition.x).filter(FilterUtil.onNonNull);
				colOfOrganizerBitboardNonNull = chessPiecesModel.redPieces.getCols(conductVO.nextPosition.x).filter(FilterUtil.onNonNull);
			}
			//
			trace("rowOfTargetBitboard:",rowOfTargetBitboard,"rowOfOrganizerBitboard:",rowOfOrganizerBitboard);
			trace("colOfTargetBitboard:",colOfTargetBitboard,"colOfOrganizerBitboard:",colOfOrganizerBitboard);
			trace("rowOfTargetBitboardNonNull:",rowOfTargetBitboardNonNull,"rowOfOrganizerBitboardNonNull:",rowOfOrganizerBitboardNonNull);
			trace("colOfTargetBitboardNonNull:",colOfTargetBitboardNonNull,"colOfOrganizerBitboardNonNull:",colOfOrganizerBitboardNonNull);
			//
			if(rowOfTargetBitboardNonNull.length==1)
			{
				//
				rtGasket = chessGasketModel.gaskets.gett(rowOfTargetBitboard.indexOf(1),conductVO.nextPosition.y) as ChessGasket;
				roGasket = chessGasketModel.gaskets.gett(rowOfOrganizerBitboard.indexOf(1),conductVO.nextPosition.y) as ChessGasket;
				//
				trace("row t:",rtGasket.position,"o:",currentGasket.position,"o':",roGasket.position);
				//
				if(rowOfOrganizerBitboardNonNull.length>=1 && rowOfOrganizerBitboardNonNull.length<3)//insert the right position.//arrange the right position.
				{
					if(rtGasket == currentGasket.rightNode &&  roGasket == currentGasket.leftNode)//o'-o-t
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
					if(rtGasket == currentGasket.rightNode.rightNode &&  roGasket == currentGasket.rightNode)//o-o'-t
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
					if(rtGasket == currentGasket.leftNode &&  roGasket == currentGasket.rightNode)//t-o-o'
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
					if(rtGasket == currentGasket.leftNode.leftNode &&  roGasket == currentGasket.leftNode)//t-o'-o
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
				}
			}
			if(colOfTargetBitboardNonNull.length==1)
			{
				//
				ctGasket = chessGasketModel.gaskets.gett( conductVO.nextPosition.x,colOfTargetBitboard.indexOf(1) ) as ChessGasket;
				coGasket = chessGasketModel.gaskets.gett( conductVO.nextPosition.x,colOfOrganizerBitboard.indexOf(1) ) as ChessGasket;
				//
				trace("column t:",ctGasket.position,"o:",currentGasket.position,"o':",coGasket.position);
				//
				if(colOfOrganizerBitboardNonNull.length>=1 && colOfOrganizerBitboardNonNull.length<3)//insert the right position.//arrange the right position.
				{
					//
					if( ctGasket==currentGasket.bottomNode && coGasket==currentGasket.upNode  )		//o'
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 					//o

					}																			    //t
					//
					if( ctGasket==currentGasket.bottomNode.bottomNode && coGasket==currentGasket.bottomNode  )		//o
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 									//o'

					}																			    				//t
					//
					if( ctGasket==currentGasket.upNode && coGasket==currentGasket.bottomNode  )		//t
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 					//o

					}																			    //o'
					//
					if( ctGasket==currentGasket.upNode.upNode && coGasket==currentGasket.upNode  )		//t
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 						//o'

					}																					//o				
				}
			}

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

