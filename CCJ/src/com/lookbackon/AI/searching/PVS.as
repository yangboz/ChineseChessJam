package com.lookbackon.AI.searching
{
	public class PVS
	{
		/**
		 * Principal variation searching 
		 * Windowing is simple and it is quite good. 
		 * However, windowing is restricted to the root node. 
		 * PVS tries to go a bit further by making assumptions on the alpha-beta window at every node. Here's the basic idea: Since we have gone to a lot of trouble with our move ordering schemes above, we can be pretty confident that we will find the best move early on. Therefore, our localalpha will be at its maximal value after the first few moves. PVS tries to exploit this by calling the next recursion of AlphaBeta with different parameters than standard-AlphaBeta. AlphaBeta would use alpha and beta. In PVS however, we already guess that our current localalpha will be better than what we will get with the remaining moves. Therefore we set alpha to localalpha and beta to localalpha+1, that is, we use a call 
		 * value=-alphabeta(p,d-1,-(localalpha+1),-localalpha);
		 * We expect this call to fail low, because we believe that we have already 
		 * found the best move. If this call does not fail low, 
		 * we need to revise our assumption and call AlphaBeta again 
		 * with the normal alpha and beta bounds.
		 * PVS is also often called NegaScout. 
		 * It gets its name from the scout search which a minimal window,
		 * which sort of probes the territory to see whether a real search is necessary. 
		 * @see http://www.fierz.ch/strategy.htm
		 */		
		public function PVS():void{}
	}
}