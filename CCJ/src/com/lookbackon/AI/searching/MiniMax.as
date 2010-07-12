package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.events.GameEvent;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.managers.GameManager;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.utils.MathUtil;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;
	
	
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
		private var bestConductVO:ConductVO;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(MiniMax);
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
			//
			this.makeMove(bestConductVO);
			//
			CairngormEventDispatcher.getInstance().dispatchEvent(new GameEvent(GameEvent.IS_HUMAN_TURN_NOW));
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
			LOG.debug("miniMax.depth:{0}",depth.toString());
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
				return doEvaluation(bestConductVO);
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
			LOG.debug("orderingMoves.length:{0}",orderingMoves.length);
			//
			for(var i:int=0;i<orderingMoves.length/2;i++)
			{
				//
				LOG.debug("current orderingMoves.step:{0}",i.toString());
				LOG.debug("bestConductVO:{0}",bestConductVO.dump());
				//
				makeMove(bestConductVO);
				tempValue = miniMax(ChessPiecesModel.getInstance().gamePosition,depth-1);
				unmakeMove(bestConductVO);
				//
				if(gamePosition.color==CcjConstants.FLAG_RED)
				{
					bestValue = Math.max(tempValue,bestValue);
					//
					bestConductVO = orderingMoves.getItemAt(i) as ConductVO; 
				}else
				{
					bestValue = Math.min(tempValue,bestValue);
				}
			}
			return bestValue;
		}
		
		private function doFullEvaluation(gamePosition:PositionVO):int
		{
			var result:int = MathUtil.transactRandomNumberInRange(0,100);
			LOG.debug("doFullEvaluation result:{0}",result.toString());
			return result;
		}
	}
	
}