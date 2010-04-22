package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import de.polygonal.ds.Array2;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	 /**
	 * @author Knight-errant
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. 
	 * The minimax tree is at the heart of almost every board game program in existence.
	 */	
	public class SearchingBase implements ISearchingBase
	{
		protected var bestMove:ConductVO;
		protected var moves:ArrayCollection;//conductVO's collection;
		protected var tempMove:ConductVO;
		protected var positionEvaluation:int;
		protected var gamePosition:Array2;
		/**
		 * To sum up this in one sentence: 
		 * Computers play strategy games by generating 
		 * all possible continuations up to a (more or less) fixed depth 
		 * and evaluating the resulting positions, 
		 * which allows them to choose the best of these continuations. 
		 * 
		 */		
		public function SearchingBase(gamePosition:Array2)
		{
			//TODO: implement function
			mx.core.Application.application.scriptTimeLimit = 30;
			this.gamePosition = gamePosition;
		}
		
		//return all possbility movements;
		/**
		 * This function generates all possible moves and stores them in the arraycollection.
		 * It returns the arraycollection of the legal moves.
		 * @param pieces
		 * @param gamePosition
		 * @return all possible moves
		 * 
		 */		
		public function generateMoves(reds:ArrayCollection, gamePosition:Array2):ArrayCollection
		{
			var resultAC:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<reds.length;i++)
			{
				var conductVO:ConductVO = new ConductVO();
				var cp:ChessPiece = reds.getItemAt(i) as ChessPiece;
				conductVO.target = cp;
				for(var c:int=0;c<cp.chessVO.moves.column;c++)
				{
					for(var r:int=0;r<cp.chessVO.moves.row;r++)
					{
						if(cp.chessVO.moves.getBitt(r,c))
						{
							conductVO.newPosition = new Point(c,y);
							resultAC.addItem(conductVO);
						}
					}
				}
			}
			return resultAC;
		}
		/**
		 * Obviously,the struct move must contain all information necessary to support this operations.
		 * As always,the structures are passed by reference,
		 * in this case it is not only a speed question:
		 * the position will be modified by this functions 
		 * @param conductVO
		 * @return modified gameposition
		 * 
		 */		
		public function applyMovement(conductVO:ConductVO):Array2
		{
			PiecesModel.getInstance().selectedPiece = conductVO.target;
			trace("PiecesModel.getInstance().selectedPiece@GameAIBase.applyMove:",PiecesModel.getInstance().selectedPiece);
			PiecesManager.tryMovement( conductVO.target,conductVO.newDest,conductVO.newPosition );
			return BoardModel.getInstance().gamePosition;
		}
		
		private var previewPiece:PieceButton;//for backup selectedPieceButton;
		protected var cloneOfGamePosition:Array2;//for backup gamePosition;
		/**
		 * Make next move 
		 * @param conductVO
		 */		
		protected function makeNextMove(conductVO:ConductVO):void
		{
			cloneOfGamePosition = BoardModel.getInstance().gamePosition;
			for(var w:int=0;w<cloneOfGamePosition.width;w++)
			{
				for(var h:int=0;h<cloneOfGamePosition.height;h++)
				{
					if( cloneOfGamePosition.gett(w,h)!=null )
					{
						if( (cloneOfGamePosition.gett(w,h) as PieceButton).name==conductVO.target.name )
						{
							previewPiece = cloneOfGamePosition.gett(w,h);//store preview of gamePosition's changed data;
							cloneOfGamePosition.sett(w,h,null);
						}
					}
				}
			}
			cloneOfGamePosition.sett(conductVO.newPosition[0],conductVO.newPosition[1],conductVO.target);
		}
		/**
		 * Unmake preview move 
		 * @param conductVO
		 */		
		protected function unmakePreMove(conductVO:ConductVO):void
		{
			cloneOfGamePosition.sett(conductVO.newPosition[0],conductVO.newPosition[1],null);
			cloneOfGamePosition.sett(previewPiece.pieceVO.position[0],previewPiece.pieceVO.position[1],previewPiece);
		}
		/**
		 * The evaluation function will return positive values if the position is good for red and negative values
		 * if the position is bad for red in the MinMax formulation.
		 * Many things could be said about evaluation functions,
		 * for me,the two main objectives in designing a evaluation function are speed and accuracy.
		 * The faster your evaluation function is,the better is.
		 * and the more accurate its evaluation is,the beeter.
		 * Obviously,these two things are somewhat at odds:
		 * an accurate evaluation function probably is slower than a 'quick-and-dirty' one.
		 * The evaluation function I'm taking about here is a heuristic one -not a exact one.
		 * @see http://www.fierz.ch/strategy1.htm
		 * @param conductVO
		 * @return evaluation result 
		 * 
		 */		
		virtual public function doEvaluation(conductVO:ConductVO):int
		{
			return 0;
		}
	}
}