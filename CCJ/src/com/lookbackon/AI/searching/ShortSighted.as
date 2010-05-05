package com.lookbackon.AI.searching
{
	import com.godpaper.twoHitOne.busniess.managers.BoardManager;
	import com.godpaper.twoHitOne.busniess.managers.PiecesManager;
	import com.godpaper.twoHitOne.busniess.managers.PlayerManager;
	import com.godpaper.twoHitOne.model.BoardModel;
	import com.godpaper.twoHitOne.model.PiecesModel;
	import com.godpaper.twoHitOne.util.PositionTransactUtil;
	import com.godpaper.twoHitOne.views.components.GasketButton;
	import com.godpaper.twoHitOne.views.components.PieceButton;
	import com.godpaper.twoHitOne.vo.ConductVO;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * About ShortSightedAI(鼠目寸光)
	 * cannot see beyond one's nose; </p>
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. </p>
	 * The minimax tree is at the heart of almost every board game program in existence.</p>
	 * 
	 * @author Knight-errant
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
				applyMovement(bestMove);
			}
		}	
		//
		override public function doEvaluation(conductVO:ConductVO):int
		{
			//TODO: implement function
			//Todo:doEvaluation about assumpted conductVO;
			trace("#####################doEvaluation begin##########################");
			//make next move;
			makeNextMove(conductVO);
			
			//PreSelect some piece:
			PiecesModel.getInstance().selectedPiece = conductVO.target;
				//horizontal analysis
			var hResult:int =  BoardManager.horizontalAnalysis(
					BoardModel.getInstance().gamePosition.getCol(
						conductVO.newPosition[0]
																 ),true).length;
				//vertical analysis
			var vResult:int =  BoardManager.verticalAnalysis(
					BoardModel.getInstance().gamePosition.getRow(
						conductVO.newPosition[1]
																 ),true).length;
			
			
			//Todo:doEvaluation about assumpted conductVO;
			
			//knowlege 01:can kill two negative pieces;
			//knowlege 02:can kill one negative piece;
			//knowlege 03:kill none of negative piece,but next step will better.
			if(hResult+vResult==0)
			{
				//PreSelect some piece:
				PiecesModel.getInstance().selectedPiece = conductVO.target;
					//horizontal analysis
				var hResultPlus:int =  BoardManager.horizontalAnalysis(
						cloneOfGamePosition.getCol(
							conductVO.newPosition[0]
																	 ),true).length;
					//vertical analysis
				var vResultPlus:int =  BoardManager.verticalAnalysis(
						cloneOfGamePosition.getRow(
							conductVO.newPosition[1]
																	 ),true).length;
				//backup gamePosition;
				unmakePreMove(conductVO);	
				trace( "hResult+vResult+hResultPlus+vResultPlus:",hResult+vResult+hResultPlus+vResultPlus);
				trace("#####################doEvaluation end##########################");									 
				return 	hResult+vResult+hResultPlus+vResultPlus;												 
			}
			//knowlege 04:just run away.
			
			//backup gamePosition;
			unmakePreMove(conductVO);
			
			trace( "hResult+vResult:",hResult+vResult);
			trace("#####################doEvaluation end##########################");
			return hResult+vResult;	
		};
		
	}	
	
}
