package com.lookbackon.AI.searching
{
	import com.lookbackon.ccj.managers.GameManager;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.utils.MathUtil;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.utils.ObjectUtil;

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
		public function RandomWalk(gamePosition:Array2) 
		{
			super(gamePosition);
			/*
			function minimax(node, depth)
		    if node is a terminal node or depth = 0
		        return the heuristic value of node
		    else
		        let α := -∞
		        foreach child of node                       { evaluation is identical for both players }
		            let α := max(α, -minimax(child, depth-1))
		        return α
			*/
			bestMove = new ConductVO();
			moves =  generateMoves( ChessPiecesModel.getInstance().blues,gamePosition);
			if(moves.length<=0)
			{
				GameManager.humanWin();//pluge to death.
			}else
			{
				//for test.
				for(var t:int=0;t<moves.length;t++)
				{
					LOG.debug("moves:#{0},detail:{1}",t.toString(),moves.getItemAt(t).dump());
				}
				var randomStep:int = MathUtil.transactRandomNumberInRange(0,moves.length-1);
				LOG.debug("randomStep:{0}",randomStep.toString());
				//evaluation.
				var pValue:int=-1;
				for(var i:int=0;i<moves.length;i++)
				{
					if(doEvaluation(moves.getItemAt(i) as ConductVO)>pValue)
					{
						bestMove = moves.getItemAt(i) as ConductVO;
						pValue = doEvaluation(moves.getItemAt(i) as ConductVO);
					}
				}
				LOG.debug("randomed bestMove:{0}",bestMove.dump());
				LOG.debug("max position value:{0}",pValue);
				applyMovement(bestMove);
			}
		}	
		//return random position value.
		override public function doEvaluation(conductVO:ConductVO):int
		{
			//Todo:doEvaluation about assumpted conductVO;
			
//			return _positionEvaluation;
			return Math.random()*100;
//			return super.doEvaluation(conductVO);
		};
		
	}	
	
}
