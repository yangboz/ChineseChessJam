package com.lookbackon.AI.searching
{
	import com.godpaper.twoHitOne.model.BoardModel;
	import com.godpaper.twoHitOne.model.PiecesModel;
	import com.godpaper.twoHitOne.vo.ConductVO;
	
	import de.polygonal.ds.Array2;
	/**
	 * @author Knight-errant
	 */	
	public class NegaMax extends SearchingBase
	{
		 /**
		 * The normal MiniMax code is a bit clumsy, 
		 * since one side is trying to maximize the value and the other 
		 * is trying to minimize - therefore, 
		 * with MiniMax we always have to check if we are the side 
		 * trying to maximize or the side trying to minimize. 
		 * A neat way to get rid of this and to have a simpler function is NegaMax.
		 * With the NegaMax algorithm both sides try to maximize all the time.
		 * NegaMax is identical to MiniMax, it's just a nicer formulation.
		 * 
		 * @param postion the piece's postion in board.
		 * @param depth the piece's depth in this game tree.
		 * 
		 * @see http://www.fierz.ch/strategy.htm
		 */	
		 //You can see that the NegaMax algorithm is shorter and simpler than the MiniMax algorithm.
		 //At first sight, NegaMax is a bit harder to understand than MiniMax, 
		 //but it's in fact much easier to use. 
		 //The side to move is always trying to maximize the value. 
		 //NegaMax is no better or worse than MiniMax - it's identical. 
		 //It's just a better framework to use. 
		public function NegaMax(position:Array2,depth:int)
		{
			/*
			function negamax(node, depth, α, β, color)
		    if node is a terminal node or depth = 0
		        return color * the heuristic value of node
		    else
		        foreach child of node
		            α := max(α, -negamax(child, depth-1, -β, -α, -color))
		            {the following if statement constitutes alpha-beta pruning}
		            if α≥β
		                return α
		        return α
			*/
			/*
			int negamax(POSITION *p, int depth)
			{
			MOVE list[MAXMOVES];
			int i,n,value,bestvalue=-INFINITY;
		
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
				value = -negamax(p,depth-1);
				undomove(&list[i],p);
				bestvalue = max(value,bestvalue);
				}
			return bestvalue;
			}*/
			var best:int = int.MIN_VALUE;
			var val:int; 
			if(depth<=0)
			{
				return doEvaluation();
			}
			moves = generateMoves( PiecesModel.getInstance().redPiecesCollection, BoardModel.getInstance().gamePosition );
			for(var i:int=0;i<moves.length;i++)
			{
				makeNextMove(moves.getItemAt(i));
				val = -NegaMax(BoardModel.getInstance().gamePosition,depth-1);
				unmakePreMove(moves.getItemAt(i));
				if(val>best)
				{
					best = val;
				}
			}
			return best;
		}
		/**
		 * The point is that the call value = -negamax(p,d-1); 
		 * takes care of the signs - or nearly. 
		 * There is one further modification we must make for this code to work: 
		 * The evaluation function must be sensitive to the side to move - for a position with red 
		 * to move it must return its normal evaluation, 
		 * for a position with blue to move it must return -evaluation.  
		 * 
		 * @param conductVO
		 * @return evaluation result
		 * 
		 */		
		override public function doEvaluation(conductVO:ConductVO) : int
		{
			//TODO:
			return -1;
		}
	}
}