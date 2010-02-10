package com.lookbackon.AI.searching
{
	import com.godpaper.twoHitOne.busniess.managers.PiecesManager;
	import com.godpaper.twoHitOne.model.BoardModel;
	import com.godpaper.twoHitOne.model.PiecesModel;
	import com.godpaper.twoHitOne.util.PositionTransactUtil;
	import com.godpaper.twoHitOne.views.components.GasketButton;
	import com.godpaper.twoHitOne.views.components.PieceButton;
	import com.godpaper.twoHitOne.vo.ConductVO;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	 /**
	 * @author Knight-errant
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. 
	 * The minimax tree is at the heart of almost every board game program in existence.
	 */	
	public class SearchingBase implements ISearchingBase
	{
		protected var bestMove:ConductVO;
		protected var moves:ArrayCollection;//conductVO's collection;
		protected var tempMove:ConductVO;
		protected var positionEvaluation:int;
		protected var gamePosition:Array2;
		/**
		 * To sum up this in one sentence: 
		 * Computers play strategy games by generating 
		 * all possible continuations up to a (more or less) fixed depth 
		 * and evaluating the resulting positions, 
		 * which allows them to choose the best of these continuations. 
		 * 
		 */		
		public function SearchingBase(gamePosition:Array2)
		{
			//TODO: implement function
			mx.core.Application.application.scriptTimeLimit = 30;
			this.gamePosition = gamePosition;
		}
		
		//return all possbility movements;
		/**
		 * This function generates all possible moves and stores them in the arraycollection.
		 * It returns the arraycollection of the legal moves.
		 * @param reds
		 * @param gamePosition
		 * @return all possible moves
		 * 
		 */		
		public function generateMoves(reds:ArrayCollection, gamePosition:Array2):ArrayCollection
		{
			trace("#####################Game AI generateMoves begin##########################");
			var tempAC:ArrayCollection = new ArrayCollection();
			var tempGasketButton:GasketButton;
			trace("@generateMoves:",gamePosition.dump());
			for(var i:int=0;i<reds.length;i++)
			{
				var tempMove:ConductVO = new ConductVO();
				tempMove.target = reds.getItemAt(i) as PieceButton;
				trace(tempMove.target.pieceVO.name);	
				trace(tempMove.target.pieceVO.position[0],tempMove.target.pieceVO.position[1]);
				trace(gamePosition.gett( tempMove.target.pieceVO.position[0],tempMove.target.pieceVO.position[1]));
			    if(gamePosition.gett( tempMove.target.pieceVO.position[0],
									  tempMove.target.pieceVO.position[1])!=null)
				{
				    //whether to left
					if( tempMove.target.pieceVO.position[0]%4!=0 && 
						gamePosition.gett( tempMove.target.pieceVO.position[0]-1,tempMove.target.pieceVO.position[1])==null )
					{
						trace(tempMove.target.pieceVO.name,"to left...");
						var leftPosition:Array = [tempMove.target.pieceVO.position[0]-1,tempMove.target.pieceVO.position[1]];
						trace("to leftPosition: ",leftPosition.toString());
						tempGasketButton = (PiecesModel.getInstance().gasketCollection.getItemAt( 
												PositionTransactUtil.transactArray2Index(leftPosition)
										    ) as GasketButton);
						trace("tempGasketButton @ generateMoves: ",tempGasketButton);	
						tempMove.newDest = tempGasketButton.centerPointXY;
						tempMove.newPosition = tempGasketButton.position;
						trace("tempGasketButton(2left) @ generateMoves's position: ",tempGasketButton.position);
						tempAC.addItem(tempMove);				 	
					}
					//whether to top
					if( tempMove.target.pieceVO.position[1]!=0 &&
					    gamePosition.gett( tempMove.target.pieceVO.position[0],tempMove.target.pieceVO.position[1]-1)==null )
					{
						trace(tempMove.target.pieceVO.name,"to top...");
						var topPosition:Array = [tempMove.target.pieceVO.position[0],tempMove.target.pieceVO.position[1]-1];
						trace("to topPosition: ",topPosition.toString());
						tempGasketButton = (PiecesModel.getInstance().gasketCollection.getItemAt( 
												PositionTransactUtil.transactArray2Index(topPosition)
										    ) as GasketButton);
						trace("tempGasketButton @ generateMoves: ",tempGasketButton);	
						tempMove.newDest = tempGasketButton.centerPointXY;
						tempMove.newPosition = tempGasketButton.position;
						trace("tempGasketButton(2top) @ generateMoves's position: ",tempGasketButton.position);
						tempAC.addItem(tempMove);				 	
					}
					//whether to right
					if( tempMove.target.pieceVO.position[0]!=3 &&
					    gamePosition.gett( tempMove.target.pieceVO.position[0]+1,tempMove.target.pieceVO.position[1])==null )
					{
						trace(tempMove.target.pieceVO.name,"to right...");
						var rightPosition:Array = [tempMove.target.pieceVO.position[0]+1,tempMove.target.pieceVO.position[1]];
						trace("to rightPosition: ",rightPosition.toString());
						tempGasketButton = (PiecesModel.getInstance().gasketCollection.getItemAt( 
												PositionTransactUtil.transactArray2Index(rightPosition)
										    ) as GasketButton);
						trace("tempGasketButton @ generateMoves: ",tempGasketButton);	
						tempMove.newDest = tempGasketButton.centerPointXY;
						tempMove.newPosition = tempGasketButton.position;
						trace("tempGasketButton(2right) @ generateMoves's position: ",tempGasketButton.position);
						tempAC.addItem(tempMove);					 	
					}
					//whether to bottom 
					if( tempMove.target.pieceVO.position[1]!=3 && 
						gamePosition.gett( tempMove.target.pieceVO.position[0],tempMove.target.pieceVO.position[1]+1)==null)
					{
						trace(tempMove.target.pieceVO.name,"to bottom...");
						var bottomPosition:Array = [tempMove.target.pieceVO.position[0],tempMove.target.pieceVO.position[1]+1];
						trace("to bottomPosition: ",bottomPosition.toString());
						tempGasketButton = (PiecesModel.getInstance().gasketCollection.getItemAt( 
												PositionTransactUtil.transactArray2Index(bottomPosition)
										    ) as GasketButton);
						trace("tempGasketButton @ generateMoves: ",tempGasketButton);	
						tempMove.newDest = tempGasketButton.centerPointXY;
						tempMove.newPosition = tempGasketButton.position;
						trace("tempGasketButton(2bottom) @ generateMoves's position: ",tempGasketButton.position);
						tempAC.addItem(tempMove);					 	
					}
				}	
			}
			trace("#####################Game AI generateMoves end##########################");
			return tempAC;
		}
		/**
		 * Obviously,the struct move must contain all information necessary to support this operations.
		 * As always,the structures are passed by reference,
		 * in this case it is not only a speed question:
		 * the position will be modified by this functions 
		 * @param conductVO
		 * @return modified gameposition
		 * 
		 */		
		public function applyMovement(conductVO:ConductVO):Array2
		{
			PiecesModel.getInstance().selectedPiece = conductVO.target;
			trace("PiecesModel.getInstance().selectedPiece@GameAIBase.applyMove:",PiecesModel.getInstance().selectedPiece);
			PiecesManager.tryMovement( conductVO.target,conductVO.newDest,conductVO.newPosition );
			return BoardModel.getInstance().gamePosition;
		}
		
		private var previewPiece:PieceButton;//for backup selectedPieceButton;
		protected var cloneOfGamePosition:Array2;//for backup gamePosition;
		/**
		 * Make next move 
		 * @param conductVO
		 */		
		protected function makeNextMove(conductVO:ConductVO):void
		{
			cloneOfGamePosition = BoardModel.getInstance().gamePosition;
			for(var w:int=0;w<cloneOfGamePosition.width;w++)
			{
				for(var h:int=0;h<cloneOfGamePosition.height;h++)
				{
					if( cloneOfGamePosition.gett(w,h)!=null )
					{
						if( (cloneOfGamePosition.gett(w,h) as PieceButton).name==conductVO.target.name )
						{
							previewPiece = cloneOfGamePosition.gett(w,h);//store preview of gamePosition's changed data;
							cloneOfGamePosition.sett(w,h,null);
						}
					}
				}
			}
			cloneOfGamePosition.sett(conductVO.newPosition[0],conductVO.newPosition[1],conductVO.target);
		}
		/**
		 * Unmake preview move 
		 * @param conductVO
		 */		
		protected function unmakePreMove(conductVO:ConductVO):void
		{
			cloneOfGamePosition.sett(conductVO.newPosition[0],conductVO.newPosition[1],null);
			cloneOfGamePosition.sett(previewPiece.pieceVO.position[0],previewPiece.pieceVO.position[1],previewPiece);
		}
		/**
		 * The evaluation function will return positive values if the position is good for red and negative values
		 * if the position is bad for red in the MinMax formulation.
		 * Many things could be said about evaluation functions,
		 * for me,the two main objectives in designing a evaluation function are speed and accuracy.
		 * The faster your evaluation function is,the better is.
		 * and the more accurate its evaluation is,the beeter.
		 * Obviously,these two things are somewhat at odds:
		 * an accurate evaluation function probably is slower than a 'quick-and-dirty' one.
		 * The evaluation function I'm taking about here is a heuristic one -not a exact one.
		 * @see http://www.fierz.ch/strategy1.htm
		 * @param conductVO
		 * @return evaluation result 
		 * 
		 */		
		virtual public function doEvaluation(conductVO:ConductVO):int
		{
			return 0;
		}
	}
}