package com.lookbackon.AI.searching
{
	import de.polygonal.ds.Array2;
	
	/**
	 * About ShortSightedAI(鼠目寸光)</br>
	 * Cannot see beyond one's nose; </br>
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. </br>
	 * The minimax tree is at the heart of almost every board game program in existence.</br>
	 * 
	 * @author Knight.zhou
	 */	
	public class ShortSighted extends SearchingBase
	{
		/**
		 * ShortSightedAI(鼠目寸光)
		 * 优先选择当前一步最佳着法
		 * @param gamePosition
		 * 
		 */		
		public function ShortSighted(gamePosition:Array2) 
		{
			super(gamePosition);
			//Why named it "ShortSightedAI"？ 
			//cuz this gameAI just only scan the next step and then judgement it.
			//Maybe it is the right choice for the current game status. 
			//
			
			bestMove = new ConductVO();
			moves =  generateMoves(PiecesModel.getInstance().redPiecesCollection,gamePosition);
			if(moves.length<=0)
			{
				PlayerManager.humanWin();//pluge to death.
			}else
			{
				trace("all possbility moves:",moves.toArray().toString());
				
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
				trace("shortSighted bestMove:",bestMove.dump());
				trace("max position value:",pValue);
				makeMove(bestMove);
			}
		}	
	}	
	
}
