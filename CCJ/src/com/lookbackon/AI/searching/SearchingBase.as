package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import de.polygonal.ds.Array2;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	 /**
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. </p>
	 * The minimax tree is at the heart of almost every board game program in existence.</p>
	 * 
	 * @author Knight-errant
	 */	
	public class SearchingBase implements ISearchingBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var bestMove:ConductVO;
		protected var moves:ArrayCollection;//conductVO's collection;
		protected var tempMove:ConductVO;
		protected var positionEvaluation:int;
		protected var gamePosition:Array2;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * To sum up this in one sentence: </p>
		 * Computers play strategy games by generating 
		 * all possible continuations up to a (more or less) fixed depth 
		 * and evaluating the resulting positions, </p>
		 * which allows them to choose the best of these continuations. </p>
		 * 
		 */		
		public function SearchingBase(gamePosition:Array2)
		{
			//TODO: implement function
			this.gamePosition = gamePosition;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  generateMoves(native)
		//----------------------------------
		//return all possbility movements;
		/**
		 * This function generates all possible moves and stores them in the arraycollection.</p>
		 * It returns the arraycollection of the legal moves.</p>
		 * @param blues computer's chess pieces type.
		 * @return all possible moves
		 * 
		 */		
		final public function generateMoves(blues:ArrayCollection, gamePosition:Array2):ArrayCollection
		{
			var resultAC:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<blues.length;i++)
			{
				var cp:ChessPiece = blues.getItemAt(i) as ChessPiece;
				for(var c:int=0;c<cp.chessVO.moves.column;c++)
				{
					for(var r:int=0;r<cp.chessVO.moves.row;r++)
					{
						if(cp.chessVO.moves.getBitt(r,c))
						{
							var conductVO:ConductVO = new ConductVO();
							conductVO.target = cp;
							conductVO.newPosition = new Point(c,r);
							resultAC.addItem(conductVO);
//							trace("anew ",conductVO.dump());
						}
					}
				}
			}
			return resultAC;
		}
		//----------------------------------
		//  applyMovement(native)
		//----------------------------------
		/**
		 * Obviously,the struct move must contain all information necessary to support this operations.</p>
		 * As always,the structures are passed by reference,</p>
		 * in this case it is not only a speed question:</p>
		 * the position will be modified by this functions.</p>
		 * @param conductVO
		 * @return modified gameposition
		 * 
		 */		
		final public function applyMovement(conductVO:ConductVO):Array2
		{
			ChessPieceManager.makeMove( conductVO );
			//TODO:
			return new Array2(9,10);
		}
		//----------------------------------
		//  makeNextMove(native)
		//----------------------------------
		private var previewPiece:ChessPiece;//for backup selectedPieceButton;
		protected var cloneOfGamePosition:Array2;//for backup gamePosition;
		/**
		 * Make next move 
		 * @param conductVO
		 */		
		protected function makeNextMove(conductVO:ConductVO):void
		{
			//TODO:
		}
		//----------------------------------
		//  unmakePreMove(native)
		//----------------------------------
		/**
		 * Unmake preview move 
		 * @param conductVO
		 */		
		protected function unmakePreMove(conductVO:ConductVO):void
		{
			cloneOfGamePosition.sett(conductVO.newPosition.x,conductVO.newPosition.y,null);
			cloneOfGamePosition.sett(previewPiece.position.x,previewPiece.position.y,previewPiece);
		}
		//----------------------------------
		//  doEvaluation(virtual)
		//----------------------------------
		/**
		 * The evaluation function will return positive values if the position is good for red and negative values.</p>
		 * if the position is bad for red in the MinMax formulation.</p>
		 * Many things could be said about evaluation functions,
		 * for me,the two main objectives in designing a evaluation function are speed and accuracy.</p>
		 * The faster your evaluation function is,the better is.</p>
		 * and the more accurate its evaluation is,the beeter.</p>
		 * Obviously,these two things are somewhat at odds:
		 * an accurate evaluation function probably is slower than a 'quick-and-dirty' one.</p>
		 * The evaluation function I'm taking about here is a heuristic one -not a exact one.</p>
		 * @see http://www.fierz.ch/strategy1.htm
		 * @param conductVO
		 * @return evaluation result 
		 * 
		 */		
		//virtual functions.
		public function doEvaluation(conductVO:ConductVO):int
		{
			return 0;
		}
	}
}