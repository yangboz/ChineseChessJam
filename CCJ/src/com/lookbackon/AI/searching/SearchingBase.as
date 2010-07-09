package com.lookbackon.AI.searching
{
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.lookbackon.AI.evaluation.linear.LinearEvaluationProxy;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	 /**
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. </p>
	 * The minimax tree is at the heart of almost every board game program in existence.</p>
	 * 
	 * @author Knight-errant
	 */	
	public class SearchingBase implements ISearching,IEvaluation
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var bestMove:ConductVO;
		//conductVO's collection;
		protected var tempMove:ConductVO;
		protected var positionEvaluation:int;
		//
		protected var gamePosition:PositionVO;
		protected var evaluation:IEvaluation = new LinearEvaluationProxy();//Notice:this is all kinds of evaluation method entry,should be test.
		
		private var _orderingMoves:ArrayCollection;	
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
		public function SearchingBase(gamePosition:PositionVO)
		{
			//TODO: implement function
			this.gamePosition = gamePosition;
			//init ordering moves.
			this.orderingMoves = generateMoves( ChessPiecesModel.getInstance().blues);
		}
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  moves(native)
		//----------------------------------
		/**
		 * @return all legal moves.
		 */		
		[Deprecated(replacement="com.lookbackon.AI.searching.SearchingBase.orderingMoves")]
		public function get moves():ArrayCollection
		{
			return generateMoves( ChessPiecesModel.getInstance().blues);
		}
		//----------------------------------
		//  orderingMoves(native)
		//----------------------------------
		/**
		 * <b>Ordering Moves To Speed Up Search</b></p>
		 * As we will see next time, search efficiency depends on the order in which moves are searched.</br>  
		 * The gains and losses related to good or poor move ordering are not trivial: </br> 
		 * a good ordering, defined as one which will cause a large number of cutoffs, 
		 * will result in a search tree about the square root of 
		 * the size of the tree associated with the worst possible ordering!</br> 
		 * Unfortunately, it turns out that the best possible ordering is simply defined by trying the best move first.  </br> 
		 * And of course, if you knew which moves are best, you wouldn't be searching in the first place.  </br> 
		 * Still, there are ways to "guess" which moves are more likely to be good than others.  </br> 
		 * For example, you might start with captures, 
		 * pawn promotions (which dramatically change material balance on the board), 
		 * or checks (which often allow few legal responses); </br>
		 * follow with moves which caused recent cutoffs at the same depth in the tree (so-called "killer moves"),</br> 
		 * and then look at the rest.  </br> 
		 * This is the justification for iterative deepening alphabeta, which we will discuss in detail next month,</br> 
		 *  as well as the history table we talked about last time. </br> 
		 * Note that these techniques do not constitute forward pruning: </br> 
		 * all moves will be examined eventually; those which appear bad are only delayed, not eliminated from consideration.</br> 
		 * A final note: in chess, some moves may be illegal because they leave the King in check.  </br> 
		 * However, such an occurrence is quite rare, 
		 * and it turns out that validating moves during generation would cost a tremendous amount of effort.  </br> 
		 * It is more efficient to delay the check until the move is actually searched: </br> 
		 * for example, if capturing the King would be a valid reply to Move X, 
		 * then Move X is illegal and search should be terminated.  </br> 
		 * Of course, if search is cutoff before the move has to be examined, validation never has to take place. </br> 
		 * @see http://www.gamedev.net/reference/articles/article1126.asp
		 * 
		 * @return ordering legal moves,prototype is ArrayCollection.
		 * 
		 */		
		public function get orderingMoves():ArrayCollection
		{
			//TODO:ordering moves by order.
			return _orderingMoves;
		}
		public function set orderingMoves(value:ArrayCollection):void
		{
			_orderingMoves = value;
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
		 * @param pieces chess pieces collection.
		 * @return all possible moves.
		 * 
		 */		
		final public function generateMoves(pieces:ArrayCollection):ArrayCollection
		{
			var resultAC:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<pieces.length;i++)
			{
				var cp:ChessPiece = pieces.getItemAt(i) as ChessPiece;
				for(var c:int=0;c<cp.chessVO.moves.column;c++)
				{
					for(var r:int=0;r<cp.chessVO.moves.row;r++)
					{
						if(cp.chessVO.moves.getBitt(r,c))
						{
							var conductVO:ConductVO = new ConductVO();
							conductVO.target = cp;
							conductVO.previousPosition = conductVO.target.position;
							conductVO.nextPosition = new Point(c,r);
							resultAC.addItem(conductVO);
//							trace("anew ",conductVO.dump());
						}
					}
				}
			}
			return resultAC;
		}
		//----------------------------------
		//  makeMove(native)
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
		final public function makeMove(conductVO:ConductVO):void
		{
			ChessPieceManager.makeMove( conductVO );
		}
		//----------------------------------
		//  unmakeMove(native)
		//----------------------------------
		/**
		 * Unmake preview move,for all kinds of searching tree algorithms.
		 * @param conductVO
		 */		
		final public function unmakeMove(conductVO:ConductVO):void
		{
			ChessPieceManager.unmakeMove();
		}
		//----------------------------------
		//  doEvaluation(virtual)
		//----------------------------------
		/**
		 * The evaluation function will return positive values if the position is good for red and negative values.</br>
		 * if the position is bad for red in the MinMax formulation.</br>
		 * Many things could be said about evaluation functions,</br>
		 * for me,the two main objectives in designing a evaluation function are speed and accuracy.</br>
		 * The faster your evaluation function is,the better is.</br>
		 * and the more accurate its evaluation is,the beeter.</br>
		 * Obviously,these two things are somewhat at odds:</br>
		 * an accurate evaluation function probably is slower than a 'quick-and-dirty' one.</br>
		 * The evaluation function I'm taking about here is a heuristic one -not a exact one.</br>
		 * @see http://www.fierz.ch/strategy1.htm
		 * @param conductVO
		 * @return evaluation result 
		 * 
		 */		
		//virtual functions.
		public function doEvaluation(conductVO:ConductVO):int
		{
			//delegate to evaluation proxy to do evaluation(); 
			return evaluation.doEvaluation(conductVO);
		}
	}
}