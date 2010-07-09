package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.managers.GameManager;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.utils.MathUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;
	
	/**
	 *
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. 
	 * The minimax tree is at the heart of almost every board game program in existence.
	 * 
	 * @author Knight-errant
	 */	
	public class RandomWalk extends SearchingBase
	{
		private static const LOG:ILogger = LogUtil.getLogger(RandomWalk);
		/**
		 * About RandomWalkAI(瞎走)
		 * if(game over in current board position)
		 * return winner
		 * children = all legal moves for player from this board
		 * if(max's turn)
		 * return maximal score of calling minimax on all the children
		 * else (min's turn)
		 * return minimal score of calling minimax on all the children
		 * 
		 */		
		public function RandomWalk(gamePosition:BitBoard) 
		{
			super(gamePosition);
			//
			bestMove = new ConductVO();
			if(orderingMoves.length<=0)
			{
				GameManager.humanWin();//pluge to death.
			}else
			{
				//for test.
				for(var t:int=0;t<orderingMoves.length;t++)
				{
					LOG.debug("moves:#{0},detail:{1}",t.toString(),orderingMoves.getItemAt(t).dump());
				}
				var randomStep:int = MathUtil.transactRandomNumberInRange(0,orderingMoves.length-1);
				LOG.debug("randomStep:{0}",randomStep.toString());
				//evaluation.
				var pValue:int=-1;
				for(var i:int=0;i<orderingMoves.length;i++)
				{
					if(doEvaluation(orderingMoves.getItemAt(i) as ConductVO)>pValue)
					{
						bestMove = orderingMoves.getItemAt(i) as ConductVO;
						pValue = doEvaluation(orderingMoves.getItemAt(i) as ConductVO);
					}
				}
				LOG.debug("randomed bestMove:{0}",bestMove.dump());
				LOG.debug("max position value:{0}",pValue);
				makeMove(bestMove);
			}
		}	
		//return random position value.
		override public function doEvaluation(conductVO:ConductVO):int
		{
			//Todo:doEvaluation about assumpted conductVO;
			var importantValue:int = ChessPiecesConstants[conductVO.target.type].important.gett(conductVO.nextPosition.x,conductVO.nextPosition.y);
			var fuzzyImportValue:int = ChessPiecesConstants[conductVO.target.type].convertedImportant.gett(conductVO.nextPosition.x,conductVO.nextPosition.y);
			//TODO:dynamic omenVO value to be calculated. 
			//precies evaluation value.
			return importantValue+fuzzyImportValue;
			//			return _positionEvaluation;
			//			return Math.random()*100;
			//			return super.doEvaluation(conductVO);
		};
		
	}	
	
}
