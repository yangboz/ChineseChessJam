package com.lookbackon.ccj.managers
{
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.model.vo.ChessVOBase;
	import com.lookbackon.ccj.model.vo.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * The chess piece manager manage chess piece move's validation.
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPieceManager
	{
		private static const LOG:ILogger = LogUtil.getLogger(ChessPieceManager);
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * @return current chess piece's move validation result.
		 * 
		 */		
		public static function doMoveValidation(conductVO:ConductVO):Boolean
		{
			var result:Boolean = true;
			//begin:
			LOG.debug("move validate begin at:{0}",new Date().getMilliseconds());
			//chess piece change state(view).
			conductVO.target.agent.getFSM().changeState(conductVO.target.attackState);
			//TODO:
			//chess piece move (logic) check.
			result = doNewPositionValidation(conductVO); 
			//end
			LOG.debug("move validate end at:{0}",new Date().getMilliseconds());
			return result;
		}
		/**
		 * @private 
		 * @param conductVO the objct(which)contains target and new position info.
		 * @return the new position validate result.
		 * 
		 */		
		private static function doNewPositionValidation(conductVO:ConductVO):Boolean
		{
			var chessVO:ChessVOBase = ChessFactory.generateChessPieceVO(conductVO);
			LOG.debug("chessVO:{0}",chessVO.dump());
			LOG.debug("x:{0}||y:{1}",conductVO.newPosition[1],conductVO.newPosition[0]);
			var result:Boolean = Boolean(chessVO.getBitt(conductVO.newPosition[1],conductVO.newPosition[0]));
			LOG.debug("result:{0}",result.toString());
			return result; 
		}
	}
}