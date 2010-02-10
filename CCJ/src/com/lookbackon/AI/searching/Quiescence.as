package com.lookbackon.AI.searching
{
	import com.godpaper.twoHitOne.busniess.managers.BoardManager;
	import com.godpaper.twoHitOne.busniess.managers.PiecesManager;
	import com.godpaper.twoHitOne.busniess.managers.PlayerManager;
	import com.godpaper.twoHitOne.model.BoardModel;
	import com.godpaper.twoHitOne.model.PiecesModel;
	import com.godpaper.twoHitOne.util.PositionTransactUtil;
	import com.godpaper.twoHitOne.util.NumberUtil;
	import com.godpaper.twoHitOne.views.components.GasketButton;
	import com.godpaper.twoHitOne.views.components.PieceButton;
	import com.godpaper.twoHitOne.vo.ConductVO;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;

	public class Quiescence extends SearchingBase
	{
		/**
		 * Quiescence search 
		 * As I just said above, the basic search algorithm I presented always goes to a fixed depth. 
		 * However, it may often not be a good idea to evaluate a position if it is too chaotic. 
		 * Exactly what too chaotic might mean depends on the game. 
		 * A simple example in chess is a position where white to move is a rook down but can promote a pawn to a queen, 
		 * winning the game. If we were to call our static evaluation function in this position, 
		 * it would (unless it was smart, which evaluation functions usually aren't) conclude that white is dead lost, 
		 * a rook down. Therefore, a technique called quiescence search is often used: Once you want to call your evaluation function, 
		 * you take a look at very few select moves that need to be checked further. You have to make sure that you are very restrictive in your quiescence search, 
		 * otherwise your search tree will explode completely. 
		 * @see http://www.fierz.ch/strategy.htm
		 * 
		 * 静态搜索
		 *　      在国际象棋或其他棋类中，有吃子和不吃子的着法(西洋跳棋、围棋、Fanorano等)，如果有吃子的情况，那么每次吃子时评价都会改变。
		 *  “静态搜索”(Quiescence Search)的思想是，到达主搜索的水平线后，用一个图灵型的搜索只展开吃子(有时是吃子加将军)的着法。
		 *  其他棋类不同于国际象棋，可能只包括一些会很大程度上改变评价的着法。静态搜索还必须包括放弃的着法，来决定停止吃子。
		 *  因此，主Alpha-Beta搜索中每个调用评价函数的地方，都会被一个类似Alpha-Beta的但只搜索吃子着法的函数代替，
		 *  如果当前结点的评价函数足以高出边界，那么就让搜索停下来。
		 *　有人还把将军加入到静态搜索中，但是你要当心，由于没有深度参数，静态搜索会有巨大的结点数。
		 *  吃子通常是有限的(在棋子全部吃完以前你只能有16次子)，而将军可以一直进行下去并导致无限制递归。
		 * 【对于是否展开将军着法的问题，可以尝试一种做法，如果局面被将军，就展开全部着法，即做应将处理，而不对当前局面作评价，参阅“静态搜索”一文。】 
		 * 
		 * */			
		public function Quiescence(gamePosition:Array2):void
		{
			super(gamePosition);
			//prepare moves
			moves =  generateMoves(PiecesModel.getInstance().redPiecesCollection,gamePosition);
			//excute quiesceSearcher
			if(moves.length<=0)
			{
				PlayerManager.humanWin();//pluge to death.
			}else
			{
				quiescence(2,-2,moves.getItemAt(NumberUtil.randomNumberWithScope(0,moves.length-1)) as ConductVO);
			}	
		}
		// 静态搜索
	    // 主Alpha-Beta搜索中，原来出现“eval()”的地方现在调用这个函数
		private function quiescence(alpha:int,beta:int,conductVO:ConductVO):int
		{
//		    quiesce(int alpha, int beta) {
//			    　int score = eval();
//			    　if (score >= beta) {
//			    　　return score;
//			    　}
//			    　for (每个吃子着法 m) {
//			    　　执行着法 m;
//			    　　score = -quiesce(-beta,-alpha);
//			    　　撤消着法 m;
//			    　　if (score >= alpha) {
//			    　　　alpha = score;
//			    　　　if (score >= beta) {
//			    　　　　break;
//			    　　　}
//			    　　}
//			    　}
//			    　return score;
//		     }
		     
			var score:int = doEvaluation(conductVO);
			trace("score@QuiesceSearch:",score);
			if(score>=beta)
			{
				applyMovement(conductVO);
				return score;
			}
			
			for(var i:int=0;i<moves.length;i++)
			{
				trace("all possbility conducts @QuiesceAI.quiesce:",(moves.getItemAt(i) as ConductVO).dump());
				makeNextMove(moves.getItemAt(i) as ConductVO);//执行着法 m;
				score = -quiescence(alpha,beta,moves.getItemAt(i) as ConductVO);
				unmakePreMove(moves.getItemAt(i) as ConductVO);//撤消着法 m;
				if(score>=alpha)
				{
					alpha = score;
					if(score>=beta)
					{
						break;
					}
				}
			}
			applyMovement(conductVO);
			return score;
		}
		
		override public function doEvaluation(conductVO:ConductVO) : int
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
		}
		
	}
}