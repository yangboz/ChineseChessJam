package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.managers.GameManager;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.utils.MathUtil;
	
	import de.polygonal.ds.Array2;
	
	
	/**
	 * MiniMax.as class.   	
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 9, 2010 4:12:01 PM
	 */   	 
	public class MiniMax extends SearchingBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var bestValue:int;
		private var tempValue:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
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
		public function MiniMax(gamePosition:PositionVO,depth:int)
		{
			//TODO: implement function
			super(gamePosition);
			//
			miniMax(gamePosition,depth);
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
		private function miniMax(gamePosition:PositionVO,depth:int):int
		{
			trace("miniMax.depth:",depth);
			if(ChessPieceManager.indicateCheckmate(gamePosition))
			{
				if(gamePosition.color==CcjConstants.FLAG_RED)
				{
					return int.MIN_VALUE;
				}else
				{
					return int.MAX_VALUE;
				}
			}
			if(depth==0)
			{
				return doFullEvaluation(gamePosition);
			}
			if(gamePosition.color==CcjConstants.FLAG_RED)
			{
				bestValue = int.MIN_VALUE;
			}else
			{
				bestValue = int.MAX_VALUE;
			}
			if(gamePosition.color==CcjConstants.FLAG_RED)
			{
				orderingMoves = generateMoves(ChessPiecesModel.getInstance().reds);
				//pluge to death.
				if(0==orderingMoves.length)
				{
					GameManager.computerWin();
				}
			}else
			{
				orderingMoves = generateMoves(ChessPiecesModel.getInstance().blues);
				//pluge to death.
				if(0==orderingMoves.length)
				{
					GameManager.humanWin();
				}
			}
			trace("orderingMoves.length:",orderingMoves.length);
			//
			for(var i:int=0;i<orderingMoves.length;i++)
			{
				//
				makeMove(orderingMoves.getItemAt(i) as ConductVO);
				tempValue = miniMax(ChessPiecesModel.getInstance().gamePosition,depth-1);
				unmakeMove(orderingMoves.getItemAt(i) as ConductVO);
				//
				if(gamePosition.color==CcjConstants.FLAG_RED)
				{
					bestValue = Math.max(tempValue,bestValue);
				}else
				{
					bestValue = Math.min(tempValue,bestValue);
				}
			}
			return bestValue;
		}
		
		private function doFullEvaluation(gamePosition:PositionVO):int
		{
			return MathUtil.transactRandomNumberInRange(int.MIN_VALUE,int.MAX_VALUE);
		}
	}
	
}