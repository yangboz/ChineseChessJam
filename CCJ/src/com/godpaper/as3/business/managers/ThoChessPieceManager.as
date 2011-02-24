package com.godpaper.as3.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.impl.ChessPieceManagerBase;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.FilterUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
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
		 * @inheritDoc
		 * @see http://www.godpaper.com/godpaper/index.php/%E5%85%AD%E5%AD%90%E6%A3%8B
		 */		
		override public function applyMove(conductVO:ConductVO):void
		{
			//TODO:simply this game rule by bitboard magic and algorithem.
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
			var rtGasket:ChessGasket;//captured chess gasket in row.
			var roGasket:ChessGasket;//capture organzier gasket in row.
			var raGasket:ChessGasket;//capture assist gasket in row.
			var ctGasket:ChessGasket;//captured chess gasket in column.
			var coGasket:ChessGasket;//capture organzier gasket in column.
			var caGasket:ChessGasket;//capture assist gasket in column.
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
				roGasket = currentGasket;
				for(var i:int=0;i<rowOfOrganizerBitboardNonNull.length;i++)
				{
					if( conductVO.previousPosition.x != rowOfOrganizerBitboardNonNull[i])
					{
						raGasket = chessGasketModel.gaskets.gett(rowOfOrganizerBitboardNonNull[i],conductVO.nextPosition.y) as ChessGasket;
					}
				}
				raGasket = chessGasketModel.gaskets.gett(rowOfOrganizerBitboard.indexOf(1),conductVO.nextPosition.y) as ChessGasket;
				//
				if(raGasket)
				{
					trace("row t:",rtGasket.position,"o:",roGasket.position,"o':",raGasket.position);
				}
				//
				if(rowOfOrganizerBitboardNonNull.length>=1 && rowOfOrganizerBitboardNonNull.length<3)//insert the right position.//arrange the right position.
				{
					if(rtGasket == roGasket.rightNode &&  raGasket == roGasket.leftNode)//o'-o-t
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
					if(rtGasket == roGasket.rightNode.rightNode &&  raGasket == roGasket.rightNode)//o-o'-t
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
					if(rtGasket == currentGasket.leftNode &&  raGasket == roGasket.rightNode)//t-o-o'
					{
						super.currentRemovedPieces.push( rtGasket.chessPiece );
					}
					if(rtGasket == currentGasket.leftNode.leftNode &&  raGasket == roGasket.leftNode)//t-o'-o
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
				for(var j:int=0;j<colOfOrganizerBitboardNonNull.length;j++)
				{
					if( conductVO.previousPosition.y != colOfOrganizerBitboardNonNull[j])
					{
						caGasket = chessGasketModel.gaskets.gett(conductVO.nextPosition.x,colOfOrganizerBitboardNonNull[j]) as ChessGasket;
					}
				}
				//
				if(caGasket)
				{
					trace("column t:",ctGasket.position,"o:",coGasket.position,"o':",caGasket.position);
				}
				//
				if(colOfOrganizerBitboardNonNull.length>=1 && colOfOrganizerBitboardNonNull.length<3)//insert the right position.//arrange the right position.
				{
					//
					if( ctGasket==currentGasket.bottomNode && caGasket==coGasket.upNode  )		//o'
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 					//o

					}																			    //t
					//
					if( ctGasket==currentGasket.bottomNode.bottomNode && caGasket==coGasket.bottomNode  )		//o
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 									//o'

					}																			    				//t
					//
					if( ctGasket==currentGasket.upNode && caGasket==coGasket.bottomNode  )		//t
					{
						super.currentRemovedPieces.push( ctGasket.chessPiece ); 					//o

					}																			    //o'
					//
					if( ctGasket==currentGasket.upNode.upNode && caGasket==coGasket.upNode  )		//t
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

