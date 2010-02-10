package com.lookbackon.AI.searching
{
	import com.godpaper.twoHitOne.busniess.managers.PiecesManager;
	import com.godpaper.twoHitOne.busniess.managers.PlayerManager;
	import com.godpaper.twoHitOne.model.BoardModel;
	import com.godpaper.twoHitOne.model.PiecesModel;
	import com.godpaper.twoHitOne.util.NumberUtil;
	import com.godpaper.twoHitOne.util.PositionTransactUtil;
	import com.godpaper.twoHitOne.views.components.GasketButton;
	import com.godpaper.twoHitOne.views.components.PieceButton;
	import com.godpaper.twoHitOne.vo.ConductVO;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;

	/**
	 *
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. 
	 * The minimax tree is at the heart of almost every board game program in existence.
	 */	
	public class RandomWalk extends SearchingBase
	{
		/**
		 * @author Knight-errant
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
			moves =  generateMoves(PiecesModel.getInstance().redPiecesCollection,gamePosition);
			if(moves.length<=0)
			{
				PlayerManager.humanWin();//pluge to death.
			}else
			{
				trace("all possbility moves:",moves.toArray().toString());
				var randomStep:int = NumberUtil.randomNumberWithScope(0,moves.length-1);
				trace("randomStep:",randomStep);
				var pValue:int=-1;
				for(var i:int=0;i<moves.length;i++)
				{
					if(doEvaluation(moves.getItemAt(i) as ConductVO)>pValue)
					{
						bestMove = moves.getItemAt(i) as ConductVO;
						pValue = doEvaluation(moves.getItemAt(i) as ConductVO);
					}
				}
//				bestMove = moves.getItemAt(randomStep) as ConductVO;
				trace("randomed bestMove:",bestMove);
				trace("max position value:",pValue);
				applyMovement(bestMove);
			}
		}	
		/*
		How long does this(MinMax) algorithm take? 
		For a simple game like tic tac toe, not too long - it is certainly possible to search all possible positions.
		For a game like Chess or Go however, the running time is prohibitively expensive.
		In fact, to completely search either of these games, we would first need to develop interstellar travel, 
		as by the time we finish analyzing a move the sun will have gone nova and the earth will no longer exist. 
		Therefore, all real computer games will search, not to the end of the game, but only a few moves ahead. 
		Of course, now the program must determine whether a certain board position is 'good' or 'bad' for a certainly player. 
		This is often done using an evaluation function. This function is the key to a strong computer game; 
		after all, it does little good to be able to look ahead 20 moves,
		if, after we do, we decide that the position is good for us, when in fact, it is terrible! 
		*/
		override public function doEvaluation(conductVO:ConductVO):int
		{
			//Todo:doEvaluation about assumpted conductVO;
			
//			return _positionEvaluation;
			return Math.random()*100;
		};
		
	}	
	
}
