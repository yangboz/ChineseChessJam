package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.utils.LogUtil;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;
	
	/**
	 * <b>Search enhancements</b></br>
	 * All techniques above aimed at reducing the number of nodes to search by better move ordering. </br>
	 * There is another class of enhancements with the same goal, but with different means. </br>
	 * These enhancements try to exploit the nature of the AlphaBeta algorithm, 
	 * which has to search fewer nodes when the alpha-beta window is smaller. </br>
	 * 
	 * @see http://www.fierz.ch/strategy1.htm
	 * @author Knight.zhou
	 */    
	public class AlphaBeta extends SearchingBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var localAlpha:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(AlphaBeta);
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
		/**
		 * 
		 * The major improvement over MiniMax/NegaMax is the AlphaBeta algorithm: </br>
		 * Here you realize that you don't have to go through the whole search tree. </br>
		 * If you find one winning continuation, you don't have to look at any others. </br>
		 * Similarly, if you have found one continuation which will give you 
		 * the value V you can stop your search along another continuation 
		 * if you find only one possibility for your opponent 
		 * which gives you a lower score than V. </br>
		 * You don't have to look at all the other possibilities your opponent
		 *  might have - one refutation is enough! </br>
		 * Here is the code for AlphaBeta, extending the earlier NegaMax code: </br>
		 * It receives two extra parameters, alpha and beta. </br>
		 * They define an interval within which the evaluation has to be. </br>
		 * If it isn't, the function will return. </br>
		 * Your first call to AlphaBeta will be with an interval -INFINITY...INFINITY; </br>
		 * subsequent recursive calls to the function will make the window smaller. </br>
		 * 
		 * @param position the piece's postion in board.
		 * @param depth the piece's depth in this game tree.
		 * @param alpha INFINITY.
		 * @param beta -INFINITY.
		 * @see http://www.fierz.ch/strategy.htm
		 * 
		 */		
		public function AlphaBeta(gamePosition:PositionVO,depth:int=5,alpha:int=int.MIN_VALUE,beta:int=int.MAX_VALUE)
		{
			super(gamePosition);
			//
			alphaBeta(gamePosition,depth,alpha,beta);
			//
			this.applyMove(bestMove);
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
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
		private function alphaBeta(gamePosition:PositionVO,depth:int,alpha:int,beta:int):int
		{
			/*int alphabeta(POSITION *p, int depth, int alpha, int beta)
			{
				MOVE list[MAXMOVES];
				int i,n,value,localalpha=alpha,bestvalue=-INFINITY;
				
				if(checkwin(p)) 
					return -INFINITY;
				
				if(depth == 0)	
					return evaluation(p);
				
				n = makemovelist(p,list);
				if(n == 0) 
					return handlenomove(p);
				
				for(i=0; i<n; i++)
				{
					domove(&list[i],p);
					value = -alphabeta(p,d-1,-beta,-localalpha);
					undomove(&list[i],p);
					bestvalue = max(value,bestvalue);
					if(bestvalue>=beta) 
						break;
					if(bestvalue>localalpha) 
						localalpha=bestvalue;
				}
				return bestvalue;
			}*/
			LOG.debug("depth:{0}",depth.toString());
			//
			bestValue = int.MIN_VALUE;
			localAlpha = alpha;
			//
			if(willNoneMove(gamePosition))
			{
				return int.MIN_VALUE;
			}
			//
			if(0==depth)
			{
				return doEvaluation(tempMove,gamePosition);
			}
			//
			if(0==orderingMoves.length)
			{
				return noneMove();
			}
			//
			var len:int = orderingMoves.length;
			LOG.debug("orderingMoves.length:{0}",len);
			//
			for(var i:int=0;i<len/2;i++)
			{
				LOG.debug("current orderingMoves.step:{0}",i.toString());
				makeMove(tempMove);
				tempValue = -alphaBeta(gamePosition,depth-1,-beta,-localAlpha);
				unmakeMove(tempMove);
				bestValue = Math.max(tempValue,bestValue);
				//
				if(bestValue>beta)
				{
					break;
				}
				if(bestValue>localAlpha)
				{
					localAlpha = bestValue;
				}
			}
			LOG.debug("bestValue:{0}",bestValue.toString());
			return bestValue;
		}
	}
}