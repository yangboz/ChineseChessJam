package com.lookbackon.AI.searching
{
	import com.godpaper.twoHitOne.busniess.managers.PlayerManager;
	import com.godpaper.twoHitOne.model.BoardModel;
	import com.godpaper.twoHitOne.model.PiecesModel;
	import com.godpaper.twoHitOne.vo.ConductVO;
	
	import de.polygonal.ds.Array2;
	
	/**
	 * @author Knight-errant
	 * Search enhancements
	 * All techniques above aimed at reducing the number of nodes to search by better move ordering. 
	 * There is another class of enhancements with the same goal, but with different means. 
	 * These enhancements try to exploit the nature of the AlphaBeta algorithm, 
	 * which has to search fewer nodes when the alpha-beta window is smaller. 
	 */    
	public class AlphaBeta extends SearchingBase
	{
		/**
		 * 
		 * The major improvement over MiniMax/NegaMax is the AlphaBeta algorithm: 
		 * Here you realize that you don't have to go through the whole search tree. 
		 * If you find one winning continuation, you don't have to look at any others. 
		 * Similarly, if you have found one continuation which will give you 
		 * the value V you can stop your search along another continuation 
		 * if you find only one possibility for your opponent 
		 * which gives you a lower score than V. 
		 * You don't have to look at all the other possibilities your opponent
		 *  might have - one refutation is enough! 
		 * Here is the code for AlphaBeta, extending the earlier NegaMax code: 
		 * It receives two extra parameters, alpha and beta. 
		 * They define an interval within which the evaluation has to be. 
		 * If it isn't, the function will return. 
		 * Your first call to AlphaBeta will be with an interval -INFINITY...INFINITY; 
		 * subsequent recursive calls to the function will make the window smaller. 
		 * 
		 * @param position the piece's postion in board.
		 * @param depth the piece's depth in this game tree.
		 * @param alpha INFINITY.
		 * @param beta -INFINITY.
		 * @see http://www.fierz.ch/strategy.htm
		 * 
		 */		
		public function AlphaBeta(gamePosition:Array2,depth:int=5,alpha:int=int.MIN_VALUE,beta:int=int.MAX_VALUE)
		{
			super(gamePosition);
			/*
			function alphabeta(node, depth, α, β)         
			(* β represents previous player best choice - doesn't want it if α would worsen it *)
			    if node is a terminal node or depth = 0
			        return the heuristic value of node
			    foreach child of node
			        α := max(α, -alphabeta(child, depth-1, -β, -α))     
			        (* use symmetry, -β becomes subsequently pruned α *)
			        if β≤α
			            break                             (* Beta cut-off *)
			    return α
			    
			(* Initial call *)
			alphabeta(origin, depth, -infinity, +infinity)
			*/
			//alpha in this twohitone game,the max number of pieces can be killed.
			//beta in this twohitone game,the min number of pieces can be killed. 
			MaxMove(gamePosition,-2,2);
//			AlphaBeta(5,-2,2);
		}
		
		protected function AlphaBeta(depth:int,alpha:int,beta:int):int
		{
				/*
			   int AlphaBeta(int depth, int alpha, int beta) {
			    　if (depth == 0) {
			    　　return Evaluate();
			    　}
			    　GenerateLegalMoves();
			    　while (MovesLeft()) {
			    　　MakeNextMove();
			    　　val = -AlphaBeta(depth - 1, -beta, -alpha);
			    　　UnmakeMove();
			    　　if (val >= beta) {
			    　　　return beta;
			    　　}
			    　　if (val > alpha) {
			    　　　alpha = val;
			    　　}
			    　}
			    　return alpha;
			    }
			    */
			  if(depth==0)
			  {
			  	return doEvaluation(null);
			  }else
			  {
			  	moves = generateMoves(PiecesModel.getInstance().redPiecesCollection,BoardModel.getInstance().gamePosition);
			  	var movesLeft:int = moves.length-1;
			  	trace("movesLeft@AlphaBetaAI:",movesLeft);
			  	var step:int = 0;
			  	while(movesLeft>step)
			  	{
			  		makeNextMove(moves.getItemAt(step) as ConductVO);
			  		var value:int = -AlphaBeta(depth-1,-beta,-alpha);
			  		unmakePreMove(moves.getItemAt(step) as ConductVO);
			  		step++;
			  		if(value>=beta)
			  		{
			  			return beta;
			  		}
			  		if(value>alpha)
			  		{
			  			alpha = value;
			  		}
			  	}
			  } 
			 return alpha;   
		}
		/**
		 * How better does a MinMax with alpha-beta cuttoffs behave when compared with a normal MinMax? 
		 * It depends on the order the search is searched. 
		 * If the way the game positions are generated doesn’t create situations 
		 * where the algorithm can take advantage of alpha-beta cutoffs then the improvements won’t be noticible. 
		 * However, if the evaluation function and the generation of game positions leads to alpha-beta cuttoffs 
		 * then the improvements might be great. 
		 * @param gamePosition
		 * @param alpha
		 * @param beta
		 * @return maxmove's conductVO
		 * 
		 */		
		private function MaxMove (gamePosition:Array2,alpha:int=int.MIN_VALUE,beta:int=int.MAX_VALUE):ConductVO
		{
			/*
			 if (GameEnded(game) || DepthLimitReached()) {
			    return EvalGameState(game, MAX);
			  }
			  else {
			    best_move < - {};
			    moves <- GenerateMoves(game);
			    ForEach moves {
			       move <- MinMove(ApplyMove(game), alpha, beta);
			       if (Value(move) > Value(best_move)) {
			          best_move < - move;
			          alpha <-  Value(move);
			       }
			 
			       // Ignore remaining moves
			       if (beta > alpha)
			         return best_move;
			    }
			    return best_move;
			  }
			 */

			bestMove = new ConductVO();
			moves =  generateMoves(PiecesModel.getInstance().redPiecesCollection,gamePosition);
			if(moves.length<=0)
			{
				PlayerManager.humanWin();//pluge to death.
			}else
			{
				trace("all possbility conducts @ AlphaBetaAI.MaxMove:",moves.toString());
				for(var i:int=0;i<moves.length;i++)
				{
					var conductVO:ConductVO = moves.getItemAt(i) as ConductVO;
					tempMove = MinMove(applyMovement(conductVO),alpha,beta);
					if(doEvaluation(tempMove)>doEvaluation(bestMove))
					{
						bestMove = tempMove;
						alpha = doEvaluation(tempMove);
					}
					 // Ignore remaining moves
					 if(beta>alpha)
					 {
					 	return bestMove;
					 }
				}
			}	
			return bestMove;						   
		}
		/**
		 * 
		 * @param gamePosition
		 * @param alpha
		 * @param beta
		 * @return minmove's conductVO
		 * 
		 */			
		private function MinMove(gamePosition:Array2,alpha:int,beta:int):ConductVO 
		{
			/*if (GameEnded(game) || DepthLimitReached()) {
			    return EvalGameState(game, MIN);
			  }
			  else {
			    best_move < - {};
			    moves <- GenerateMoves(game);
			    ForEach moves {
			       move <- MaxMove(ApplyMove(game), alpha, beta);
			       if (Value(move) > Value(best_move)) {
			          best_move < - move;
			          beta <- Value(move);
			       }
			 
			       // Ignore remaining moves
			       if (beta < alpha)
			         return best_move;
			    }
			    return best_move;
			  }
			*/
			bestMove = new ConductVO();
			moves =  generateMoves(PiecesModel.getInstance().redPiecesCollection,gamePosition);
			if(moves.length<=0)
			{
				PlayerManager.humanWin();//pluge to death.
			}else
			{
				trace("all possbility conducts @ AlphaBetaAI.MinMove:",moves.toString());
				for(var i:int=0;i<moves.length;i++)
				{
					var conductVO:ConductVO = moves.getItemAt(i) as ConductVO;
					tempMove = MaxMove(applyMovement(conductVO),alpha,beta);
					if(doEvaluation(tempMove)>doEvaluation(bestMove))
					{
						bestMove = tempMove;
						beta = doEvaluation(tempMove);
					}
					// Ignore remaining moves
					if(beta<alpha)
					{
						return bestMove;
					}
				}
			}
			return bestMove;
		}
	}
}